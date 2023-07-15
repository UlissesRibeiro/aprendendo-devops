# Indice

- [Git](#git)
- [Instalação](#instalação)
- [Configurando o Git](#configurando-o-git)
- [Estados do Gir](#estados-do-git)
- [Comandos](#comandos)
- [Extra](#extra)
- [Contribuindo](#contribuindo)

## Git

Git pronuncia-se [git] (ou /ɡɪt/ em inglês britânico[2][3]) é um sistema de controle de versões distribuído, usado principalmente no desenvolvimento de software, mas pode ser usado para registrar o histórico de edições de qualquer tipo de arquivo (Exemplo: alguns livros digitais são disponibilizados no GitHub e escrito aos poucos publicamente). 

<i>Trecho retirado da <a href="https://pt.wikipedia.org/wiki/Git">wiki</a></i>

## Instalação

<b>Obs.: Estou utilizando Linux Ubuntu</b>

Para instalar o git no Ubuntu, é simples : apt install git -y
<br>
Rapigo e fácil, mais fácil do que tomar sorvete no sol. Ta usando Windows?
<br>Relaxa o coração : você instalar o git para Windows <a href="https://git-scm.com/downloads">aqui</a>

## Configurando o Git

Seja no Linux, Mac ou Windows, se faz necessário configurar o Git, para que você possa utilizar a ferramenta, então segue abaixo : 

 - git config --global user.name “nome_de_usuario” : para adicionar o usuário.
 - git config --global user.email “email_do_usuario” : para adicionar o e-mail.
 - git config --global core.editor "editor de textos" : para informar o editor de textos que vamos usar.


Para iniciar um projeto, dentro da pasta/diretório, use <b> git init </b>, esse comando vai inicializar o seu repositório local para que possa ser visível como um repositório no git.

<p>Dentro do repositório, agora boa parte do seu trabalho vai ser via terminal/cli, no caso do Linux e Mac, temos o terminal e no caso do Windows é necessário instalar o GitBash para ter uma experiência melhor, e instalar o Terminal, disponível na loja da Microsoft, bastante util para usuários Windows.</p>

## Estados do git

<p>Dentro do repositório, temos os estados dos arquivos, sendo eles : </p> 

    - untracked - arquivo criado porém ainda não visto pelo git.

    - unmodified - quando o arquivo criado foi adicionado no git mas sem modificação.

    - modified - quando você modifica e está pronto para ser commitado.

    - stage - quando o arquivo vai ficar sinalizado para ser a versão final.(“salvar a versão”)
<br>

## Comandos


- git add . ou git add all - Para adicionar os arquivos, ficando "visíveis" ao git.
- git commit -m - Para "salvar" seu progresso no projeto, normalmente usado quando já está finalizado, gerando então a "versão" que é de fato, o versionamento.
- git status - Usado para visualizar o estado do seu projeto, obtendo informações, se tem arquivos ainda não monitorados no git, etc.
- git log ou git log --graph - Usado para visualizar o histórico, os commits feitos no projeto! Útil para voltar/resetar o projeto com base nas hash geradas.
- git diff - Usada para visualizar as alterações antes de commitar.
- git push - Para subir o projeto para o repositório remoto. Exemplo: git push origin master.
- git pull - Para atualizar o seu projeto local. Exemplo: git pull origin master.
- git remote -v - Usado para ver em qual repositório remoto o projeto local está vinculado.
- git remote add - Usado para vincular ao repositório remoto. Exemplo: git remote add origin git@github.com:devops/git/aprendendo-devops.git.
- git branch - Usado para visualizar os branches.
- git checkout -b NOME_DO_BRANCH - Usado para criar um novo branch.
- git merge - Usado para mesclar o branch ao seu master.
- git branch -D NOME_DO_BRANCH - Para deletar um branch.

## Extra

Tenho um docs mais detalhado sobre o git <a href="https://docs.google.com/document/d/188Xyd2UXflLi-h7_pAEUnvu-ZR03_gVrwFU4SkNXVNs/edit?usp=sharing">aqui</a>


## Contribuindo

Qualquer contribuição que você fizer será bem vinda, analisada e se viável, atualizada no projeto!

- 1.Faça um fork do projeto
- 2.Clone o seu fork para sua maquina(git clone url-do-projeto.git)
- 3.Crie um branch para sua modificação/atualização(git checkout -b seu-branch)
- 4.Adicione suas alterações ao git(git add .)
- 5.Confirme suas alterações(git commit -m "texto descritivo do que fez")
- 6.Suba seu branch(git push origin seu-branch)
- 7.Faça uma solicitação de merge request para o branch : updates
