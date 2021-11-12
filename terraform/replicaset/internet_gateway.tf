resource "aws_internet_gateway" "gateway1" {
  vpc_id = aws_vpc.mongodb_replicaset.id
}
