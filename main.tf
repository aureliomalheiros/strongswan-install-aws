terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
    region = var.regiao
    shared_credentials_file = "$HOME/.aws/credentials"
}


resource "aws_instance" "VPN" {
    ami = var.ami
    instance_type = var.type
}

