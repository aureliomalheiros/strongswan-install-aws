variable "regiao" {
    default = "us-east-1"
    description = "Regiao principal"
}
variable "availability_zone_a" {
  default = "us-east-1a"
}
variable "ami" {
    default = "ami-00ddb0e5626798373"
}

variable "type" {
    default = "t2.micro"
}
variable "cidr_block" {
  default = "10.10.0.0/16"
}

variable "cidr_block_privada" {
  default = "10.10.1.0/24"
}
variable "cidr_block_publica"{
  default = "10.10.2.0/24"
}

