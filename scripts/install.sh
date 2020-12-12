#!/bin/bash

sudo -i apt update && sudo apt upgrade -y

sudo -i sed 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' -i /etc/sysctl.conf

sudo -i apt install -y strongswan


sudo bash -c "echo \#Static Routes  >> /etc/network/interfaces"
sudo bash -c "echo up route del -net 0.0.0.0/0 gw `ip route | grep default |egrep '[0-9\.]{6,}[$1]' | awk  {'print $3'}` dev eth0  >> /etc/network/interfaces"
sudo bash -c "echo up route del -net 0.0.0.0/0 gw `ip addr | egrep '[0-9\.]{6,}/24' | awk '{print $2}' | cut -d/ -f1` dev eth0  >> /etc/network/interfaces"

tab="$(printf '\t')"
sudo bash -c "cat << EOF > /etc/ipsec.conf
config setup
${tab}strictcrlpolicy=yes
${tab}uniqueids = no
conn %default
${tab}ikelifetime=28800s
${tab}keylife=3600s
${tab}rekeymargin=3m
${tab}keyingtries=3
${tab}keyexchange=ikev1
${tab}authby=secret
${tab}auto=start
${tab}type=tunnel
${tab}leftid=#IP PUBLICO
${tab}leftsubnet=#IP DA REDE
${tab}leftauth=psk
conn vpn
${tab}right=#DNS OU IP PUBLICO REMOTO
${tab}rightid=#DMZ OU IP PUBLICO REMOTO
${tab}rightsubnet=#SUBNET REMOTO
${tab}rightauth=psk
${tab}ike=#CRIPTOGRAFIA E DH
${tab}esp=#CRIPTOGRAFIA E DH 
EOF"

sudo bash -c "cat << EOF > /etc/ipsec.secrets
#IP PUBLICO : PSK \"SENHA_DA_VPNS\"
EOF"

sudo systemctl reboot