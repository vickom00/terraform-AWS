# VPC configuration
resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "main_vpc_public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.5.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public "
  }
}

resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_internet_gateway.id
}

resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.main_vpc_public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_key_pair" "main_auth" {
  key_name   = "auth-key"
  public_key = file("~/.ssh/amikey.pub")
}


