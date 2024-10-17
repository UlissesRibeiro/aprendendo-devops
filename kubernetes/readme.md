- [O que é o Kubernetes](#o-que-é-o-kubernetes)
- [Arquitetura do k8s](#arquitetura-do-k8s)
- [Conceitos-chave do k8s](#conceitos-chave-do-k8s)
- [Instalando o cluster do k8s](#instalando-o-cluster-k8s)
- [Incializando o cluster](#inicializando-o-cluster)
- [Acessando o ngnix via browser](#acessando-o-nginx-via-browser)
- [Referência](#referência)

# O que é o Kubernetes?

<p>De forma resumida o projeto Kubernetes foi desenvolvido pela Google, em meados de 2014, para atuar como um orquestrador de containers para a empresa. O Kubernetes(K8S), cujo termo signifca "timoneiro", é um projeto <i>open source</i> que conta com <i>design</i> e desenvolvimento baseados no projeto Borg, que também é da Google. Alguns outros produtos disponiveis no mercado,, tais como o Apache Mesos e o Cloud Foundry, também surgiram a partir do projeto Borg.</p>

<p>Como Kubernetes é uma palavra dificil de se pronunciar - e de se escrever - a comunidade simplesmente o apelidou de <b>k8s</b>, seguindo o padrão <a href="http://www.i18nguy.com/origini18n.html">i18n </a>(a letra "k" seguida por oito letras e o "s" no final), pronunciando-se simplesmente "kates".</p>


## Arquitetura do k8s

<p>Assim como os demais orquestradores disponiveis, o k8s também segue um modelo <i>>control plane/workers</i>, constituindo assim um <i>cluster</i>, onde para o seu funcionamento é recomendado no minimo três nós: o nó <i>control-plane</i> responsável (por padrão) pelo gerenciamento do <i>cluster</i>, e os demais como <i>workers</i>, executores das aplicações que queremos executar sobre esse <i>cluster</i>.</p>

<p>É possivel criar um cluster Kubernetes rodando em apenas um nó, porém é recomendado somente para fins de estudos e nunca executado em ambiente de produtivo.
</p>

<p>Caso você queira utilizar o Kubernetes em sua maquina local, em seu desktop, existem diversas soluções que irão criar um cluster Kubernetes, utilizando máquinas virtuals ou o Docker, por exemplo. Com isso você poderá ter um cluster Kubernetes com diversos nós, porém todos eles rodando em sua maquina local, em seu desktop.</p>

Alguns exemplos são :

- <a href="https://kind.sigs.k8s.io/docs/user/quick-start">Kind</a> : Uma ferramenta para execução de containers Docker que simulam o funcionamento de um cluster Kubernetes. É utilizado para fins didaticos, de desenvolvimento e testes. O <b>Kind não deve ser utilizado para produção;</b>

- <a href="https://github.com/kubernetes/minikube">Minikube</a> : Ferramenta para implementar um <i>cluster</i> Kubernetes localmente com apenas um nó. Muito utilizado para fins didáticos, de desenvolvimeno e testes. O <b>Minikube não deve ser utilizado em produção;</b>


## Conceitos-chave do k8s

<p>É importante saber que a forma como o k8s gerencia os containers é ligeiramente diferente de outros orquestradores como o Docker Swarm, sobretudo devido ao fato de que ele não trata os containers diretamente, mas sim através de <i>pods</i>. Vamos conhecer alguns dos principais conceitos que envolvem o k8s a seguir:

- <b>Pod</b> ; É o menor objeto do k8s. Como dito anteriormente, o k8s não trabalha com os containers diretamente, mas organiza-os dentro de <i>pods</i>, que são abstrações que dividem os mesmos recursos, como endereços, volumes, ciclos de CPU e memória. Um pod pode possuir varios conatiners;

- <b>Deployment</b> : É um dos principais <i>controllers</i> utilizados. O deploymente, em conjunto com o ReplicaSet, garante que determinado número de réplicas de um pod esteja em execução nos nós workers do cluster. Além disso, o Deployment também é responsável por gerenciar o ciclo de vida das aplicações, onde caracteristicas associadas a aplicação, tais como imagem, porta, volumes e variaves de ambiente, podem ser especificados em arquivos do tipo yaml ou json para posteriormente serem passados como parametro para o <b>kubectl</b> executar o deploymente. Esta ação pode ser executada tanto para criação quanto para atualização e remoção do deployment;

- <b>ReplicaSet</b> : É um objeto responsável por garantir a quantidade de pods em execução no nó;

- <b>Services</b> : É um forma de vocês expor a comunicação através de um ClusterIP, NodePort ou LoadBalancer para distribuir as requisições entre os diversos Pods daquele Deployment. Funciona como um balanceador de carga.

## Instalando o cluster k8s

Aqui iremos focar na instalação utilizando o kubeadm, que é uma das formas mais antigas para a criação de um cluster kubernetes. Mas existem outras formas de instalar, como kubespray que utiliza Ansible para implementar e gerenciar o cluster.

- Pre-requesitos
    - Linux
    - 2 GB de RAM ou mais por máquina
    - 2 CPUs ou mais
    - Conexão de rede entre todos os nodes no cluster

### Desativando o uso do swap no sistema

Primeiro, vamos desativar a utilização de swap no sistema. Isso é necessário porque o Kubernetes não trabalha bem com swap ativado:

    sudo swapoff -a

### Carregando os módulos do kernel

Agora, vamos carregar os módulos do kernel necessários para o funcionamento do Kubernetes:

    cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
    overlay
    br_netfilter
    EOF

    sudo modprobe overlay
    sudo modprobe br_netfilter

### Configurando parâmetros do sistema

Em seguida, vamos configurar alguns parâmetros do sistema. Isso garantirá que nosso cluster funcione corretamente:

    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
    net.bridge.bridge-nf-call-iptables  = 1
    net.bridge.bridge-nf-call-ip6tables = 1
    net.ipv4.ip_forward                 = 1
    EOF

    sudo sysctl --system


### Instalando os pacotes do Kubernetes

    apt update && apt install -y apt-transport-https curl

    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

    apt-get update
    apt-get install -y kubelet kubeadm kubectl

Se já tiver instalado o docker não tem problemas, caso contrario, pode optar por instalar apenas o containerd, que é container runtime, enquanto o docker é o engine, para insalar o containerd:

    apt install containerd -y

### Configurando o containerd

Agora, vamos configurar o containerd para que ele funcione adequadamente com o nosso cluster:

    sudo containerd config default | sudo tee /etc/containerd/config.toml

    sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml

    sudo systemctl restart containerd
    sudo systemctl status containerd

### Habilitando o serviço do kubelet

Por fim, vamos habilitar o serviço do kubelet para que ele inicie automaticamente com o sistema:

    sudo systemctl enable --now kubelet

### Inicializando o cluster

Agora que temos tudo configurado, vamos iniciar o nosso cluster:

    sudo kubeadm init --apiserver-advertise-address=<O IP QUE VAI FALAR COM OS NODES>
 

Substitua "O IP QUE VAI FALAR COM OS NODES" pelo endereço IP da máquina que está atuando como control plane.


<p>Ao terminar o processo do kubeadm, teremos no final a mensagem abaixo :


    To start using your cluster, you need to run the following as a regular user:

    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    Alternatively, if you are the root user, you can run:

    export KUBECONFIG=/etc/kubernetes/admin.conf

    You should now deploy a pod network to the cluster.
    Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
    https://kubernetes.io/docs/concepts/cluster-administration/addons/

    Then you can join any number of worker nodes by running the following on each as root:

    kubeadm join 172.31.57.89:6443 --token if9hn9.xhxo6s89byj9rsmd \
        --discovery-token-ca-cert-hash sha256:ad583497a4171d1fc7d21e2ca2ea7b32bdc8450a1a4ca4cfa2022748a99fa477 
</p>

Basta seguir os passos informados na mensagem, para fazer com que os workers se juntem ao cluster. Após executar o join em cada worker node, vá até o node que criamos para ser o control plane, e execute:

    kubectl get nodes
 

    NAME     STATUS   ROLES           AGE   VERSION
    k8s-01   NotReady    control-plane   4m   v1.26.3
    k8s-02   NotReady    <none>          3m   v1.26.3
    k8s-03   NotReady    <none>          3m   v1.26.3

Agora você já consegue ver que os dois novos nodes foram adicionados ao cluster, porém ainda estão com o status Not Ready, pois ainda não instalamos o nosso plugin de rede para que seja possível a comunicação entre os pods. Vamos resolver isso agora. :)

### Instalando o Weave Net

Agora que o cluster está inicializado, vamos instalar o Weave Net:

    kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
 

Aguarde alguns minutos até que todos os componentes do cluster estejam em funcionamento. Você pode verificar o status dos componentes do cluster com o seguinte comando:

    kubectl get pods -n kube-system
 

    kubectl get nodes
 

    NAME     STATUS   ROLES           AGE   VERSION
    k8s-01   Ready    control-plane   7m   v1.26.3
    k8s-02   Ready    <none>          6m   v1.26.3
    k8s-03   Ready    <none>          6m   v1.26.3
 

O Weave Net é um plugin de rede que permite que os pods se comuniquem entre si. Ele também permite que os pods se comuniquem com o mundo externo, como outros clusters ou a Internet. Quando o Kubernetes é instalado, ele resolve vários problemas por si só, porém quando o assunto é a comunicação entre os pods, ele não resolve. Por isso, precisamos instalar um plugin de rede para resolver esse problema.

### O que é o CNI?

<p>CNI é uma especificação e conjunto de bibliotecas para a configuração de interfaces de rede em containers. A CNI permite que diferentes soluções de rede sejam integradas ao Kubernetes, facilitando a comunicação entre os Pods (grupos de containers) e serviços.</p>

<p>Com isso, temos diferentes plugins de redes, que seguem a especificação CNI, e que podem ser utilizados no Kubernetes. O Weave Net é um desses plugins de rede.</p>

<p>Pronto, já temos o nosso cluster inicializado e o Weave Net instalado. Agora, vamos criar um Deployment para testar a comunicação entre os Pods.</p>

    kubectl create deployment nginx --image=nginx --replicas 3
 

    kubectl get pods -o wide
 

    NAME                     READY   STATUS    RESTARTS   AGE   IP          NODE     NOMINATED NODE   READINESS GATES
    nginx-748c667d99-8brrj   1/1     Running   0          12s   10.32.0.4   k8s-02   <none>           <none>
    nginx-748c667d99-8knx2   1/1     Running   0          12s   10.40.0.2   k8s-03   <none>           <none>
    nginx-748c667d99-l6w7r   1/1     Running   0          12s   10.40.0.1   k8s-03   <none>           <none>
 

Pronto, nosso cluster está funcionando e os Pods estão em execução em diferentes nós.

### Acessando o nginx via browser

<p>Para que seja possivel que você acesse a aplicação do ngnix que criamos via browser é necessario que façamos o expose do serviço(de grosso modo, expor a porta 80). Podemos fazer isso de 3 formas diferentes:

- ClusterIP :
    
        kubectl expose pod nginx ou kubectl expose pod nginx --type=ClusterIP
        Fará que a comunicação aconteça apenas dentro do cluster, interanmente.

- NodePort :

        kubectl expose pod nginx --type=NodePort --port=80
        Ao rodarmos kubectl get svc veremos que teremos a porta 80 do pod, que para acessar precisamos ir na porta 32XXX/TCP

        NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
        nginx        NodePort    10.96.0.1       <none>        80:32xxx/TCP   1m
        Acessando http://ip-do-cluster:32XXX


- LoadBalancer : Para pode acessar dessa forma, seria necessário que o cluser estivesse numa cloud, porém temos como fazer isso localmente, em ambiente on-premise, utilizando do metalLB


        kubectl expose deployment nginx --port=80 --target-port=80 --type=LoadBalancer


        kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.8/config/manifests/metallb-native.yaml



- Crie um arquivo de configuração para o IPAddressPool:

Você precisa definir o intervalo de IPs que o MetalLB pode usar. Crie um arquivo chamado metallb-config.yaml com o seguinte conteúdo:


        apiVersion: metallb.io/v1beta1
        kind: IPAddressPool
        metadata:
            name: default-address-pool
            namespace: metallb-system
        spec:
            addresses:
            - 192.168.1.240-192.168.1.250  # Substitua este intervalo pelo da sua rede
        ---
        apiVersion: metallb.io/v1beta1
        kind: L2Advertisement
        metadata:
            name: default
            namespace: metallb-system


Aqui, estamos configurando um pool de IPs no intervalo de 192.168.1.240 a 192.168.1.250. Substitua esse intervalo de IPs por um disponível na sua rede.

- Aplique o arquivo de configuração:

Depois de criar o arquivo metallb-config.yaml, aplique-o ao cluster:


    kubectl apply -f metallb-config.yaml

- Verifique se o IPAddressPool foi criado corretamente:

        kubectl get ipaddresspool -n metallb-system

Rodando kubectl get svc, você vera que na coluna EXTERNAL-IP agora teremos o IP para acessar diretamente a aplicação sem ter que passar a porta.

### Instalação do ingress

    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

    kubectl create ingress app-k8s-ingress --rule="app.local/*=app-k8s-service:3000" --dry-run=client -o yaml > ingress.yaml


# Referência

- <a href="https://github.com/linuxtips/MesDoKubernetes/tree/main/semana1">MêsDoKubernets - LinuxTips</a>