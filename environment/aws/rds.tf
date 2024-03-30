resource "aws_db_instance" "main" {
  allocated_storage           = 10
  db_name                     = "mydb"
  engine                      = var.db_engine
  engine_version              = var.db_engine_version
  instance_class              = var.db_instance
  username                    = "foo"
  manage_master_user_password = true
  parameter_group_name        = "default.mysql8.0"
  db_subnet_group_name        = aws_db_subnet_group.main.name
  vpc_security_group_ids      = [aws_security_group.database.id]
  skip_final_snapshot         = true
  publicly_accessible         = false
  multi_az                    = true

  identifier_prefix = "mydb-"

  apply_immediately   = true
  deletion_protection = false
}

resource "aws_db_subnet_group" "main" {
  name_prefix = "mydb-"
  subnet_ids  = [aws_subnet.database_1a.id, aws_subnet.database_1c.id]
}

# data "aws_secretsmanager_secret" "db_password" {
#   name = "PRODUCTION"
# 
#   depends_on = [aws_secretsmanager_secret_version.db_password]
# }
# 
# data "aws_secretsmanager_secret_version" "db_password" {
#   secret_id = data.aws_secretsmanager_secret.db_password.id
# }
# 
# ###############################################
# # In Real Application, We register MANUALLY
# ###############################################
# resource "aws_secretsmanager_secret" "db_password" {
#   name = "PRODUCTION"
# }
# 
# resource "aws_secretsmanager_secret_version" "db_password" {
#   secret_id = aws_secretsmanager_secret.db_password.id
#   secret_string = jsonencode({
#     db_password = "password"
#   })
# }
# 