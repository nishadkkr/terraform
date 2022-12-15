resource "aws_subnet" "mypublicsubnet" {
  vpc_id                  = aws_vpc.myvpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone #This is what it a public subnet
  cidr_block              = var.public
}

resource "aws_subnet" "myprivatesubnet" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = var.availability_zone
  cidr_block        = var.private

}