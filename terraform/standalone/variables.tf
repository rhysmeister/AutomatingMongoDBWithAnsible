variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "eu-central-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "mongodb_port" {
  default = 27017
}

variable "key_name" {
  default = "tf_key"
}

variable "private_key_path" {
  default = "~/.ssh/tf_key.pem"
}

output "public-dns" {
  value = aws_instance.jumphost.public_dns
}
