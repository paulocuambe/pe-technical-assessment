# ami-02839d797c7613993

resource "aws_instance" "web" {
  ami           = "ami-02839d797c7613993" # Amazon Linux 2023 x86
  instance_type = "t3.micro"
  subnet_id = aws_subnet.pvt.id

  tags = {
    Name = "Word-Server"
  }
}

