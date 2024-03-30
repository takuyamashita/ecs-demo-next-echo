package main

import (
	"log"
	"os"
	"strconv"
)

type EnvVar struct {
	DBUser     string
	DBPassword string
	DBHost     string
	DBPort     uint
	DBName     string
}

var envVar = (*EnvVar)(nil)

func init() {
	envVar = &EnvVar{}

	if envVar.DBUser = os.Getenv("DB_USER"); envVar.DBUser == "" {
		log.Fatalf("DB_USER is not set")
	}

	if envVar.DBPassword = os.Getenv("DB_PASSWORD"); envVar.DBPassword == "" {
		log.Fatalf("DB_PASSWORD is not set")
	}

	if envVar.DBHost = os.Getenv("DB_HOST"); envVar.DBHost == "" {
		log.Fatalf("DB_HOST is not set")
	}

	if envVar.DBName = os.Getenv("DB_NAME"); envVar.DBName == "" {
		log.Fatalf("DB_NAME is not set")
	}

	dbPort := os.Getenv("DB_PORT")
	if dbPort == "" {
		log.Fatalf("DB_PORT is not set")
	}

	dbPortNum, err := strconv.Atoi(dbPort)
	if err != nil {
		log.Fatalf("DB_PORT is not a number")
	}
	envVar.DBPort = uint(dbPortNum)
}
