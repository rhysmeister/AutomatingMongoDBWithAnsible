resource "aws_instance" "mongodb" {
    ami                    = var.ami
    instance_type          = var.instance_type
    count                  = var.mongodb_instance_count
    availability_zone      = var.av_zones[count.index - 1]
    vpc_security_group_ids = [aws_security_group.mongodb.id]
    key_name               = var.key_name

    root_block_device {
      volume_size = 20
      volume_type = "gp2"
    }

    tags = {
        Name = "${format("mongodb%02d", count.index)}"
        ansible_groups = "mongodb"
    }
}

resource "aws_ebs_volume" "mongodb_data" {
  count             = var.mongodb_instance_count
  availability_zone = var.av_zones[count.index - 1]
  size              = var.mongodb_data_volume["size"]
  type              = var.mongodb_data_volume["type"]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_volume_attachment" "mongodb_data_attachment" {
  device_name = "/dev/sdb"
  count       = var.mongodb_instance_count
  volume_id   = aws_ebs_volume.mongodb_data.*.id[count.index]
  instance_id = aws_instance.mongodb.*.id[count.index]
}

resource "aws_instance" "jumphost" {
  ami                         = var.ami
  instance_type               = var.instance_type
  count                       = var.jumphost_instance_count
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
      ansible_groups = "jumphost"
  }
       
}