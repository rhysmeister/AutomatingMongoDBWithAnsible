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

variable "av_zones" {
  type = list
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "ami" {
  default = "ami-02241e4f36e06d650"
}

variable "mongodb_instance_count" {
  default = 5
}

variable "jumphost_instance_count" {
  default = 1
}

variable "mongodb_data_volume" {
  type = map
  default = {
    size = 20
    type = "gp2"
  }
}

output "public-dns" {
  value = aws_instance.jumphost[*].public_dns
}
