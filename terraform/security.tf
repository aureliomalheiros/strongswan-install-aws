#ACL Publica
resource "aws_network_acl" "acl_publica" {
  vpc_id = aws_vpc.rede_principal.id
  subnet_ids = [ aws_subnet.subnet_publica.id ]
  #Porta 500
  egress {
    protocol   = "udp"
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 500
    to_port    = 500
  }
  #Porta 4500
  egress {
    protocol   = "udp"
    rule_no    = 11
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 4500
    to_port    = 4500
  }
  #Porta 500
  ingress {
    protocol   = "udp"
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 500
    to_port    = 500
  }
  #Porta 4500
  ingress {
    protocol   = "udp"
    rule_no    = 11
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 4500
    to_port    = 4500
  }

  tags = {
    Name = "acl_publica"
  }
}

#Security Group

resource "aws_security_group" "strongswan_vpn" {
  name        = "strongswan_vpn"
  description = "strongswan vpn"
  vpc_id      = aws_vpc.rede_principal.id

  ingress {
    description = "Porta 500 liberado para todos os IPs"
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Porta 4500 liberado para todos os IPs"
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 500
    to_port     = 500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 4500
    to_port     = 4500
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "strongswan_vpn"
  }
}