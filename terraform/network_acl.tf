#ACL Publica
resource "aws_network_acl" "acl_publica" {
  vpc_id = aws_vpc.rede_principal.id
  subnet_ids = [ aws_subnet.subnet_publica_1.id, aws_subnet.subnet_publica_2.id ]
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
  #SSH 22
  egress {
    protocol   = "tcp"
    rule_no    = 12
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  #Portas efemeras
  egress {
    protocol   = "tcp"
    rule_no    = 13
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
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
  #Porta 22
  ingress {
    protocol   = "tcp"
    rule_no    = 12
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
  #Portas Efemeras
  ingress {
    protocol   = "tcp"
    rule_no    = 13
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }
  
  tags = {
    Name = "acl_publica"
  }
}