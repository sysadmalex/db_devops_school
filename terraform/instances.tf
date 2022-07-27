resource "aws_key_pair" "key" {
  key_name = "key"
  public_key = file("~/.ssh/id_rsa.pub")
}
  
resource "aws_instance" "master" {
  ami           = var.ubuntu_22_04
  instance_type = "t2.micro"

key_name = aws_key_pair.key.key_name

vpc_security_group_ids = [
  aws_security_group.db_servers_sg.id
]

  tags = {
    Name = "master"
  }
}

resource "aws_instance" "replica" {
  ami           = var.ubuntu_22_04
  instance_type = "t2.micro"

key_name = aws_key_pair.key.key_name

vpc_security_group_ids = [
  aws_security_group.db_servers_sg.id
]

  tags = {
    Name = "replica"
  }
}

resource "aws_instance" "web" {
  ami           = var.ubuntu_22_04
  instance_type = "t2.micro"

key_name = aws_key_pair.key.key_name

vpc_security_group_ids = [
  aws_security_group.web_server_sg2.id
]

  tags = {
    Name = "web-2"
  }
}
