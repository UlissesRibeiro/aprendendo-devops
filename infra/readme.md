# O que instalar no S.O de alguém de infra

<p>Vou listar aqui ferramentas que considero importante de ter instalado em meu ambiente de trabalho, atualmente utilizo Linux (Kali e Ubuntu 22).
</p>

- [Terminator](#terminator)
- [Vim](#vim)
- [Barrier-kvm](#barrier-kvm)
- [XCA](#xca---certificate-and-key-management)
- [Git](#git)
- [GParted](#gparted)
- [CFdisk](#cfdisk)
- [Docker](#docker)
- [Ansible](#ansible)
- [Anydesk e TeamViewer](#anydesk-e-teamviewer)
- [Remmina e xfreerdp](#remmina-e-xfreerdp)
- [Nmap | OpenVAS | Shodan](#nmap--openvas--shodan)


### Terminator

<img src="images/terminator.png" width="50">

Permite que você ajuste a tela do seu terminal da forma que melhor lhe agradar, sem ter que abrir varios terminais separados.Mais informações<a href="https://gnome-terminator.org/"> aqui</a> .

        apt install terminator -y


<img src="https://gnome-terminator.org/assets/images/terminator-vim-shells-dark-1.png" width="500">

### Vim

<img src="images/vim.png" width="50">

Pra mim o melhor editor de textos para se usar no terminal, depois que você migra pro Vim, não tem como voltar a usar o nano. Mais informações <a href="https://www.vim.org/"> aqui </a>.

        apt install vim  -y

<img src="images/vim_terminal.png" width="500">

### Barrier-kvm

<img src="images/barrier.jpg" width="50">

Uma alternativa gratuita ao Synergy, o Barrier você consegue compartilhar o mesmo teclado e mouse com varios dispositivos na mesma rede, ideal quando trabalhamos com notebook e desktop em paralelo e independente do S.O. Mais informações <a href="https://github.com/debauchee/barrier"> aqui </a>.

        apt install barrier -y

        ou

        snap install barrier-kvm

<img src="https://a.fsdn.com/con/app/proj/barrier.mirror/screenshots/barrier%201.png/max/max/1" width="500">

<b>Se atente a instalar de preferência a mesma versão nos demais dispositivos</b>

### XCA - Certificate and Key management

<img src="images/xca.png" width="50">

É uma ferramenta que permite você gerenciar certificados, extrair dados, incluindo até criptografados .pfx , mais informações <a href="https://hohnstaedt.de/xca/"> aqui </a>.

        apt install xca -y

<img src="https://eduardomozartdeoliveira.files.wordpress.com/2023/02/xca.png?w=995" width="500">

<b>Claro que também podemos fazer isso usando o openssl. </b>

### Git

<img src="images/git.png" width="50">

Cara, sempre vai ter alguém que vai apagar aquele arquivo rc.local onde você subia suas gambiarras e você tem que refazer e as vezes pode nem lembrar, então aprenda a usar git e a versionar tudo que for importante no seu ambiente.

        apt install git -y


### GParted

<img src="images/gparted.png" width="50">

Gosto de usar o GParted quando se trata de mexer com partições de disco, ainda mais em ambientes de produção! Mais informações <a href="https://gparted.org/download.php"> aqui </a> .

        apt install gparted -y

<img src="images/gparted_gui.png" width="500">

<b>Também tem a opção o cfdisk para usar via cli ou fdisk</b>

### CFdisk

É que nem que igual ao fdisk, só que melhor! Apenas acho melhor.

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Cfdisk_util_linux.png/800px-Cfdisk_util_linux.png?20131129184604" width="500">


### Docker

<img src="images/docker.png" width="50">

Nos dias de hoje é quase impossivel viver sem um container pra resolver um problema por menor seja, pra evitar de quebrar meu ambiente, prefiro usar container. Mais informações <a href="https://www.docker.com/"> aqui </a> .

        curl -fsSl https://get.docker.com | sh


### Ansible

<img src="images/ansible.png" width="50">

Eu não sei vocês, mas eu não gosto de ter que ficar entrando em mais de 150 VMs para configurar a mesma coisa em cada uma, sendo que da pra automatizar, é como diz Buda "se ta no jogo é pra usar!".

### Anydesk e Teamviewer

<img src="images/anydesk.png" width="50"> <img src="images/teamviewer.png" width="50">

Como trabalho com acesso remoto para suporte aos usuários, é sempre bom ter uma ou mais opções de ferramentas para acesso remoto, prefiro o TeamViewer!

- <a href="https://anydesk.com/pt"> Anydesk </a>
- <a href="https://www.teamviewer.com/pt-br/"> TeamViewer </a>

### Remmina e xfreerdp

<img src="images/remmina.svg" width="50">
<img src="https://avatars.githubusercontent.com/u/663376?s=200&v=4" width="50">

Agora para acessar usando RDP, uso o Remmina e xfreerdp, a diferença é que o xfreerdp é via terminal.

- <a href="https://github.com/FreeRDP"> xfreerdp </a>
- <a href="https://remmina.org/"> Remmina </a>

### Nmap | OpenVAS | Shodan

<img src="https://nmap.org/images/sitelogo.png" width="50">
<img src="https://miro.medium.com/v2/resize:fit:720/format:webp/1*9DVrZxotpSyGHYKS6uT9vA.jpeg" width="50">
<img src="https://www.shodan.io/static/img/logo-6abcc86b.png" width="50">


O Nmap é uma ferramenta bastente util no meu dia-a-dia, quando precisamos saber quais IPs temos disponiveis numa faixa de rede, para mapear portas, assim como até descobrir possiveis vulnerabilidades.

O OpenVAS utilizo quando necessário para varrer um hosts especifico, segue a mesma ideia do nmap.

Shodan, é meu bichinho de Deus, não deixe seu server com usuario e senha admin/admin .

- <a href="https://nmap.org/"> Nmap </a>
        
        apt install nmap -y

- <a href="https://github.com/mikesplain/openvas-docker"> OpenVAS </a>

        docker run -d -p 443:443 -e PUBLIC_HOSTNAME=myopenvas.example.org --name openvas mikesplain/openvas


- <a href="https://www.shodan.io/"> Shodan </a>

        Você pode instalar se quiser, ou usar direto no navegador mesmo!