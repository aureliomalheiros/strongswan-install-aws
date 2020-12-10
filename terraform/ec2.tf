resource "aws_instance" "VPN" {
    ami = var.ami
    instance_type = var.type
    tags = {
        Name = "strongswan_vpn"
    }
    #Configurações de rede
    source_dest_check = false
    subnet_id = aws_subnet.subnet_publica_1.id 
    vpc_security_group_ids = [ aws_security_group.strongswan_vpn.id, aws_security_group.ssh.id, aws_security_group.sistemas_linux.id ]
    key_name = "vpn"
    
    connection {
        type     = "ssh"
        user = "ubuntu"
        agent = false
        private_key = file("~/.ssh/terraform")
        host     = self.public_ip
    }

    provisioner "file" {
        source = "../scripts/install.sh"
        destination = "/tmp/install.sh"
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/install.sh",
            "/tmp/install.sh args"
        ]
    }
    
}


