# Indice

- [Docker](#docker)
- [Vantages](#vantagens)
- [Arquitetura](#arquitetura)
- [Instalação](#instalação)
- [Pós-instalação](#pós-instalação)
- [Criando seu primeiro container](#criando-seu-primeiro-container)
- [Comandos](#comandos)
- [Contribuindo](#contribuindo)

## Docker

O Docker é uma plataforma open source que permite criar, empacotar e gerenciar aplicações em containers. Containers são ambientes isolados e padronizados que contêm tudo o que uma aplicação precisa para rodar, como código, bibliotecas e dependências, garantindo que ela funcione de forma consistente em qualquer sistema operacional que suporte Docker.

### Principais conceitos:
- Imagens: São templates imutáveis que definem o que um container deve executar. Por exemplo, uma imagem pode conter uma aplicação web com todas as suas dependências.
- Containers: São instâncias em execução das imagens, funcionando como "máquinas virtuais leves", mas que compartilham o kernel do sistema operacional.
- Docker Engine: O serviço que gerencia os containers e imagens no host.
- Docker Hub: Um repositório público onde você pode encontrar e compartilhar imagens Docker.

### Benefícios:
- Portabilidade: Containers podem rodar em qualquer ambiente que suporte Docker.
- Leveza: Compartilham o kernel do sistema operacional, consumindo menos recursos que VMs.
- Velocidade: Containers iniciam rapidamente.
- Consistência: Evitam problemas de "funciona na minha máquina".

Docker é amplamente utilizado em ambientes de desenvolvimento, testes e produção, especialmente em arquiteturas baseadas em microsserviços.


## Arquitetura


- Images : É um pacote com um sistema de arquivos com todas as suas dependências,libs de s.o,processos que serão executados,kernel,etc.

- Container : É o processo que executa uma imagem, a imagem é imutável mesmo após um container se iniciado.

- Registry : Repositório de imagens : <a href="hub.docker.com">hub docker</a> .


## Instalação

Para instalar o Docker, é fácil e rápido, se você estiver usando Linux claro... segue o comando no terminal :

    curl -fsSL https://get.docker.com | bash

Ta usando Windows?  <a href="https://www.docker.com/products/docker-desktop/">Tome</a>

Ao terminar de instalar, rode o comando :

    docker --version

Retornou a versão do Docker?Claro é Linux.

## Pós-instalação

Por padrão você só vai conseguir utilizar o Docker como usuário root, então é necessário caso quero rodar com seu usuário, fazer o procedimento abaixo :

## Criando o grupo e adicionando seu usuário:

- 1 - Crie o grupo docker 
    
      sudo groupadd docker

- 2 - Adicione seu usuário ao grupo docker

      sudo usermod -aG docker $USER

- 3 - Faça logout da maquia e logue novamente, se estiver usando uma VM, é preciso reiniciar. Você pode também ativar as alterações com o comando :

      newgrp docker

- 4 - Verifique se você pode executar o docker sem usar o sudo
      
      docker run hello-world

## Criando seu primeiro container

Eu vou ser pratico e direto na forma de criar um container, passando numa única linha os parâmetros e em seguida explicar.

      docker run -dit --name webserver -h webserver -p 8080:80 -p 8443:443 -v /opa.log:/var/log ubuntu:20.04

Iniciamos sempre com "docker" e a partir dai os parâmetros :

- run : para executar/criar o cotainer
- -dit : resumindo,vai rodar em background de forma interativa
- --name : para você dar um nome ao container, caso não passe, o docker vai gerar um nome aleatório
- -h : você pode dar um hostname para o container
- -p : para apontarmos que vamos usar a porta do HOST na porta do CONTAINER
- v : para montarmos volumes no container,no exemplo montamos arquivo de log do path do /var/log;
- ubuntu:20.04 : é a imagem que vamos usar como base.



## Comandos

Segue aqui alguns comandos

#### Gerenciamento de imagens
 - docker images: lista todas as imagens disponíveis no sistema.
 - docker pull <image-name>: faz o download de uma imagem do registro do Docker.</li>
 - docker build -t <image-name> <path-to-dockerfile>: constrói uma imagem com base em um Dockerfile.
 - docker tag <source-image>:<tag> <target-image>:<tag>: cria uma nova tag para uma imagem existente.
 - docker push <image-name>: envia uma imagem para o registro do Docker.

#### Gerenciamento de contêineres
 - docker ps: lista todos os contêineres em execução.
 - docker ps -a: lista todos os contêineres, incluindo os que estão parados.
 - docker start <container-name>: inicia um contêiner parado.
 - docker stop <container-name>: interrompe um contêiner em execução.
 - docker restart <container-name>: reinicia um contêiner em execução.
 - docker rm <container-name>: remove um contêiner parado.
 - docker container prune: remove todos os contêineres parados.

#### Gerenciamento de redes
 - docker network ls: lista todas as redes disponíveis no sistema.
 - docker network create <network-name>: cria uma nova rede.
 - docker network connect <network-name> <container-name>: conecta um contêiner a uma rede.
 - docker network disconnect <network-name> <container-name>: desconecta um contêiner de uma rede.

#### Outros comandos úteis
 - docker exec -it <container-name> <command>: executa um comando dentro de um contêiner em execução.
 - docker logs <container-name>: exibe os logs de um contêiner em execução.
 - docker inspect <container-name>: exibe informações detalhadas sobre um contêiner.
 - docker volume ls: lista todos os volumes disponíveis no sistema.
 - docker volume create <volume-name>: cria um novo volume.
 - docker volume rm <volume-name>: remove um volume.

Esses são apenas alguns exemplos de comandos úteis do Docker. Consulte a documentação oficial do Docker para obter informações detalhadas sobre todos os comandos disponíveis.

## Contribuindo

Qualquer contribuição que você fizer será bem vinda, analisada e se viável, atualizada no projeto!

- 1.Faça um fork do projeto
- 2.Clone o seu fork para sua maquina(git clone url-do-projeto.git)
- 3.Crie um branch para sua modificação/atualização(git checkout -b seu-branch)
- 4.Adicione suas alterações ao git(git add .)
- 5.Confirme suas alterações(git commit -m "texto descritivo do que fez")
- 6.Suba seu branch(git push origin seu-branch)
- 7.Faça uma solicitação de merge request para o branch : updates