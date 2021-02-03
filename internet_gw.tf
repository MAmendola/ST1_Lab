resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.st_lab_vpc.id

  tags = {
    Name = "main"
  }
}