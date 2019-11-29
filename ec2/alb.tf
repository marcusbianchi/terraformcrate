resource "aws_alb" "ec2-alb" {
  name            = "ec2-alb"
  subnets         = [aws_subnet.crate_public_sn_01.id,aws_subnet.crate_public_sn_02.id]
  security_groups = [aws_security_group.crate_public_sg.id]
  ip_address_type = "ipv4"


  tags = {
    "Name" : "ec2-alb",
  }
}

resource "aws_alb_listener" "ec2-alb-4200" {
  load_balancer_arn = aws_alb.ec2-alb.arn
  port              = 4200
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tf_tg.arn
  }
}

resource "aws_alb_target_group" "tf_tg" {
  name        = "terraform-ec2-nodes"
  port        = 4200
  protocol    = "HTTP"
  vpc_id      = aws_vpc.crateVPC.id
  target_type = "instance"
}
