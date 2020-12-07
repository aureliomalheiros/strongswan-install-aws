resource "aws_vpc" "rede_principal" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "rede_principal"
  }
}
#Internet Gateway
resource "aws_internet_gateway" "IG_rede_principal" {
  vpc_id = aws_vpc.rede_principal.id

  tags = {
    Name = "IG_rede_principal"
  }
}

#Subnets
resource "aws_subnet" "subnet_publica" {
  vpc_id     = aws_vpc.rede_principal.id
  cidr_block = var.cidr_block_publica
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_a
  tags = {
    Name = "subnet_publica"
  }
}

resource "aws_subnet" "subnet_privada" {
  vpc_id     = aws_vpc.rede_principal.id
  cidr_block = var.cidr_block_privada
  availability_zone = var.availability_zone_a
  tags = {
    Name = "subnet_privada"
  }
}

#Rotas Publicas
resource "aws_route_table" "rota_publica-rede_principal" {
  vpc_id = aws_vpc.rede_principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG_rede_principal.id
  }

  tags = {
    Name = "rota_publica-rede_principal"
  }
}

#Associação de redes Publicas
resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.subnet_publica.id
  route_table_id = aws_route_table.rota_publica-rede_principal.id
}

#Rotas Privadas
resource "aws_route_table" "rota_privada-rede_principal" {
  vpc_id = aws_vpc.rede_principal.id
  tags = {
    Name = "rota_privada-rede_principal"
  }
}
#Associação de redes Privadas
resource "aws_route_table_association" "privada" {
  subnet_id      = aws_subnet.subnet_privada.id
  route_table_id = aws_route_table.rota_privada-rede_principal.id
}

#Security Group