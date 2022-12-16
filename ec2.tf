# Public EC2 instance
resource "aws_instance" "public_ec2" {
  ami                         = "ami-0ecc74eca1d66d8a6"
  instance_type               = var.instance_type
  key_name                    = "terraform"
  security_groups             = [aws_security_group.public_sec_grp.id]
  subnet_id                   = aws_subnet.mypublicsubnet.id
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = ""
    timeout     = "4m"
  }
  tags = {
    Name : "Public"
  }
}

# Private EC2 instance
resource "aws_instance" "private_ec2" {
  ami                         = "ami-0ecc74eca1d66d8a6"
  instance_type               = "t2.micro"
  key_name                    = "terraform"
  subnet_id                   = aws_subnet.myprivatesubnet.id
  vpc_security_group_ids      = [aws_security_group.private_sec_grp.id]
  associate_public_ip_address = false

  tags = {
    Name : "Private"
  }
}