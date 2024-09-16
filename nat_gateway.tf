resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)
  
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  
  tags = {
    Name = "nat-gateway-${count.index}"
  }
}
