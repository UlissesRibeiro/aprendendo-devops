<h1 align=center>Git</h1>

<p>Se você esta aqui no Git, muito provavelmente você sabe usar a ferramenta...ou não, então, vou deixar aqui algumas informações e dicas sobre o uso do Git.</p>

<h3 align=center><b>Configuraçao do Git</b></h3>
<p>Seja no Linux, Mac ou Windows, se faz necessário configurar o Git, para que você possa utilizar a ferramenta, então segue abaixo : <br>

<li><b>git config --global user.name “nome_de_usuario”</b> : para adicionar o usuário.</li>
<li><b>git config --global user.email “email_do_usuario”</b> : para adicionar o e-mail.</li>
<li><b>git config --global core.editor "editor de textos"</b> : para informar o editor de textos que vamos usar.</li> <br>

<p>Para iniciar um projeto, dentro da pasta/diretório, use <b> git init </b>, esse comando vai inicializar o seu repositório local para que possa ser visível como um repositório no git.</p>

<p>Dentro do repositório, agora boa parte do seu trabalho vai ser via terminal/cli, no caso do Linux e Mac, temos o terminal e no caso do Windows é necessário instalar o GitBash para ter uma experiência melhor, e instalar o Terminal, disponível na loja da Microsoft, bastante util para usuários Windows.</p>

<h3 align=center><b>Estados do git</b></h3>
<p>Dentro do repositório, temos os estados dos arquivos, sendo eles : </p> <br>
<li><b>untracked</b> - arquivo criado porém ainda não visto pelo git.</li>
<li><b>unmodified</b> - quando o arquivo criado foi adicionado no git mas sem modificação.</li>
<li><b>modified</b> - quando você modifica e está pronto para ser commitado.</li>
<li><b>stage</b> - quando o arquivo vai ficar sinalizado para ser a versão final.(“salvar a versão”)</li>
<br>
<h3 align=center ><b>Comandos</b></h3><br>

<li><b>git add . ou git add all</b> - Para adicionar os arquivos, ficando "visiveis" ao git.</li>
<li><b>git commit -m</b> - Para "salvar" seu progresso no projeto, normalmente usado quando já esta finalizado, gerando então a "versão" que é de fato, o versionamento.</li>
<li><b>git status</b> - Usado para visualizar o estado do seu projeto, obtendo informações, se tem arquivos ainda não monitorandos no git, etc.</li>
<li><b>git log ou git log --graph</b> - Usado para visualizar o historico, os commits feitos no projeto! Util para voltar/resetar o projeto com base nas hash geradas.</li>
<li><b>git diff</b> - Usada para visualizar as alterações antes de commitar.</li>
<li><b>git push</b> - Para subir o projeto para o repositório remoto.</li>Exemplo : git push origin master
<li><b>git pull</b> - Para atualizar o seu projeto local.</li> Exemplo : git pull origin master
<li><b>git remote -v</b> - Usamo para ver em qual repositorio remoto o projeto local esta vinculado.</li>
<li><b>git remote add</b> - Usado para vincular ao repositorio remoto.</li>Exemplo : git remote add origin git@github.com:devops/git/curso.git .
<li><b>git branch</b> - Usado para visualizar os branchs.</li>
<li><b>git checkout -b NOME_DO_BRANCH</b> - Usado para criar um novo branch.</li>
<li><b>git merge</b>- Usado para mergear o branch ao seu master.</li>
<li><b>git branch -D NOME_DO_BRANCH</b> - Para deletar um branch.</li>

