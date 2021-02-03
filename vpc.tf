resource "aws_vpc" "st_lab_vpc" {
  cidr_block = "172.31.0.0/16"

   tags = {
    Name = "ST1_VPC"
  }
}