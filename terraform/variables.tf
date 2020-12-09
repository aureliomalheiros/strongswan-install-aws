variable "regiao" {
    default = "us-east-1"
    description = "Regiao principal"
}
variable "availability_zone_a" {
  default = "us-east-1a"
}
variable "availability_zone_b" {
  default = "us-east-1b"
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

variable "cidr_block_privada_1" {
  default = "10.10.10.0/24"
}
variable "cidr_block_privada_2" {
  default = "10.10.20.0/24"
}
variable "cidr_block_publica_1"{
  default = "10.10.30.0/24"
}
variable "cidr_block_publica_2"{
  default = "10.10.40.0/24"
}
