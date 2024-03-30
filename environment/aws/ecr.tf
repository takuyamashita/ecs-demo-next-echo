resource "aws_ecr_repository" "next" {
  name                 = "next"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "next"
  }
}

resource "aws_ecr_repository" "echo" {
  name                 = "echo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "echo"
  }
}