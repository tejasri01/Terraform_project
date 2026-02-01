# -------------------------------
# Key Pair
# -------------------------------
resource "aws_key_pair" "ec2_key" {
  key_name   = "terraform-ec2-key"
  public_key = file("C:/Users/Tejasri/.ssh/terraform-ec2.pub")
}

# -------------------------------
# Security Group
# -------------------------------
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-java-sg"
  description = "Allow SSH and Java Web App"
  vpc_id      = aws_vpc.main.id # replace with your VPC ID

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Java Web App HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "ec2-java-sg" }
}

# -------------------------------
# Public EC2 Instance
# -------------------------------
resource "aws_instance" "public_ec2" {
  ami                         = "ami-0ff5003538b60d5ec" # Amazon Linux 2
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id # replace with your public subnet ID
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  key_name                    = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true
# Attach user data
  user_data = file("user_data.sh")



  tags = { Name = "public-ec2" }
}

# -------------------------------
# Outputs
# -------------------------------
output "ec2_public_ip" {
  value = aws_instance.public_ec2.public_ip
}
