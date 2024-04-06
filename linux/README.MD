# Linux - Básico

- [Sobre](#sobre)
- [Estrutura de diretórios](#estrutura-de-diretórios)
- [Comandos básicos](#comandos-básicos)
- [Permissões](#permissões)
- [Editores de texto](#editores-de-texto)
- [Compactadores de arquivos](#compactadores-de-arquivos)
- [Gerenciamento de pacotes](#gerenciamento-de-pacotes)
- [Contribuindo](#contribuindo)

### Sobre 🐧

O Linux é um sistema operacional de código aberto baseado no kernel Linux, desenvolvido por Linus Torvalds em 1991. Ele é conhecido pela sua estabilidade, segurança e flexibilidade, sendo amplamente utilizado em servidores, dispositivos embarcados e computadores pessoais. Linus Torvalds, um programador finlandês, iniciou o projeto como um hobby e o transformou em um dos sistemas operacionais mais influentes do mundo. O Linux é distribuído sob a licença GNU General Public License (GPL) e possui uma comunidade global de desenvolvedores contribuindo para seu aprimoramento contínuo.


### Estrutura de diretórios 📁

No Linux temos uma estrutura de diretórios diferente da que estamos acostumados no Windows, sendo assim segue os diretórios e suas devidas "funções" :

- 📁 / : o / é o nosso diretório raiz, equivalente o "disco local c:\ .

- 📁 /bin : aqui temos alguns binários que se assemelham aos .exe do Windows, sendo aqui binários que o usuário consegue executar normalmente.

- 📁 /sbin : binários do sistema que seria para o superusuário executar.

- 📁 /etc : aqui ficam os arquivos de configuração do sistema e das aplicações.

- 📁 /tmp : como o nome sugere, esse path é para arquivos temporários.

- 📁 /boot : arquivos do sistema ds boot.

- 📁 /opt : para aplicações não oficiais.

- 📁 /dev : referente a dispositivos, disco, unidades usb, entre outros.

- 📁 /usr : binários de usuários comuns de sistema e aplicações.

- 📁 /home : aqui normalmente são criadas as pastas referente aos usuários quando criados/adicionados com uma pasta no /home.

- 📁 /var : aqui vão os arquivos de tamanhos variáveis, normalmente arquivos de Log.

- 📁 /mnt e 📁 /media : são onde normalmente montamos unidades de disco.

- 📁 /lib : aqui ficam as bibliotecas e módulos do kernel.


### Comandos básicos

É importante saber alguns comandos ai básicos e essenciais quando você quer entrar na area de T.I, tendo em vista que boa parte dos servidores rodam uma distribuição Linux.

Primeira coisa a se fazer é abrir o terminal, use o atalho ctrl+alt+t(a não ser que você tenha alterado o atalho de abrir o terminal) , abriu? certo.
<strong>Dica : para todos os comandos, você pode usar o <i>--help</i>, obtendo assim informações e variações sobre o comando!</strong>

- ls : Lista os arquivos de um diretório
    - Com o ls você consegue listar tudo que tem dentro do diretório corrente ou de um path especifico.
    - ls -lha : Você consegue ver arquivos e diretórios ocultos, obtendo também informações sobre as permissões.

- cd : Muda o diretório atual
    -   Você pode navegar entra os diretórios usando cd seguindo do path,exemplo :

            cd /home/$USER/Downloads

- pwd: Mostra o diretório atual
    - Ao dar o comando pwd, você consegue ver o path do seu diretório corrente.

- mkdir : Cria diretórios
    - Como o próprio nome diz, você pode criar diretórios
        
            mkdir novo_diretorio
    - Caso queira criar o diretório "pai" seguido do sub-diretório:
            
            mkdir -p /diretorio/sub-diretorio/

- rm e rmdir : 
    - rm , você usa para remover arquivos de um diretório
    - Se o diretório não estiver vazio, você pode passar -r como parametro <b> rm -r /diretorio/</b>
    - Se for um diretório vazio, você pode usar o <b>rmdir</b>


### Permissões

É importante que arquivos e diretórios tenham permissões e por isso precisamos ter um conhecimento básico sobre permissões.

Quando você lista um arquivo por exemplo :
- ls -lha /etc/hosts

você tem retorno de algo assim :

        -rwxr-xr-x hosts

Onde as permissões se dão por

    - - : ausência de permissão 
    - r : permissão de leitura
    - w : permissão de escrita
    - x : permissão de execução

e elas são representadas de forma octal como :

- 0
- 4
- 2
- 1

Exemplo pratico, quando você cria um script, por padrão ele não vai poder ser executado pois ele não tem permissão de execução estando como :

    - rw-rw-rw-

para que seja possível executar temos que dar permissão com o comando "chmod" :

    chmod 777 script.sh

o ideal é dar apenas a permissão necessária, evite usar 777. Também podemos usar dessa forma : 

    chmod u=7,g=7,o=5 script.sh

Assim apenas o usuário e o grupo dono podem executar.

### Editores de texto

Vamos considerar que estamos lhe dando com servidores Linux onde não temos interface gráfica e muito menos um mouse, então é importante saber usar os editores via terminal, eu posso sugerir algumas opções :

- Vi ou Vim : Diria que presente em todas distribuições, um pouco de paciência para aprender a utilizar, mas depois que aprender acho difícil querer voltar pra outro editor.

- Nano : É uma opção mais "amigável" digamos assim, pois você consegue ver uma "interface" com os atalhos que precisa para salvar, pesquisar,etc.

Aprenda a usar o Vim!

Vou facilitar a vida de vocês :

- vim /etc/hosts

aqui apenas abrimos o arquivo de hosts, agora segue alguns comandos :

- i : para que você possa editar o arquivo aperte a tecla "i" note que na parte inferior esquerda vai ficar como -- INSERT -- .

- esc : para sair do modo insert basta apertar "esc".

- :q : permite que você saia do arquivo desde que não tenha feito alterações, caso tenho alterado use :q! a "!" força a saída.

- :w : permite gravar/salvar a alteração , para salvar e sair do arquivo user :w! .

- yy : copiar linha inteira

- p : colar linha

- dd : deletar linha  

- x: Excluir o caractere sob o cursor.

- dw: Excluir a palavra sob o cursor.

- use as teclas de seta para mover o cursor.

- h: Mover para a esquerda.

- j: Mover para baixo.

- k: Mover para cima.

- l: Mover para a direita.

- gg: Ir para o início do arquivo.

- G: Ir para o final do arquivo.

- 0 (zero): Ir para o início da linha.

- $: Ir para o final da linha.

- Ctrl + F: Rolar uma página para frente.

- Ctrl + B: Rolar uma página para trás


### Compactadores de arquivos

 No Linux, compactadores são ferramentas usadas para comprimir arquivos e diretórios, reduzindo seu tamanho para economizar espaço em disco e facilitar o compartilhamento. Abaixo estão alguns dos compactadores mais comuns no ambiente Linux:


- #### tar:
 O "tar" não é exatamente um compactador, mas uma ferramenta de arquivamento que combina vários arquivos em um único arquivo (geralmente com a extensão ".tar"). No entanto, é frequentemente usado em conjunto com outros programas compactadores, como gzip ou bzip2, para criar arquivos compactados.

Exemplo de como criar um arquivo tar:


    tar -cvf arquivo.tar arquivo1 arquivo2 diretorio/

- #### gzip:

É um compactador muito utilizado e rápido, que comprime arquivos individualmente, adicionando a extensão ".gz" ao arquivo compactado.

Exemplo de como compactar um arquivo usando gzip:

    gzip arquivo.txt

- #### bzip2:
Oferece uma taxa de compressão mais alta do que o gzip, mas é um pouco mais lento. Gera arquivos com a extensão ".bz2".

Exemplo de como compactar um arquivo usando bzip2:


    bzip2 arquivo.txt

- #### zip:

Embora seja mais comum em sistemas Windows, também está disponível no Linux. Compacta arquivos e diretórios em um arquivo com a extensão ".zip".

Exemplo de como compactar um arquivo usando zip:

    zip arquivo.zip arquivo1 arquivo2 diretorio/

- #### unzip: 
Permite descompactar arquivos compactados no formato zip.

Exemplo de como descompactar um arquivo zip:

    unzip arquivo.zip

Essas são algumas das ferramentas de compactação mais comuns no Linux. Cada uma possui suas características, como velocidade e taxa de compressão, portanto, a escolha depende das necessidades específicas. Lembre-se de consultar a documentação de cada comando para obter mais opções e informações detalhadas.


### Gerenciamento de pacotes

No Linux, o gerenciamento de pacotes facilita a instalação, atualização, configuração e remoção de software de maneira organizada e automatizada. O gerenciador de pacotes é um conjunto de ferramentas e regras que permitem aos usuários e administradores de sistemas gerenciar de forma eficiente os programas e bibliotecas do sistema.

No Linux, existem várias ferramentas populares de gerenciamento de pacotes, cada uma associada a uma distribuição específica. As duas principais famílias de gerenciadores de pacotes são:

#### Gerenciadores de pacotes baseados em RPM (Red Hat Package Manager):

- exemplo: Red Hat Enterprise Linux (RHEL), CentOS, Fedora, openSUSE.

    - Ferramentas: "yum" (RHEL e CentOS versões mais antigas), "dnf" (RHEL e CentOS versões mais recentes, Fedora e openSUSE).


#### Gerenciadores de pacotes baseados em DEB (Debian Package):

- exemplo: Debian, Ubuntu, Linux Mint.

    - Ferramentas: "apt" (Advanced Package Tool), "apt-get", "aptitude".

Os gerenciadores de pacotes facilitam as seguintes tarefas:

- Instalação de pacotes: Permite que os usuários instalem novos softwares e suas dependências automaticamente, baixando-os dos repositórios oficiais da distribuição.

Exemplo de instalação de um pacote usando "apt" (Debian/Ubuntu):

    sudo apt install nome-do-pacote

Exemplo de instalação de um pacote usando "dnf" (Fedora/RHEL):

    sudo dnf install nome-do-pacote

- Atualização de pacotes: Mantém os softwares atualizados com as versões mais recentes disponíveis nos repositórios oficiais.

Exemplo de atualização de pacotes usando "apt" (Debian/Ubuntu):

    sudo apt update
    sudo apt upgrade

Exemplo de atualização de pacotes usando "dnf" (Fedora/RHEL):

    sudo dnf update

- Remoção de pacotes: Permite que os usuários removam os softwares instalados anteriormente de forma limpa, incluindo suas dependências desnecessárias.

Exemplo de remoção de um pacote usando "apt" (Debian/Ubuntu):

    sudo apt remove nome-do-pacote

Exemplo de remoção de um pacote usando "dnf" (Fedora/RHEL):


    sudo dnf remove nome-do-pacote

- Pesquisa de pacotes: Permite que os usuários encontrem pacotes específicos disponíveis nos repositórios.

Exemplo de pesquisa por um pacote usando "apt" (Debian/Ubuntu):

    apt search nome-do-pacote

Exemplo de pesquisa por um pacote usando "dnf" (Fedora/RHEL):


    dnf search nome-do-pacote

Os gerenciadores de pacotes são uma das características distintivas do Linux e tornam a administração do sistema mais eficiente, segura e organizada. Eles ajudam os usuários a manterem seus sistemas atualizados e a instalar rapidamente novos softwares sem a necessidade de buscar e baixar pacotes manualmente. Além disso, garantem a resolução automática de dependências, evitando problemas de compatibilidade e conflitos entre diferentes softwares instalados.

## Contribuindo

Qualquer contribuição que você fizer será bem vinda, analisada e se viável, atualizada no projeto!

- 1.Faça um fork do projeto
- 2.Clone o seu fork para sua maquina(git clone url-do-projeto.git)
- 3.Crie um branch para sua modificação/atualização(git checkout -b seu-branch)
- 4.Adicione suas alterações ao git(git add .)
- 5.Confirme suas alterações(git commit -m "texto descritivo do que fez")
- 6.Suba seu branch(git push origin seu-branch)
- 7.Faça uma solicitação de merge request para o branch : updates