data "aws_vpc" "default_vpc_data" {
  default = true
}

resource "aws_security_group" "db_servers_sg" {
  name        = "db_server_sg"
  vpc_id      = data.aws_vpc.default_vpc_data.id



  tags = {
    Name = "db_server_sg"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_servers_sg.id
}

resource "aws_security_group_rule" "allow_mysql" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.default_vpc_data.cidr_block]
  security_group_id = aws_security_group.db_servers_sg.id
}

resource "aws_security_group_rule" "allow_all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db_servers_sg.id
}


resource "aws_security_group" "web_server_sg2" {
  name        = "web_server_sg2"
  vpc_id      = data.aws_vpc.default_vpc_data.id

  tags = {
    Name = "web_server_sg2"
  }
}

resource "aws_security_group_rule" "allowssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server_sg2.id
}

resource "aws_security_group_rule" "allowhttp" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server_sg2.id
}

resource "aws_security_group_rule" "allow_allout" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_server_sg2.id
}