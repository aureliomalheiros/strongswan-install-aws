resource "aws_instance" "VPN" {
    ami = var.ami
    instance_type = var.type
    tags = {
        Name = "strongswan_vpn"
    }
    #Configurações de rede
    subnet_id = aws_subnet.subnet_publica_1.id 
    vpc_security_group_ids = [ aws_security_group.strongswan_vpn.id, aws_security_group.ssh.id ]
    key_name = "vpn"  
}


