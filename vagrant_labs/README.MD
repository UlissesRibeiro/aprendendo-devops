<h1 align=center>Vagrant</h1>

<p>O Vagrant é uma ferramenta que tem como intuito subir maquinas virtuais, no meu ponto de vista mas para fazer maquinas de testes.</p>

<p>Mas de forma resumida, faça a instalação do Vagrant, de acordo com o seu sistema operacional, uma vez instalado, verifique se a instalação deu certo, rodando o comando : <b>vagrant --version</b>, tendo o retorno da versão, confirmando que foi instalado.</p>

<p>Cada maquina virtual, tem que ser criada dentro de um diretório, já que cada VM tem seu Vagrantfile, por uma questão de boas práticas. Ao rodar o comando <b>vagrant init</b> dentro do diretório da VM, será gerado o arquivo <b>Vagrantfile</b>, arquivo esse responsável, por passar os parâmetros de criação da maquina virtual.</p>

<p>Segue abaixo o modelo de um Vagrantfile : </p>

Obs.: Por padrão o Vagrant, usa o VirtualBox como virtualizador, então instale o plugin vagrant-vbguest : <b> vagrant plugin install vagrant-vbguest</b>

Obs.2: Para definir tamanho de disco, baixe o plugin vagrant-disksize
<b>vagrant plugin install vagrant-disksize </b>

    Vagrant.configure("2") do |config|
        #.define passamos o nome da maquina
        config.vm.define "nome_da_maquina"

        #.hostname como diz, passa o hostname da maquina
        config.vm.hostname = "hostnamemaquina"

        #aqui .box , estamos escolhendo a distribuição que queremos usar
        config.vm.box = "ubuntu/focal64"

        #.network ,são configurações de rede, aqui um redirecionamento de porta
        config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

        #nessa linha criamos uma rede privada, temos essa possibilidade
        config.vm.network "private_network", ip: "192.168.56.2"

        #nesse bloco abaixo, podemos definir os recursos
        config.disksize.size = '80GB' #disco
        config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048" #memoria
        vb.cpus = 2 #cores/processadores
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        end

        #.provision, no nosso caso optei por usar um script
        #externo, onde posso fazer instalações de pacotes, etc
        
        #nesse exemplo foi a instalação do apache
        config.vm.provision "shell", path: "provision.sh"

    end
          
<p>Segue o exemplo do <b>provision.sh</b> : <br>

    #!/bin/bash
    echo "Instalando Apache e configurando setup!"
    apt install apache2 -y > /dev/null 2>&1
    cp -rfv /vagrant/html/ /var/www/
    service apache2 start

Uma vez com o Vagrantfile e o provision prontos, basta ligar a maquina com <b>vagrant up</b>, abaixo segue alguns comandos uteis : <br>

<li>vagrant ssh - para entrar na máquina usando o ssh, de forma automática, sem passar ip,usuário, já que ele cria de forma automática essa configuração e aponta também a porta padrão 22 para 2200.</li>
<li>vagrant halt - para desligar a máquina.</li>
<li>vagrant up  - para ligar a máquina, assim também para restartar a máquina.</li>
<li>vagrant destroy - para destruir a máquina.</li>
<li>vagrant suspend - para suspender o estado da máquina.</li>
<li>vagrant resume  - para voltar o estado da máquina.</li>
<li>vagrant reload  - caso tenha feito alguma mudança no vagrantfile e queira passar para a vm.</li>
<li>vagrant reload --provision - para forçar a usar o script de provisionamento novamente, pois ao rodar o vagrant up, o script funciona uma única vez,dessa forma ele vai forçar a subida do provision.</li>
<li>vagrant package - para exportar sua máquina numa extensão .box.</li>
<li>vagrant add mybox box path/da/box/.box - adiciona uma box exportada/importada a sua lista de box “reconhecidas” no vagrant .</li>
<li>vagrant init mybox vagrant up - inicia a box no diretório atual e liga a máquina.
mybox , é o nome da sua box.</li>