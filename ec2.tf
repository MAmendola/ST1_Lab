resource "aws_instance" "example" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [security_group.instance_sg.id, security_group.ssh.id]

  user_data            = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd.service
              sudo systemctl enable httpd.service
              sudo echo "<h1> At $(hostname -f) </h1>" > /var/www/html/index.html                   
              EOF
  tags                 = local.common_tags
  key_name             = var.key_name
  iam_instance_profile = aws_iam_instance_profile.test_profile.id
}