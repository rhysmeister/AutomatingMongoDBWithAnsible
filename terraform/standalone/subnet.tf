resource "aws_subnet" "mongodb" {
  vpc_id     = aws_vpc.mongodb_standalone.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "mongodb"
  }
}

resource "aws_subnet" "jumphost" {
  vpc_id     = aws_vpc.mongodb_standalone.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "jumphost"
  }
}
