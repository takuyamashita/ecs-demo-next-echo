package main

import (
	"context"
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com.takuyamashita/ecs-demo-next-echo/src/echo/demo/ent"
	"github.com.takuyamashita/ecs-demo-next-echo/src/echo/demo/ent/post"
	"github.com.takuyamashita/ecs-demo-next-echo/src/echo/demo/ent/user"
	"github.com/golang-jwt/jwt/v5"
	echojwt "github.com/labstack/echo-jwt/v4"
	"github.com/labstack/echo/v4"

	"github.com/go-sql-driver/mysql"
)

type jwtClaims struct {
	Email string `json:"email"`
	jwt.RegisteredClaims
}

func main() {

	mysqlConfig := mysql.Config{
		User:                 "app",
		Passwd:               "app",
		Net:                  "tcp",
		Addr:                 "db:3306",
		DBName:               "app",
		AllowNativePasswords: true,
		ParseTime:            true,
	}

	client, err := ent.Open("mysql", mysqlConfig.FormatDSN())
	if err != nil {
		log.Fatalf("failed opening connection to mysql: %v", err)
	}
	defer client.Close()

	if err := client.Schema.Create(context.Background()); err != nil {
		log.Fatalf("failed creating schema resources: %v", err)
	}

	e := echo.New()

	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, map[string]string{"message": "Hello, World!"})
	})

	apiv1 := e.Group("/api/v1")

	apiv1.POST("/users", func(c echo.Context) error {

		type User struct {
			Email    string `json:"email"`
			Password string `json:"password"`
		}

		var u User
		if err := c.Bind(&u); err != nil {
			return c.JSON(http.StatusBadRequest, map[string]string{"message": "Invalid request"})
		}

		user, err := client.User.Create().
			SetEmail(u.Email).
			//!!!!!!!!!!! DO NOT RETURN PASSWORD !!!!!!!!!!!
			SetPassword(u.Password).
			Save(context.Background())

		if err != nil {
			log.Printf("failed creating user: %v", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "User not created"})
		}

		return c.JSON(http.StatusCreated, map[string]string{"message": "User created", "id": strconv.Itoa(user.ID)})
	})

	apiv1.POST("/signin", func(c echo.Context) error {
		// use jwt

		type User struct {
			Email    string `json:"email"`
			Password string `json:"password"`
		}

		var u User
		if err := c.Bind(&u); err != nil {
			return c.JSON(http.StatusBadRequest, map[string]string{"message": "Invalid request"})
		}

		user, err := client.User.Query().
			Where(user.Email(u.Email)).
			Where(user.Password(u.Password)).
			Only(context.Background())

		if err != nil {
			log.Printf("failed login: %v", err)
			return c.JSON(http.StatusUnauthorized, map[string]string{"message": "Unauthorized"})
		}

		claims := &jwtClaims{
			Email: u.Email,
			RegisteredClaims: jwt.RegisteredClaims{
				ID:        strconv.Itoa(user.ID),
				ExpiresAt: jwt.NewNumericDate(time.Now().Add(5 * time.Minute)),
			},
		}

		token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
		// !!!!!!! DO NOT USE THIS SECRET IN PRODUCTION !!!!!!!
		t, err := token.SignedString([]byte("secret"))
		if err != nil {
			log.Printf("failed creating token: %v", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Token not created"})
		}

		cookie := new(http.Cookie)
		cookie.Name = "token"
		cookie.Value = t
		cookie.Expires = time.Now().Add(5 * time.Minute)
		cookie.Path = "/"
		c.SetCookie(cookie)

		return c.JSON(http.StatusOK, map[string]string{"message": "Login success", "id": strconv.Itoa(user.ID)})
	})

	apiv1.GET("/posts/:id", func(c echo.Context) error {

		id, _ := strconv.Atoi(c.Param("id"))
		post, err := client.Post.Query().
			Where(post.ID(id)).
			Only(context.Background())

		if err != nil {
			log.Printf("failed getting post: %v", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Post not found"})
		}

		return c.JSON(http.StatusOK, post)
	})

	auth := apiv1.Group("/auth")
	auth.Use(echojwt.WithConfig(echojwt.Config{
		NewClaimsFunc: func(c echo.Context) jwt.Claims {
			return new(jwtClaims)
		},
		TokenLookup: "header:Authorization:Bearer ,cookie:token",
		SigningKey:  []byte("secret"),
	}))

	auth.GET("/me", func(c echo.Context) error {

		claims := c.Get("user").(*jwt.Token).Claims.(*jwtClaims)
		id, _ := strconv.Atoi(claims.ID)
		user, _ := client.User.Query().
			Where(user.ID(id)).
			Only(context.Background())

		//!!!!!!!!!!! DO NOT RETURN PASSWORD !!!!!!!!!!!
		return c.JSON(http.StatusOK, user)
	})

	auth.GET("/me/posts", func(c echo.Context) error {

		claims := c.Get("user").(*jwt.Token).Claims.(*jwtClaims)
		id, _ := strconv.Atoi(claims.ID)

		user, err := client.User.Query().
			Where(user.ID(id)).
			WithPosts().
			Only(context.Background())

		if err != nil {
			log.Printf("failed getting posts: %v", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Posts not found"})
		}

		return c.JSON(http.StatusOK, user.Edges.Posts)
	})

	auth.POST("/me/posts", func(c echo.Context) error {

		claims := c.Get("user").(*jwt.Token).Claims.(*jwtClaims)
		id, _ := strconv.Atoi(claims.ID)
		user, _ := client.User.Query().
			Where(user.ID(id)).
			Only(context.Background())

		type Post struct {
			Title string `json:"title"`
			Body  string `json:"body"`
		}

		var p Post
		if err := c.Bind(&p); err != nil {
			return c.JSON(http.StatusBadRequest, map[string]string{"message": "Invalid request"})
		}

		post, err := client.Post.Create().
			SetTitle(p.Title).
			SetBody(p.Body).
			Save(context.Background())

		user.Update().AddPosts(post).Save(context.Background())

		if err != nil {
			log.Printf("failed creating post: %v", err)
			return c.JSON(http.StatusInternalServerError, map[string]string{"message": "Post not created"})
		}

		return c.JSON(http.StatusCreated, map[string]string{"message": "Post created", "id": strconv.Itoa(post.ID)})
	})

	e.Logger.Fatal(e.Start(":1323"))
}
