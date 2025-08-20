resource "aws_instance" "web" {
  ami                    = "ami-0847fa6d0e3607474" # Amazon Linux 2
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public.id
  iam_instance_profile   = "SSMInstanceProfile"
  user_data = <<-EOT
              #cloud-config
              write_files:
                - path: /home/ec2-user/.ssh/authorized_keys
                  permissions: '0600'
                  owner: ec2-user:ec2-user
                  content: ${var.ssh_public_key}

              EOT

  tags = {
    Name = "Word-Server"
  }
}

resource "aws_security_group" "web_traffic" {
  name        = "web_traffic_sg"
  description = "Allow inbound web traffic on port 8080 and all outbound traffic"
  vpc_id      = aws_vpc.pvt.id

  ingress {
    description = "Accept all TCP traffic on 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Accept traffic to ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Word-Server-sg"
  }
}

