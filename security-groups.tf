# Data block to grab current IP and add into SG rules
data "http" "current" {
  url = "https://api.ipify.org"
}

# These SG rules need tidying up!
resource "aws_security_group" "allow_all" {
  name        = "Lazy allow all"
  description = "Allow all - DEMO PURPOSES"
  vpc_id      = aws_vpc.barclays_demo_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}