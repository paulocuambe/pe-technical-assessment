# ami-02839d797c7613993

resource "aws_instance" "web" {
  ami           = "ami-02839d797c7613993" # Amazon Linux 2023 x86
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public.id
  user_data = <<EOF
    #cloud-config
	users:
		- name: ssm-user
		  sudo: ALL(ALL) NOPASSWD:ALL # priviledge escalation without password
		  ssh_authorized_keys:
		  - ssh-rsa ${var.ssh_public_key}
  EOF

  tags = {
    Name = "Word-Server"
  }
}

