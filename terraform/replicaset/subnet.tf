resource "aws_subnet" "jumphost_subnet" {
  vpc_id     = aws_vpc.mongodb_replicaset.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "jumphost"
  }
}

resource "aws_subnet" "mongodb1_subnet" {
  vpc_id     = aws_vpc.mongodb_replicaset.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.av_zones[0]

  tags = {
    Name = "mongodb1"
  }
}

resource "aws_subnet" "mongodb2_subnet" {
  vpc_id     = aws_vpc.mongodb_replicaset.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.av_zones[1]

  tags = {
    Name = "mongodb2"
  }
}

resource "aws_subnet" "mongodb3_subnet" {
  vpc_id     = aws_vpc.mongodb_replicaset.id
  cidr_block = "10.0.4.0/24"
  availability_zone = var.av_zones[2]

  tags = {
    Name = "mongodb3"
  }
}