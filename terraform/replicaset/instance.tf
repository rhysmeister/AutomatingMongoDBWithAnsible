resource "aws_instance" "mongodb" {
    ami                    = var.ami
    instance_type          = var.instance_type
    count                  = var.mongodb_instance_count
    availability_zone      = var.av_zones[count.index - 1]
    vpc_security_group_ids = [aws_security_group.mongodb.id]
    key_name               = var.key_name

    tags = {
        Name = "mongodb${count.index}"
    }
}

resource "aws_instance" "jumphost" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.jumphost_subnet.id
  vpc_security_group_ids      = [aws_security_group.jumphost.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  tags = {
      Name = "jumphost"
  }
       
}