resource "aws_key_pair" "vpn" {
    key_name = "vpn"
    public_key = file("~/.ssh/terraform.pub")
}