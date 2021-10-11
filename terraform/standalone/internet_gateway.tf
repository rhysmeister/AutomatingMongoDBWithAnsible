resource "aws_internet_gateway" "gateway1" {
  vpc_id = aws_vpc.mongodb_standalone.id
}

resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.mongodb_standalone.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway1.id
  }
}

resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.mongodb_standalone.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat1.id
  }
}

resource "aws_route_table_association" "route-subnet1" {
  subnet_id      = aws_subnet.jumphost.id
  route_table_id = aws_route_table.route_table1.id
}

resource "aws_route_table_association" "route-subnet2" {
  subnet_id      = aws_subnet.mongodb.id
  route_table_id = aws_route_table.route_table2.id
}
