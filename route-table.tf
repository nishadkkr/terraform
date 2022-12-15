# Route table for public Subnet
resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
}
# Route table for private Subnet
resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW.id
  }
}
# Assosiate the public RT with public subnets
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id      = aws_subnet.mypublicsubnet.id
  route_table_id = aws_route_table.PublicRT.id
}
# Assosiate the public RT with private subnets
resource "aws_route_table_association" "PrivateRTassociation" {
  subnet_id      = aws_subnet.myprivatesubnet.id
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_security_group" "public_sec_grp" {
  vpc_id = aws_vpc.myvpc.id
  name   = "my public vpc security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Do not use this in production, should be limited to our own IP
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name : "Public security group"
  }
}

resource "aws_security_group" "private_sec_grp" {
  vpc_id = aws_vpc.myvpc.id
  name   = "my private vpc security group"

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name : "Private security group"
  }

}
