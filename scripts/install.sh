#!/bin/bash

sudo apt update && sudo apt upgrade -y

sudo sed 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' -i /etc/sysctl.conf

sudo apt install -y strongswan

sudo echo "#Static Routes" >> /etc/network/interfaces
sudo echo "up route del -net 0.0.0.0/0 gw `ip addr | egrep '[0-9\.]{6,}/24' | awk '{print $2}' | cut -d/ -f1` dev eth0" >> /etc/network/interfaces
sudo echo "up route add -net 0.0.0.0/0 gw `ip route | grep default |egrep '[0-9\.]{6,}[$1]' | awk  {'print $3'}` dev eth0" >> /etc/network/interfaces

sudo cat >>/etc/ipsec.conf<< EOF
config setup
    strictcrlpolicy=yes
    uniqueids = no
conn %default
    ikelifetime=28800s
    keylife=3600s
    rekeymargin=3m
    keyingtries=3
    keyexchange=ikev1
    authby=secret
    auto=start
    leftid=#IP_PUBLICO_DA_INSTANCIA
    leftsubnet=#IP_DA_SUBNET
    leftauth=psk

conn vpn
    right=#IP_PUBLICO_OU_DNS_REMOTO
    rightid=#IP_PUBLICO_OU_DMZ
    rightsubnet=#SUBNET_REDE_PRIVADA_REMOTO
    rightauth=psk
    ike=#CRIPTOGRAFIA_AUTENTICAÇÃO_DH
    esp=#CRIPTOGRAFIA_AUTENTICAÇÃO_DH
EOF

sudo cat >> /etc/ipsec.secrets<< EOF
#IP_PUBLICO : PSK "SENHADO_DA_VPN"
EOF

sudo reboot