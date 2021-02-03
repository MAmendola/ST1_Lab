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

resource "aws_eip" "bar" {
  vpc = true

  instance                  = aws_instance.ec2_st1_lab.id
  
  depends_on                = [aws_internet_gateway.internet-gw]
}


