#security groups configuration
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.main.id

  ingress {
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
}
#alb creation
resource "aws_lb" "new_alb" {
    name             = "my-app-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
   subnets = [
    aws_subnet.public.id, 
    aws_subnet.public_2.id

  ]
  enable_deletion_protection = false


  
}
# alb target group
resource "aws_lb_target_group" "alb_tg" {
     name     = "my-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  
}
resource "aws_lb_target_group_attachment" "instance_attachments" {
  count = 2

  target_group_arn = aws_lb_target_group.alb_tg.arn

  target_id = element([
    aws_instance.public_ec2.id,
    aws_instance.public_ec2_2.id
  ], count.index)

  port = 80
}
 
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.new_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
