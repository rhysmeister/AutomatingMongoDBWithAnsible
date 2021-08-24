resource "aws_vpc" "mongodb_standalone" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = "true"
}
