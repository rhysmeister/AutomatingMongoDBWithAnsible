resource "aws_instance" "mongodb" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.mongodb.id
  vpc_security_group_ids = [aws_security_group.mongodb.id]
  key_name               = var.key_name

  tags = {
    name = "mongodb"
  }
}

resource "aws_instance" "jumphost" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.jumphost.id
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
    name = "jumphost"
  }
}
