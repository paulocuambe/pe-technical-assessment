resource "aws_instance" "web" {
  ami                    = "ami-02839d797c7613993" # Amazon Linux 2023 x86
  instance_type          = "t3.small"
  subnet_id              = aws_subnet.public.id
  iam_instance_profile   = "SSMInstanceProfile"
  user_data = <<-EOT
              #cloud-config
              users:
                - name: ssm-user
                  sudo: ALL=(ALL) NOPASSWD:ALL
                  shell: /bin/bash
                  ssh_authorized_keys:
                    - ${var.ssh_public_key}
              EOT
  vpc_security_group_ids = tolist([aws_security_group.web_traffic.id])

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

