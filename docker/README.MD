<h1 align=center>Docker</h1>
<h2>O que é o Docker?</h2>

<p>O Docker, é uma virtualização que ocorre dentro do sistema operacional, mas executado como se fosse um processo! A diferença entre usar Docker e uma maquina virtual, é que no docker você não vai ter que instalar um outro sistema operacional
dentro do seu sistema, já que no Docker, ele é executado como um processo isolado,e graças a esse isolamento
é possível que cada aplicação tenha suas libs,dlls, de forma separadas, sem compartilhar ou depender de libs,,de 
outra aplicação.</p>

<h2>Vantagens</h2>
<ul>
<li><b>Baixo consumo de hardware</b></li> utilização do hardware mais otimizada comparado com a VM.

<li><b>Portabilidade</b></li>O mesmo container vai ser executado em qualquer outra maquina da mesma forma.

<li><b>Reusabilidade</b></li>É possível utilizar o mesmo container para diversos ambientes.

<li><b>Microsserviços</b></li>Aderente a arquitetura de microsserviços.
</ul>
<br>

<h2>Arquitetura</h2>


<ul>
<li><b>Images</b></li>É um pacote com um sistema de arquivos com todas as suas dependências,libs de s.o,processos que serão executados,kernel,etc.

<li><b>Container</b></li>É o processo que executa uma imagem, a imagem é imutável mesmo após um container se iniciado.

<li><b>Registry</b></li> Repositório de imagens : <a href="hub.docker.com">hub docker</a> .
</ul>
<br>

<h2>Instalando o Docker</h2>

<p>No nosso ambiente de laboratórios, estamos usando o Ubuntu, caso utilize outra distribuição verifique 
os requisitos : <a href="https://docs.docker.com/engine/install/">requisitos</a> ,
e então basta seguir o passo a passo desse link <a href="https://docs.docker.com/engine/install/ubuntu/">passo a passo de instalação</a> ,
vou deixar aqui o script para facilitar o processo, mas é o mesmo que está na documentação, recomendo que leia.</p>


    #!/bin/bash

    apt-get remove docker docker-engine docker.io containerd runc -y

    apt-get update
    apt-get install -y\
        ca-certificates \
        curl \
        gnupg \
        lsb-release 

    mkdir -m 0755 -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt update

    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    systemctl start docker
    systemctl enable docker

<h2>Processo pós-instalação</h2>

<p>Gerencie o Docker como um usuário não root, o daemon do Docker se liga a um socket Unix, e não a uma porta TCP. Por padrão, é o usuário root que possui o soquete Unix e outros usuários só podem acessá-los usando <b>sudo</b>. O daemon do Docker sempre é executado como usuário root.</p>

<i>Se você deseja iniciar o Docker sem usar o sudo, crie um grupo chamado <b>docker</b> e adicione usuários a ele.</i>


Criando o grupo e adicionando seu usuário:
<dl>
  <dt>1 - Crie o grupo docker</dt>
  <dd>sudo groupadd docker</dd>
  <dt>2 - Adicione seu usuário ao grupo docker</dt>
  <dd>sudo usermod -aG docker $USER</dd>
  <dt>3 - Faça logout da maquia e logue novamente, se estiver usando uma VM, é preciso reiniciar. Você pode também ativar as alterações com o comando </dt>
  <dd>newgrp docker</dd>
  <dt>4 - Verifique se você pode executar o docker sem usar o sudo</dt>
  <dd>docker run hello-world</dd>
</dl>

<h2>Visão geral - Docker - Container</h2>

<h2>O que é um Container?</h2>
<p>Simplificando, um container é um processo de area restrita em sua maquina, isolado de todos os processos da sua maquina. Esse isolamento aproveita namespaces do kernel, recursos que estão no Linux há muito tempo. O Docker trabalhou para tornar esses recursos acessíveis e fáceis de usar, resumindo um container :
<ul>
<li>É uma instancia executavel de uma imagem, você pode criar, iniciar, parar, mover ou excluir um container usando o DockerAPI ou CLI.</li>
<li>Pode ser executado em maquinas locais, maquinas virtuais ou implantado em nuvem.</li>
<li>É portátil, podendo ser executado em qualquer sistema operacional.</li>
<li>Esta isolado de outros containers, e executa seu próprio software, binários e configurações.</li>
</ul>
</p>

<h2>O que é uma imagem de container?</h2>
<p>Ao executar um container, ele usa um sistema de arquivos isolado, esse sistema de arquivos personalizado, é fornecido por uma imagem do container, como a imagem contem o sistema de arquivos do container, ela deve conter tudo o que é necessário para executar um aplicativo, todas as dependências, configurações,scripts, binários,etc. A imagem contém outras configurações, como variáveis de ambiente, um comando padrão para executar e outros metadados.</p>

<h2>Containerizar uma aplicação</h2>
<p>Aqui vou mostrar como cria um container de uma aplicação web com o Apache, através de um arquivo Dockerfile. Primeiramente crie o arquivo Dockerfile, e no nosso caso, vamos pegar o codigo direto do hub docker <a href="https://hub.docker.com/_/httpd">aqui</a>, segue o codigo :

  FROM httpd:2.4  
  COPY ./public-html/ /usr/local/apache2/htdocs/

Nesse arquivo Dockerfile acima, ele vai criar a imagem a partir do httpd, e copiar os arquivos de um diretório local para dentro do container.
Salve seu Dockerfile, e execute o comando a seguir:<br>

  <b>docker build -t my-apache2 .<br>
  docker run -dit --name my-running-app -p 8080:80 my-apache2  </b>
</p>
  <br>
<p>Dessa forma criamos nossa imagem a partir de um Dockerfile, sendo essa imagem do Apache2, quando usado o comando docker build -t my-apache2 , a -t é para darmos nome a nossa imagem, e no docker run, passamos para que seja executado em segundo plano de modo interativo, setamos um nome para aplicação, com um redirecionamento de portas, e o nome da imagem, podemos listar o container usando <b>docker ps</b>, e ao acessarmos o localhost na porta 8080, varemos nossa aplicação web rodando.</p>

