<h1 align=center>Ansible</h1>

<p>O Ansible, é uma ferramenta que nos possibilita ter o que chamamos de "infraestrutura como código", sendo utilizado para criação automatizada de Maquinas Virtuais, provisionamento de ambientes, gerenciamento de configurações, entre outras coisas!</p>

<p>Minha experiência com o Ansible, foi para fazer a subida de maquinas virtuais no ProxMox(um hipervisor, semelhante ao ESXI,VMware VCenter), com base em templates, mas também para fazer instalação de aplicações, como subida de um ambiente, verificar se um grupo de maquinas esta online, etc.</P>

<p>Faça a instalação do Ansible, e vamos entender como ele funciona!</p>

<p>O Ansible, trabalha sem a necessidade de ter um client instalado na maquina host, usando apenas a porta SSH da maquina, aconselhado que seu ambiente tem authorized_keys, para um melhor aproveitamento da ferramenta. Sendo ele então <b>control-node</b>, que vai rodar os comandos para as maquinas hosts, chamadas de <b>Managed Node</b>, e o ideal é ter o arquivo de inventários dos hosts, que fica localizado em /etc/ansible/hosts , dentro dele passamos como queremos nos comunicar com os managed nodes, podendo ser por grupos ou individual, segue um exemplo :</p><br>

    [myvirtualmachines]
    192.0.2.50
    192.0.2.51
    192.0.2.52

<p>Dessa forma dentro de [ ] temos um grupo de maquinas, ao rodar algum comando no Ansible apontando para esse grupo, todos os hosts devem responder.</p>

<p>Para verificar se deu certo, você pode rodar o comando :</p>
<b>ansible myvirtualachines -m ping</b>
<p>Tendo como retorno:</p><br>

    192.0.2.50 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
        }
    192.0.2.51 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
        }
    192.0.2.52 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "ping": "pong"
        }

<p>Você pode usar o Ansible para fazer instalações de aplicações simples usando o modulo <b>command</b> ou <b>shell</b>, exemplo :</p><br>

#no primeiro exemplo, usando o <b>which</b> para buscar se tem o git instalado, retornando que localizou o git na maquina host

    root@control-node:~# ansible dbservers -m command -a 'which git'
    192.168.56.11 | CHANGED | rc=0 >>
    /usr/bin/git

#no segundo exemplo, buscando se tem o vscode instalado, informando que não localizou na maquina host

    root@control-node:~# ansible dbservers -m command -a 'which code'
    192.168.56.11 | FAILED | rc=1 >>
    non-zero return code

<p align=center>o comando é <b>ansible SEU_HOST -m command -a 'comando que quer passar'</b></p>

<br>

<p>Outra forma de prover instalação de aplicações e configurações, é usando <b>playbooks</b>, como alguns costumam chamar de <b>receita</b>, segue um exemplo de instalação do apache bem básico :</p>


    ---
    - name: Instalação do Apache
    hosts: dbservers
    become: yes

    tasks:
    - name: Instala o Apache
        apt:
        name: apache2
        state: present
    
