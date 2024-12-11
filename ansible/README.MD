## indice
- [O que é o Ansible?](#o-que-é-o-ansible)
- [Como instalar](#como-instalar)
- [Arquitetura](#arquitetura)
- [Inventario](#inventario)
- [Testando a conexão](#testando-a-conexão)
- [Conectando em host windows](#conectando-em-host-windows)
- [Documentação util](#documentação)
- [Contribuindo](#contribuindo)

## O que é o Ansible?

O Ansible é uma ferramenta de automação de TI que ajuda a gerenciar e configurar servidores, aplicativos e infraestrutura de forma simples e eficiente. Pense nele como um "controlador remoto inteligente" que usa arquivos de texto (Playbooks) para descrever o que você quer que ele faça, como instalar pacotes, configurar serviços ou implementar atualizações.

#### Características práticas:
- Sem agentes: Você não precisa instalar nada nas máquinas que quer gerenciar. O Ansible se conecta via SSH.
- Simplicidade: Os Playbooks são escritos em YAML, um formato legível e fácil de aprender.
- Escalável: Pode gerenciar de um único servidor até milhares de máquinas.
- Repetibilidade: Garante que o mesmo script funcione sempre da mesma forma, eliminando inconsistências.

#### Exemplo prático: Imagine que você precisa instalar o Apache em 10 servidores. Com o Ansible, você escreve um Playbook assim:


    - name: Instalar e iniciar Apache
      hosts: servidores_web
      tasks:
        - name: Instalar pacote Apache
          apt:
            name: apache2
            state: present

        - name: Garantir que o Apache está rodando
          service:
            name: apache2
            state: started

            
Com apenas um comando, o Ansible faz isso em todos os servidores, sem que você tenha que acessá-los manualmente.

Resumindo: o Ansible é como um assistente que automatiza tarefas repetitivas e complexas, poupando tempo e reduzindo erros.

## Como instalar
<p>Para instalar o Ansible, basta seguir o passo a passo baseado na documentação oficial, meu sistema de uso é o Ubuntu, segue então os comandos :

    $ sudo apt update
    $ sudo apt install software-properties-common
    $ sudo add-apt-repository --yes --update ppa:ansible/ansible
    $ sudo apt install ansible
</p>

## Arquitetura

A arquitetura digamos assim do Ansible é composta por :

 - Control Node : a maquina que terá o Ansible instalado para gerenciar os hosts.

 - Managed Node : são os hosts gerenciados pelo Control Node.

 - Inventory : seu inventário/hosts


O Ansible, trabalha sem a necessidade de ter um client instalado na maquina host, usando apenas a porta SSH da maquina, aconselhado que seu ambiente tenha authorized_keys, para um melhor aproveitamento da ferramenta. Sendo ele então <b>control-node</b>, que vai rodar os comandos para as maquinas hosts, chamadas de <b>Managed Node</b>, e o ideal é ter o arquivo de inventários dos hosts, que fica localizado em /etc/ansible/hosts , dentro dele passamos como queremos nos comunicar com os managed nodes, podendo ser por grupos ou individual, segue um exemplo : <br>

    [myvirtualmachines]
    192.0.2.50
    192.0.2.51
    192.0.2.52

<p>Dessa forma dentro de [ ] temos um grupo de maquinas, ao rodar algum comando no Ansible apontando para esse grupo, todos os hosts devem responder.</p>

## Inventario

O inventario/hosts, é o que vai fazer o Ansible se comunicar de uma forma que ele identifique na rede quem é quem na fila do pão! Podemos adicionar os hosts de forma livre apenas listando os IPs, ou de forma organizada informando os Grupos dentro de [ ]

    [DEMO-HOMO]
    DEMO001      ansible_host=192.168.0.2
    HOMO001      ansible_host=192.168.0.3

    [PROD]
    PROD001     ansible_host=192.168.0.4
    PROD002     ansible_host=192.168.0.5
    PROD003     ansible_host=192.168.0.6

## Testando a conexão

Para verificar se deu certo, você pode rodar o comando :

    ansible myvirtualachines -m ping
    
<b>Obs.: Só vai funcionar dessa forma do comando se tiver authorizedkeys, do contrário informe -k para solicitar a senha, por padrão é usado usuário root, caso queira passar outro usuário use : -u nome_do_usuario </b>

Tendo como retorno: 

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

## Conectando em host windows

Não lembro de ter visto em tutoriais de texto ou video, ensinando como conectar em hosts Windows usando WinRM, então vou ensinar aqui como fazer :

- Requisitos:
  - Powershell 5.1.19041.1237
  - .NET   
    - Client      4.8.04084
    - Full        4.8.04084
    - Client      4.0.0.0
  - Verificar se o WinRM está configurado :
    - winrm get winrm/config/Service

- Configurando e ativando o WinRM :
  - Baixe o script disponibilizado aqui no repositório <b>ConfigureRemotingForAnsible.ps1</b>, é oficial da documentação do Ansible, execute ele com o powershell a nivel de administrador.
  - Ao terminar verifique se deu certo, rode :
    - winrm get winrm/config/Service
- Crie um usuário a nível administrador,esse usuário e senha vão ser usados na configuração do ansible.

- Configurando hosts
  - crie um arquivo .ini ou utilize o /etc/ansible/hosts, fica a seu critério, para facilitar vamos no /etc/ansible/hosts :
  
        [windows]
        192.168.3.5

- Nos tutorias mostram para passar as credenciais no proprio arquivo de hosts, não recomendo, segue abaixo como fazer de forma criptografada usando o ansible vault:

- No terminal rode o comando :
  - ansible-vault create credentials.yml
  - será solicitado que crie um senha para acessar esse .yml
  - ao abrir o vim, passe as variáveis :


        user=usuario
        password=senha

  - salve o arquivo, e agora no playbook ficara da seguinte forma:


        ---
        - name: Manager windows - winRM
          hosts: WINDOWS

          vars_files:
            - credentials.yaml  
        
          vars:
            ansible_user: "{{ user }}"
            ansible_password: "{{ password }}"
            ansible_port: 5986
            ansible_connection: winrm
            ansible_winrm_transport: basic
            ansible_winrm_server_cert_validation: ignore

          become: false
          gather_facts: false
        
          tasks:
            - name: Test connection
              win_ping:
              register: ping

            - debug:
                msg: "Status ping {{ ping }}"


  - Agora execute :
    - ansible-playbook -i win.ini win_ping.yml --ask-vault-pass
    - informe a senha que você criou para o vault

### Dicas ansible-vault
- Comandos :
  - ansible-vault create : para criar um arquivo criptografado
  - ansible-vault edit : para poder editar o arquivo
  - ansible-vault view : para apenas visualizar as informações


## Módulos

Conheço duas formas de usar o Ansible via CLI, usando os módulos :
 - command
 - shell

O módulo command é usado para executar comandos diretamente no shell do sistema operacional no host remoto. Ele é útil para executar comandos simples e diretos, sem a necessidade de interação ou recursos avançados de shell. O comando é executado exatamente como você o especifica, sem passar por um processo de shell intermediário. 

    ansible HOSTS -m command -a 'ls -lha'


O módulo shell permite executar comandos em um shell no host remoto, como bash ou sh. Ele oferece recursos avançados do shell, como redirecionamento de entrada/saída, tubulações, substituição de comandos e variáveis de ambiente. 

    ansible HOSTS -m shell -a 'ls -lha |grep arquivo.txt'

## Playbooks

No Ansible, um playbook é um arquivo YAML que define uma sequência de tarefas a serem executadas em um conjunto de hosts. É a unidade básica de configuração e automação no Ansible. Um playbook descreve o estado desejado do sistema e as ações necessárias para alcançá-lo.

Segue alguns exemplos de playbooks:



- Playbook básico para instalar pacotes em servidores:

        ---
        - name: Instalar pacotes
          hosts: servidores
          tasks:
            - name: Atualizar cache de pacotes
              apt:
                update_cache: yes
              become: true

            - name: Instalar pacotes
              apt:
                name:
                  - pacote1
                  - pacote2
                state: present
              become: true

- Playbook para copiar um arquivo para os servidores:

        ---
        - name: Copiar arquivo
          hosts: servidores
          tasks:
            - name: Copiar arquivo
              copy:
                src: /path/to/source/file
                dest: /path/to/destination/file
              become: true

    
- Playbook para reiniciar um serviço em servidores:

        ---
        - name: Reiniciar serviço
          hosts: servidores
          tasks:
            - name: Reiniciar serviço
              service:
                name: nome_do_servico
                state: restarted
              become: true

- Playbook para gerenciar usuários e grupos:


        ---
        - name: Gerenciar usuários e grupos
          hosts: servidores
          tasks:
            - name: Criar grupo
              group:
                name: nome_do_grupo
                state: present
              become: true

            - name: Criar usuário
              user:
                name: nome_do_usuario
                groups: nome_do_grupo
                password: senha_criptografada
                state: present
              become: true

## Executando um playbook

Para executar um playbook simples :

    ansible-playbook HOST seu-playbook.yml

<b>Obs.1: Caso tenho atribuído become : true indica que a task precisa ser executada com privilégios altos de sudo, então pode ser necessário adicionar --ask-become-pass para fornecer a senha de root</b>
<br>
<b>Obs.2: Caso use authorizedkeys, não é necessário passar senha</b>

## States

Deve ter visto que no playbook sempre tem um "state", é para referenciar a criação/presente, remoção/ausência, etc, vou deixar aqui uma lista :

- present: Indica que o recurso deve estar presente ou criado. Se o recurso já existir, não será feita nenhuma alteração. Caso contrário, o recurso será criado.

- absent: Indica que o recurso deve ser removido ou ausente. Se o recurso existir, será removido. Caso contrário, nenhuma ação será realizada.

- started: Indica que o recurso deve estar em execução. Se o recurso não estiver em execução, ele será iniciado. Caso contrário, nenhuma ação será realizada.

- stopped: Indica que o recurso deve ser interrompido ou parado. Se o recurso estiver em execução, ele será interrompido. Caso contrário, nenhuma ação será realizada.

- restarted: Indica que o recurso deve ser reiniciado. Se o recurso estiver em execução, ele será reiniciado. Caso contrário, o recurso será iniciado.

- reloaded: Indica que o recurso deve ser recarregado. O comportamento exato depende do módulo e do recurso específico. Em geral, isso significa recarregar as configurações sem interromper ou reiniciar o recurso.

- enabled: Indica que o recurso deve estar habilitado para ser iniciado automaticamente no boot do sistema. O comportamento exato depende do módulo e do recurso específico.

- disabled: Indica que o recurso deve estar desabilitado para não ser iniciado automaticamente no boot do sistema. O comportamento exato depende do módulo e do recurso específico.

## Documentação

Toda documentação oficial do Ansible você encontra <a href="https://docs.ansible.com/">aqui</a>!

<b>Favorite</b>
<ul>
<li><a href="https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html">Modulos Ansible - Linux</a></li>
<li><a href="https://docs.ansible.com/ansible/2.9/modules/list_of_windows_modules.html">Modulos Ansible - Windows</a></li>
<li><a href="https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_vars_facts.html">Descobrindo variaveis - facts and magic variables</a></li>
<li><a href="https://docs.ansible.com/ansible/latest/collections/ansible/builtin/service_facts_module.html#examples">Service facts - Obter status de serviços</a></li>
</ul>

## Contribuindo

Qualquer contribuição que você fizer será bem vinda, analisada e se viável, atualizada no projeto!

- 1.Faça um fork do projeto
- 2.Clone o seu fork para sua maquina(git clone url-do-projeto.git)
- 3.Crie um branch para sua modificação/atualização(git checkout -b seu-branch)
- 4.Adicione suas alterações ao git(git add .)
- 5.Confirme suas alterações(git commit -m "texto descritivo do que fez")
- 6.Suba seu branch(git push origin seu-branch)
- 7.Faça uma solicitação de merge request para o branch : updates