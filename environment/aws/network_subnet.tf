###############################################
#
###############################################
resource "aws_subnet" "alb_front_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 0)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "alb_front_1a"
  }
}

resource "aws_route_table_association" "alb_front_1a" {
  subnet_id      = aws_subnet.alb_front_1a.id
  route_table_id = aws_route_table.alb_front_1a.id
}

resource "aws_subnet" "alb_front_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 1)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "alb_front_1c"
  }
}

resource "aws_route_table_association" "alb_front_1c" {
  subnet_id      = aws_subnet.alb_front_1c.id
  route_table_id = aws_route_table.alb_front_1c.id
}

###############################################
#
###############################################
resource "aws_subnet" "alb_echo_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 2)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "alb_echo_1a"
  }
}

resource "aws_route_table_association" "alb_echo_1a" {
  subnet_id      = aws_subnet.alb_echo_1a.id
  route_table_id = aws_route_table.alb_echo_1a.id
}

resource "aws_subnet" "alb_echo_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 3)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "alb_echo_1c"
  }
}

resource "aws_route_table_association" "alb_echo_1c" {
  subnet_id      = aws_subnet.alb_echo_1c.id
  route_table_id = aws_route_table.alb_echo_1c.id
}

###############################################
#
###############################################
resource "aws_subnet" "next_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 10)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "next_1a"
  }
}

resource "aws_route_table_association" "next_1a" {
  subnet_id      = aws_subnet.next_1a.id
  route_table_id = aws_route_table.next_1a.id
}

resource "aws_subnet" "next_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 11)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "next_1c"
  }
}

resource "aws_route_table_association" "next_1c" {
  subnet_id      = aws_subnet.next_1c.id
  route_table_id = aws_route_table.next_1c.id
}

###############################################
#
###############################################
resource "aws_subnet" "echo_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 20)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "echo_1a"
  }
}

resource "aws_route_table_association" "echo_1a" {
  subnet_id      = aws_subnet.echo_1a.id
  route_table_id = aws_route_table.echo_1a.id
}

resource "aws_subnet" "echo_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 21)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "echo_1c"
  }
}

resource "aws_route_table_association" "echo_1c" {
  subnet_id      = aws_subnet.echo_1c.id
  route_table_id = aws_route_table.echo_1c.id
}


###############################################
#
###############################################
resource "aws_subnet" "database_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 30)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "database_1a"
  }
}

resource "aws_route_table_association" "database_1a" {
  subnet_id      = aws_subnet.database_1a.id
  route_table_id = aws_route_table.database_1a.id
}

resource "aws_subnet" "database_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 31)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "database_1c"
  }
}

resource "aws_route_table_association" "database_1c" {
  subnet_id      = aws_subnet.database_1c.id
  route_table_id = aws_route_table.database_1c.id
}

###############################################
#
###############################################
resource "aws_subnet" "endpoint_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 40)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "endpoint_1a"
  }
}

resource "aws_route_table_association" "endpoint_1a" {
  subnet_id      = aws_subnet.endpoint_1a.id
  route_table_id = aws_route_table.endpoint_1a.id
}

resource "aws_subnet" "endpoint_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 41)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "endpoint_1c"
  }
}

resource "aws_route_table_association" "endpoint_1c" {
  subnet_id      = aws_subnet.endpoint_1c.id
  route_table_id = aws_route_table.endpoint_1c.id
}

###############################################
#
###############################################
resource "aws_subnet" "management_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 50)
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "management_1a"
  }
}

resource "aws_route_table_association" "management_1a" {
  subnet_id      = aws_subnet.management_1a.id
  route_table_id = aws_route_table.management_1a.id
}

resource "aws_subnet" "management_1c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, 51)
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "management_1c"
  }
}

resource "aws_route_table_association" "management_1c" {
  subnet_id      = aws_subnet.management_1c.id
  route_table_id = aws_route_table.management_1c.id
}
