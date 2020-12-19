# Provisionamento de ambiente para o StrongSwan utilizando Terraform

### Descrição do Projeto
> Tem o intuito de provisionar um ambiente na AWS e instalar o StrongSwan no Ubuntu
> fazendo o uso do Shell Script.
### Pré-requisitos

- Conta na AWS;
- Chave de acesso;
- Configuração do AWS CLI no seu computador;
- Terraform instalado e configurado no seu computador;

### ✨ Explicação do projeto
- Provisionado um ambiente na região da Virginia (us-east-1)
- É feito a criação dos seguintes itens:
    - VPC
        - Rede
        - Duas subnetes privadas
        - Duas subnetes públicas
    - ACL
    - security_group
    - EC2
    - Key Pair
- Instalado e configurado o StrongSwan (Utilizado para VPN IPSEC)

### 🚀 Execução

1ª Você deve criar uma chave privada e publica na sua para criação do arquivo PEM
Execute o seguinte comando dentro da pasta .ssh:
> Pasta está localizada no diretório $HOME (Diretório do seu usuário)

```console
ssh-keygen -t rsa -m PEM
```

- Será solicitado algumas perguntas
    - Em **Enter file in which to save the key**, você deve digitar **terraform**.
    - Em **Enter passphrase**, pressione a tecla **enter**
    - Em **Enter same passphrase again**, pressione a tecla **enter**

2ª Agora você deve criar o arquivo pem:

```console
cp terraform terraform.pem
```

3ª Inicialize o terraform dentro da pasta terraform

```console
cd terraform
```
> Obs: O comando acima é para caso você ainda não esteja na pasta terraform

```console
terraform init
```

4ª Agora execute o provisionamento do ambiente

```console
terraform apply -auto-approve
```

5ª Para se conectar a instancia você da permissões para o arquivo PEM

> Obs: Os procedimentos abaixo podem ser vistos na sua conta da AWS

```console
chmod 400 vpn.pem
```

```console
ssh -i "vpn.pem" ubuntu@IP_PUBLICO_DA_INSTANCIA
```

### Plataformas

[![Build status](https://img.shields.io/github/workflow/status/simple-icons/simple-icons/Verify/develop?logo=github)](https://github.com/simple-icons/simple-icons/actions?query=workflow%3AVerify+branch%3Adevelop)

- [x] GNU/Linux
- [ ] Windows
- [ ] Mac

### 🛠 Tecnologias

![ShellScript](https://img.shields.io/badge/-ShellScript-000000?style=for-the-badge&logo=gnu-bash&logoColor=white)
![AWS](https://img.shields.io/badge/-AWS-000000?style=for-the-badge&logo=amazon-aws&logoColor=white)
![StrongSwan](https://img.shields.io/badge/-strongSwan-000000?style=for-the-badge&logo=strongswan&logoColor=white)


### **:books: REFERÊNCIAS**

- [Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS](https://aws.amazon.com/pt/cli/)
- [StrongSwan](https://wiki.strongswan.org/projects/strongswan/wiki/UserDocumentation)
