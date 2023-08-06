# Índice

- [Sobre](#sobre)
- [O que é cloud](#o-que-é-cloud)
- [Instalação](#instalação)


## Sobre

O Terraform, é uma ferramenta de infraestrutura como código(Infraestructure as Code - IAC), desenvolvida pela HashiCorp.
A ideia é que você descreva a infraestrutura desejada em um arquivo de configuração escrito em formato HCL - HashiCorp Configuration Language, e a partir dai o Terraform cuida da implantação.
<br>
Com o Terraform é possivel provisionar diversos recursos em diversos providers de nuvem, como :
- AWS
- Azure
- Google Cloud Platform

Além de recursos on-premise(infraestrutura local).

## O que é cloud

Segue um trecho retirado da Wikipédia :

<i>Computação em nuvem (em inglês, cloud computing) é um termo coloquial para a disponibilidade sob demanda de recursos do sistema de computador, especialmente armazenamento de dados e capacidade de computação, sem o gerenciamento ativo direto do utilizador. O termo geralmente é usado para descrever centros de dados disponíveis para muitos utilizadores pela Internet. Nuvens em grande escala, predominantes hoje em dia, geralmente têm funções distribuídas em vários locais dos servidores centrais. Se a conexão com o utilizador for relativamente próxima, pode ser designado um servidor de borda.</i>
<br>
Ou seja, nada mais é do que uma abstração de serviços.

## EC2, S3 e IAM

<b>É necessário que você tenha uma conta gratuita mesmo na AWS!</b>
<br>

Antes de irmos diretamente ao terraform, precisamos conhecer esses serviços que vão ser de uso agora nesse momento.

- EC2 : Na AWS EC2, são as maquinas virtuais, VMs.
- S3 : Na AWS S3, é o serviço de storage/armazenamento.
- IAM : Na AWS IAM , é um serviço de gerenciamento/controle de acessos.

Nesse momento, você deve criar um S3 e o IAM, abaixo segue o passo-a-passo:

- S3 <a href="https://www.youtube.com/watch?v=e6w9LwZJFIA">Getting started with Amazon S3 - Demo</a>

- IAM <a href="https://www.youtube.com/watch?v=wRzzBb18qUw">How do I set up an IAM user and sign in to the AWS Management Console using IAM credentials?
</a>

## Como funciona a comunicação com a cloud?

A comunicação com a cloud é feita através de uma API, então quando estamos no console da AWS, clicando, estamos basicamente, enviando nossa requisição para a API e ela manda para cloud, sendo assim, o Terraform faz o mesmo papel da console da AWS. No curso esta sendo usado os serviços da AWS, por ser a cloud mais utilizada, mas os conceitos apresentados aqui podem ser utilizados em qualquer outra cloud.

## Instalação :

Podemos usar o terraform de varias maneiras, seja instalando na sua maquina ou com um container docker, então vou deixar aqui as duas formas :

### Instalando na maquina

    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    sudo apt update && sudo apt install terraform

### Docker

    docker run -dit -v /path:/path -w /path --entrypoint "" hashicorp/terraform:light sh

- Explicando o docker :
    - no path é interessante você passar o seu path de estudos onde estão seus arquivos .tf que vão ser utilizados pelo terraform
    - o -w é de workdir, para indicar que o container ao você acessar no bash, já ir para o diretorio de trabalho, no caso o path que você definiu
    - o --entrypoint, é por que o container do terraform já vai querer iniciar executando o binário, então para ele não iniciar passamos o entrypoint vazio

## Explicando o HCL

O arquivo HCL, é como um .yml melhorado digamos assim, e se assemelha ao Vagrantfile saca? Então vamos pegar a informação com base na documentação oficial <a href="https://developer.hashicorp.com/terraform/language/syntax/configuration">aqui</a>.
<br>
basicamente ele é composto por :
- Blocks
- Arguments
- Identifiers
<hr>



    provider "aws" {
      region  = "us-east-1"
      version = "~> 2.0"
    }

    terraform {
      backend "s3" {
        # Lembre de trocar o bucket para o seu, não pode ser o mesmo nome
        bucket = "nome-do-seu-bucket"
        key    = "terraform-test.tfstate"
        region = "us-east-1"
      }
    }

## Iniciando o terraform
Para iniciar o diretório do terraform, semelhante ao git,vagrant, etc, usamos o comando <b>terraform init</b>, isso vai fazer com que seja criada um diretório <b>.terraform</b>, a partir de agora poderemos usar os demais comandos do terraform... opa, deu erro ai ne? Lembra que falei pra criar(assistir ao video de como criar) o IAM, pois bem, o erro é exatamente referente a falta de credenciais de acesso, para contornar isso use variáveis de ambiente :

- export AWS_ACCESS_KEY_ID=a-id-gerada-no-iam
- export AWS_SECRET_ACCESS_KEY=a-chave-secreta-gerada

Rode novamente o terraform init

## Comandos básicos

Aqui veremos os comandos mais utilizados no dia-a-dia!

- init : para iniciarmos um diretório
- plan : ele serve para fazer um "check" do seu arquivo HCL com o state e o que já tem criado na infra/cloud
- apply : ele vai criar de fato o que foi definido no HCL, se for para criar uma EC2, será então criada nesse comando.
- destroy : como o nome diz, vai destruir o que foi criado com base no HCL.

É importante lembrar de que ao rodar o plan, execute junto do parâmetro -out:path :

    terraform plan -out ec2

e quando for dar o apply usar:
    
    terraform apply ec2

## Criando um instancia EC2

Para criar nossa instancia EC2 a partir do terraform, segue abaixo o nosso código base:

    resource "aws_instance" "web" {
      ami           = "ami-053b0d53c279acc90"
      instance_type = "t2.micro"
      
      tags = {
        Name = "HelloWorld"
      }
    }

o recurso(resource) utilizado para provisionar EC2 na AWS, é o "aws_instance", e dentro do bloco passamos a ami da imagem referente a region onde você quer criar, essa é referente a us-east-1, dessa forma vamos criar uma instancia EC2 padrão free.
<br>
Agora quando você rodar : terraform plan -out ec2 , o terraform vai identificar que será criada uma instancia, bastando então você aplicar e aguardar a criação!

- Quando criamos uma instancia dessa forma, ela não vai ter um par de chaves para acesso SSH, então você pode fazer da seguinte maneira, crie um par de chaves usando : ssh-keygen,e dentro do seu arquivo .tf passe o seguinte bloco :

   
      resource "aws_key_pair" "deployer" {
        key_name   = "sua_chave.pub"
        public_key = file("/root/.ssh/sua_chave.pub")
      }
e dentro do bloco da instancia, coloque: 

    key_name = aws_key_pair.deployer.key_name

