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

#SUBNETS PUBLICAS
resource "aws_subnet" "subnet_publica_1" {
  vpc_id     = aws_vpc.rede_principal.id
  cidr_block = var.cidr_block_publica_1
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_a
  tags = {
    Name = "subnet_publica_1"
  }
}

resource "aws_subnet" "subnet_publica_2" {
  vpc_id     = aws_vpc.rede_principal.id
  cidr_block = var.cidr_block_publica_2
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_b
  tags = {
    Name = "subnet_publica_1"
  }
}
#SUBNETS PRIVADAS
resource "aws_subnet" "subnet_privada_1" {
  vpc_id     = aws_vpc.rede_principal.id
  cidr_block = var.cidr_block_privada_1
  availability_zone = var.availability_zone_a
  tags = {
    Name = "subnet_privada_1"
  }
}
resource "aws_subnet" "subnet_privada_2" {
  vpc_id     = aws_vpc.rede_principal.id
  cidr_block = var.cidr_block_privada_2
  availability_zone = var.availability_zone_b
  tags = {
    Name = "subnet_privada_2"
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
resource "aws_route_table_association" "publica_1a" {
  subnet_id      = aws_subnet.subnet_publica_1.id
  route_table_id = aws_route_table.rota_publica-rede_principal.id
}

resource "aws_route_table_association" "publica_2b" {
  subnet_id      = aws_subnet.subnet_publica_2.id
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
resource "aws_route_table_association" "privada_1a" {
  subnet_id      = aws_subnet.subnet_privada_1.id
  route_table_id = aws_route_table.rota_privada-rede_principal.id
}

resource "aws_route_table_association" "privada_2b" {
  subnet_id      = aws_subnet.subnet_privada_2.id 
  route_table_id = aws_route_table.rota_privada-rede_principal.id
}

