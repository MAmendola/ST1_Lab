variable "image_id" {
  description = "This variable contains image id"
  type        = string
  default     = "ami-09d95fab7fff3776c"
}

variable "instance_type" {
  type        = string
  description = "This is my instanc type"
  default = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Name of ssh key"
  default = "my-key"
}

variable "ec2_tags" {
  type = map
  default  = { 
  Name = "terraform-example"
  Environment = "dev"
}
