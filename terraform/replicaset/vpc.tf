resource "aws_vpc" "mongodb_replicaset" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = "true"
}
