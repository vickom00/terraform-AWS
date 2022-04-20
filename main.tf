# Instance configuration
resource "aws_instance" "web" {
  ami           = var.my_image
  instance_type = var.inst_type
  key_name = "EC2 Tutorial"
  security_groups = [aws_security_group.terra_sg.name]
  tags = {
    Name = "Terraform-EC2"
  }
}

# Security group configuration
resource "aws_security_group" "terra_sg" {
  name        = "allow_tls_port"
  description = "Allow inbound traffic ports"

  ingress {
    description      = "Custom SG"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
    ingress {
    description      = "Custom SG2"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# Database
module "my_database" {
  source = "./modules/database"
}

# VPC
module "my_vpc" {
  source = "./modules/vpc"
  cidr_block = "10.5.0.0/16 "
} 