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

<h2>Linkando sua pasta host ao container</h2>
<p>Vinculado sua pasta host ao container, facilita seu processo de produção, considerando aqui que você seja um desenvolvedor e queira testar seu codigo no container, então para isso é feito a partir desse codigo :

<b>docker run -it --mount type=bind,src="$(pwd)",target=/src sua_imagem sh</b>

sendo <b>src</b> para usar o seu diretório atual como source, e apontar no <b>target</b> o destino da aplicação, então segue o exemplo :
<b>docker run -dit --name apachoso -p 8080:80 --mount type=bind,src="$(pwd)",target=/usr/local/apache2/htdocs/ my-apach2</b>
<br>
<li>docker run, para executar o container.</li>
<li>-dit, para indiciar que vai ser iniciado em segundo plano de forma interativa.</li>
<li>--name apachoso, definimos um nome para o container "apachoso".</li>
<li>-p 8080:80, um forwarded de portas, da 80 do container, para a 8080 do host.</li>
<li>--mount type=bind, essa opção informa ao Docker para criar um ponto de montagem de ligação.</li>
<li>src, o seu diretório de trabalho.</li>
<li>target, o diretório do container</li>
<li>my-apach2, o nome da nossa imagem, no momento que rodamos o docker buld.</li>
<br>
</p>
<p>Agora ao atualizar seu código html no seu host, o container vai atualizar por esta vinculado os diretórios.</p>

<h2>Comandos Docker</h2>
<p>Segue aqui alguns comandos :
<ul>

<h3 align=center>Gerenciamento de imagens</h3>
<li>docker images: lista todas as imagens disponíveis no sistema.</li>
docker pull <image-name>: faz o download de uma imagem do registro do Docker.</li>
<li>docker build -t <image-name> <path-to-dockerfile>: constrói uma imagem com base em um Dockerfile.</li>
<li>docker tag <source-image>:<tag> <target-image>:<tag>: cria uma nova tag para uma imagem existente.</li>
<li>docker push <image-name>: envia uma imagem para o registro do Docker.</li>

<h3 align=center>Gerenciamento de contêineres</h3>
<li>docker ps: lista todos os contêineres em execução.</li>
<li>docker ps -a: lista todos os contêineres, incluindo os que estão parados.</li>
<li>docker start <container-name>: inicia um contêiner parado.</li>
<li>docker stop <container-name>: interrompe um contêiner em execução.</li>
<li>docker restart <container-name>: reinicia um contêiner em execução.</li>
<li>docker rm <container-name>: remove um contêiner parado.</li>
<li>docker container prune: remove todos os contêineres parados.</li>

<h3 align=center>Gerenciamento de redes</h3>
<li>docker network ls: lista todas as redes disponíveis no sistema.</li>
<li>docker network create <network-name>: cria uma nova rede.</li>
<li>docker network connect <network-name> <container-name>: conecta um contêiner a uma rede.</li>
<li>docker network disconnect <network-name> <container-name>: desconecta um contêiner de uma rede.</li>

<h3 align=center>Outros comandos úteis</h3>
<li>docker exec -it <container-name> <command>: executa um comando dentro de um contêiner em execução.</li>
<li>docker logs <container-name>: exibe os logs de um contêiner em execução.</li>
<li>docker inspect <container-name>: exibe informações detalhadas sobre um contêiner.</li>
<li>docker volume ls: lista todos os volumes disponíveis no sistema.</li>
<li>docker volume create <volume-name>: cria um novo volume.</li>
<li>docker volume rm <volume-name>: remove um volume.</li>
</ul>
Esses são apenas alguns exemplos de comandos úteis do Docker. Consulte a documentação oficial do Docker para obter informações detalhadas sobre todos os comandos disponíveis.