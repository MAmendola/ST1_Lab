
# Public Subnets-----------------------------------------------------

resource "aws_subnet" "st_lab_subnet_1" {
  vpc_id     = aws_vpc.st_lab_vpc.id
  cidr_block = "172.31.1.0/24"

  tags = {
    Name = "Public Subnet 1"
  }

  availability_zone = "us-east-1a" # AZ-1

}

resource "aws_subnet" "st_lab_subnet_2" {
  vpc_id     = aws_vpc.st_lab_vpc.id
  cidr_block = "172.31.2.0/24"

  tags = {
    Name = "Public Subnet 2"
  }
  
  availability_zone = "us-east-1b" # AZ-2

}


# Private Subnets-----------------------------------------------------

resource "aws_subnet" "st_lab_subnet_3" {
  vpc_id     = aws_vpc.st_lab_vpc.id
  cidr_block = "172.31.3.0/24"

  tags = {
    Name = "Private Subnet 1"
  }

  availability_zone = "us-east-1a" # AZ-1

}

resource "aws_subnet" "st_lab_subnet_4" {
  vpc_id     = aws_vpc.st_lab_vpc.id
  cidr_block = "172.31.4.0/24"

  tags = {
    Name = "Private Subnet 2"
  }
  
  availability_zone = "us-east-1b" # AZ-2

}

# Subnet_Group for AWS_RDS

# resource "aws_db_subnet_group" "default" {
#   name       = "main"
#   subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

#   tags = {
#     Name = "My DB subnet group"
#   }
# }