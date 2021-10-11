resource "aws_eip" "ip" {
  vpc = true
}

resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.jumphost.id

  depends_on = [aws_internet_gateway.gateway1]
}
