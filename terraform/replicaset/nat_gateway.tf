resource "aws_eip" "mongodb1_ip" {
  vpc = true
}

resource "aws_nat_gateway" "mongodb1_gw" {
  allocation_id = aws_eip.mongodb1_ip.id
  subnet_id     = aws_subnet.mongodb1_subnet.id

  depends_on = [aws_internet_gateway.gateway1]
}

resource "aws_eip" "mongodb2_ip" {
  vpc = true
}

resource "aws_nat_gateway" "mongodb2_gw" {
  allocation_id = aws_eip.mongodb2_ip.id
  subnet_id     = aws_subnet.mongodb2_subnet.id

  depends_on = [aws_internet_gateway.gateway1]
}

resource "aws_eip" "mongodb3_ip" {
  vpc = true
}

resource "aws_nat_gateway" "mongodb3_gw" {
  allocation_id = aws_eip.mongodb3_ip.id
  subnet_id     = aws_subnet.mongodb3_subnet.id

  depends_on = [aws_internet_gateway.gateway1]
}

resource "aws_eip" "jumphost_ip" {
  vpc = true
}

resource "aws_nat_gateway" "jumphost_gw" {
  allocation_id = aws_eip.jumphost_ip.id
  subnet_id     = aws_subnet.jumphost_subnet.id

  depends_on = [aws_internet_gateway.gateway1]
}
