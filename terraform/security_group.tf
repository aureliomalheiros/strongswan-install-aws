
#VPN
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

#SSH
resource "aws_security_group" "ssh" {
  name = "ssh"
  vpc_id = aws_vpc.rede_principal.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh"
  }
}