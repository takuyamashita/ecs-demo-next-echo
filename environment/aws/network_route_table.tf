###############################################
#
###############################################
resource "aws_route_table" "alb_front_1a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "alb_front_1a"
  }
}

resource "aws_route_table" "alb_front_1c" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "alb_front_1c"
  }
}

###############################################
#
###############################################
resource "aws_route_table" "alb_echo_1a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "alb_echo_1a"
  }
}

resource "aws_route_table" "alb_echo_1c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "alb_echo_1c"
  }
}

###############################################
#
###############################################
resource "aws_route_table" "next_1a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "next_1a"
  }
}

resource "aws_route_table" "next_1c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "next_1c"
  }
}

###############################################
#
###############################################
resource "aws_route_table" "echo_1a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "echo_1a"
  }
}

resource "aws_route_table" "echo_1c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "echo_1c"
  }
}

###############################################
#
###############################################
resource "aws_route_table" "database_1a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "database_1a"
  }
}

resource "aws_route_table" "database_1c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "database_1c"
  }
}

###############################################
#
###############################################
resource "aws_route_table" "endpoint_1a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "endpoint_1a"
  }
}

resource "aws_route_table" "endpoint_1c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "endpoint_1c"
  }
}


###############################################
#
###############################################
resource "aws_route_table" "management_1a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "management_1a"
  }
}

resource "aws_route_table" "management_1c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "management_1c"
  }
}
