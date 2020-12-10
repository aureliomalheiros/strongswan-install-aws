#!/bin/bash

sudo apt update

sudo sed 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' -i /etc/sysctl.conf

sudo apt install -y strongswan

sudo echo "#Static Routes" >> /etc/network/interfaces
sudo echo "up route del -net 0.0.0.0/0 gw `ip route | grep default |egrep '[0-9\.]{6,}[$1]' | awk  {'print $3'}` dev eth0" >> /etc/network/interfaces
sudo echo "up route del -net 0.0.0.0/0 gw `ip route | grep default |egrep '[0-9\.]{6,}[$1]' | awk  {'print $3'}` dev eth0" >> /etc/network/interfaces

sudo cat >>/etc/ipsec.conf<<EOF
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
    type=tunnel
    leftid=#IP PUBLICO
    leftsubnet=#IP DA REDE
    leftauth=psk

conn vpn
	right=#DNS OU IP PUBLICO REMOTO
	rightid=#DMZ OU IP PUBLICO REMOTO
	rightsubnet=#SUBNET REMOTO
	rightauth=psk
	ike=#CRIPTOGRAFIA E DH
    esp=#CRIPTOGRAFIA E DH 
EOF

sudo cat<</etc/ipsec.secrets<<EOF
#######EMPRESA#######
#IP PUBLICO : PSK "senha"
EOF