


# VPC ----------------------------------------------------------------

resource "aws_vpc" "st_lab_vpc" {
  cidr_block = "172.31.0.0/16"

   tags = {
    Name = "ST1_VPC"
  }
}

# subnets -----------------------------------------------------------------



resource "aws_subnet" "st_lab_subnet_1" {           # Public Subnets
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



resource "aws_subnet" "st_lab_subnet_3" {        # Private Subnets
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




# EC2 -----------------------------------------------------------------------------------------------
resource "aws_instance" "ec2_st1_lab" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  

  subnet_id = aws_subnet.st_lab_subnet_3.id #subnet where it will be placed

  associate_public_ip_address = true

  availability_zone = "us-east-1a"

  user_data            = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd.service
              sudo systemctl enable httpd.service
              sudo echo "<h1> At $(hostname -f) </h1>" > /var/www/html/index.html                   
              EOF
  #tags                 = local.common_tags    # for tags
  key_name             = var.key_name
  #iam_instance_profile = aws_iam_instance_profile.test_profile.id
}

# Elastic IP -------------------------------------------------------------------------------------

resource "aws_eip" "bar" {
  vpc = true

  instance                  = aws_instance.ec2_st1_lab.id
  
  depends_on                = [aws_internet_gateway.internet-gw]
}

# Internet Gateway ------------------------------------------------------------------------------

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.st_lab_vpc.id

  tags = {
    Name = "main"
  }
}