# Database configuration
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"
  username             = "foo"
  password             = "foobarbaz"
 # parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

resource "random_password" "password" {
  length = 20
  special = false
  override_special = "_%@"
}
resource "aws_db_instance" "test_db" {
  allocated_storage    = 20
  engine               = "postgres"
  identifier           =  "dev-db"     
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  db_name              = "ntweeklydb001"
  username             = "dbadmin1"
  password             = random_password.password.result
  skip_final_snapshot  = true
  publicly_accessible  = true

}