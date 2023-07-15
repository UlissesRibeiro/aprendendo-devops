# Indice
- [Vagrant](#vagrant)
- [Instalação](#instalação)
- [Criando uma VM](#criando-uma-vm)
- [Criando um Vagrantfile](#criando-um-vagrantfile)
- [Comandos uteis](#comandos-uteis)
- [Contribuindo](#contribuindo)
## Vagrant

O Vagrant é uma ferramenta que tem como intuito subir maquinas virtuais,de forma mais rapida, do que ter que ir num virtualizador como VirtualBox,VMware,entre outros, por mais que a ferramenta utilize dos plugins desses virtualizadores, mas todo o deploy é feito via arquivo de configuração.

## Instalação

Faça o download clicando <a href="https://www.vagrantup.com/Downloads">aqui</a>, na sequência faça a instalação do Vagrant, de acordo com o seu sistema operacional, uma vez instalado, verifique se a instalação deu certo, rodando o comando : <b>vagrant --version</b>, tendo o retorno da versão, confirmando que foi instalado.

## Criando uma VM

Para criar uma maquina virtal(VM) usando o Vagrant, é importante saber que ela é criada no diretório corrente, ou seja, se você rodar o comando para subir a partir do Vagrantfile dentro do /root, sua VM só vai ser acessada se você estiver dentro desse diretório.

<b>Sujestão : planeja sua estrutura de diretórios/ambiente de trabalho, exemplo : </b>
    
    - vms-vagrant
        - vm1
        - vm2

Como falei na introdução o Vagrant utiliza plugins de virtualizadores para poder provisionar as maquinas, por padrão é utilizado o VirtualBox, mas também é possivel usar outros virtualizadores, você pode obter informações mais detalhadas <a href="https://developer.hashicorp.com/vagrant/docs/providers">aqui</a> .

## Criando um Vagrantfile

O Vagrantfile é escrito usando a sintaxe do Ruby, segue abaixo um exemplo :


<b>Obs.: Instale o plugin vagrant-vbguest : vagrant plugin install vagrant-vbguest</b>

<b>Obs.2: Para definir tamanho de disco, baixe o plugin vagrant-disksize
: vagrant plugin install vagrant-disksize </b>

<b>Obs.3: É necessário iniciar o repositório com : vagrant init , automaticamente é gerado um Vagrantfile padrão, para você alterar!</b>

    Vagrant.configure("2") do |config|
        config.vm.define "nome_da_maquina"
        config.vm.hostname = "hostnamemaquina"
        config.vm.box = "ubuntu/focal64"
        config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
        config.vm.network "private_network", ip: "192.168.56.2"

        config.disksize.size = '80GB'
        config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--ioapic", "on"]
        end

        config.vm.provision "shell", path: "provision.sh"

    end

    - config.vm.define : define o nome da maquina virtual
    - config.vm.hostname : define um hostname para a maquina
    - config.vm.box : define a imagem que vai usar [ubuntu,centos,etc]
    - config.vm.network : para definir parâmetros de rede, como
        - forwarder de portas, criar uma rede privada,etc
    -   config.disksize.size : você pode definir o tamanho de disco da VM
    - config.vm.provider : para definir o virtualizador [VirtualBox,VMware,etc]
    - vb.memory : define o tamanho de memoria ram
    - vb.cpus : define a quantidade de cores
    - config.vm.provision : utilizei um script externo em bash, para fazer as instalações,updates,etc

<b>Obs.4: <a href="https://developer.hashicorp.com/vagrant/docs/provisioning/shell">aqui</a> você tem mais detalhes como usar o provision.</b>

Segue o exemplo do <b>provision.sh</b> :

    #!/bin/bash
    echo "Instalando Apache e configurando setup!"
    apt install apache2 -y > /dev/null 2>&1
    cp -rfv /vagrant/html/ /var/www/
    service apache2 start

No exemplo,é feito a instalação do Apache2, e copiado arquivos locais para dentro da vm no diretório padrão do apache. Basta agora você acessar o ip da maquina criada no browser apontando a porta!

## Comandos uteis

Segue abaixo alguns comando uteis para utilização do Vagrant: 


- vagrant ssh: Para entrar na máquina usando SSH de forma automática, sem precisar fornecer o IP ou usuário, já que o Vagrant cria essa configuração automaticamente e aponta a porta padrão 22 para 2200.

- vagrant halt: Para desligar a máquina.

- vagrant up: Para ligar a máquina, também pode ser usado para reiniciar a máquina.

- vagrant destroy: Para destruir a máquina.

- vagrant suspend: Para suspender o estado da máquina.

- vagrant resume: Para retomar o estado da máquina.

- vagrant reload: Caso tenha feito alguma mudança no Vagrantfile e queira aplicar as alterações na VM.

- vagrant reload --provision: Para forçar a execução do script de provisionamento novamente. Ao executar vagrant up, o script de provisionamento é executado apenas uma vez, mas com essa opção, ele será executado novamente.

- vagrant package: Para exportar a máquina em um arquivo com a extensão .box.

- vagrant box add mybox box_path/da/box/.box: Para adicionar uma box exportada/importada à lista de boxes reconhecidas pelo Vagrant. Onde "mybox" é o nome da sua box.

- vagrant init mybox e vagrant up: Para iniciar a box no diretório atual e ligar a máquina. "mybox" é o nome da sua box.

## Contribuindo

Qualquer contribuição que você fizer será bem vinda, analisada e se viável, atualizada no projeto!

- 1.Faça um fork do projeto
- 2.Clone o seu fork para sua maquina(git clone url-do-projeto.git)
- 3.Crie um branch para sua modificação/atualização(git checkout -b seu-branch)
- 4.Adicione suas alterações ao git(git add .)
- 5.Confirme suas alterações(git commit -m "texto descritivo do que fez")
- 6.Suba seu branch(git push origin seu-branch)
- 7.Faça uma solicitação de merge request para o branch : updates