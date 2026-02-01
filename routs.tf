#public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id

  }
  tags = {
    Name = "public_rt"

  }


}
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id

}

#private route
resource "aws_route_table" "public_rt_1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id

  }
  tags = {
    Name = "public_rt_1"

  }


}
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_rt_1.id

}