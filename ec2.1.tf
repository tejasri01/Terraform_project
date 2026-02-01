resource "aws_instance" "public_ec2_2" {
  ami                         = "ami-0ff5003538b60d5ec" # Amazon Linux 2
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_2.id # replace with your public subnet ID
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true
# Attach user data
  user_data = file("userdata2.sh")



  tags = { Name = "public-ec2_2" }
}



# -------------------------------
# Outputs
# -------------------------------
output "ec2_public_ip_2" {
  value = aws_instance.public_ec2_2.public_ip
}