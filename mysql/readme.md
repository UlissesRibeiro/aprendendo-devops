# MySQL: Guia Rápido para CRUD e Comandos Essenciais

## Introdução

MySQL é um sistema de gerenciamento de banco de dados relacional de código aberto que é amplamente utilizado para armazenar e gerenciar dados. Este guia fornece uma visão geral básica dos comandos SQL para realizar operações CRUD (Create, Read, Update, Delete) e outros comandos essenciais.

## Instalação

Caso esteja utilizando Linux baseado em Debian :
- apt install mysql-server -y

Caso esteja em Windows, você pode optar por instalar o XAMPP.

### Conectar ao MySQL

Para começar, é necessário conectar ao servidor MySQL. Utilize o seguinte comando:


- mysql -u seu_usuario -p

Digite a senha quando solicitado.

### Criar um Banco de Dados

Para criar um novo banco de dados, utilize o comando:

- CREATE DATABASE nome_do_banco;

### Selecionar um Banco de Dados

Selecione um banco de dados específico para trabalhar:

- USE nome_do_banco;

### Criar uma Tabela

Para criar uma tabela, especifique os nomes das colunas e os tipos de dados:

    CREATE TABLE nome_da_tabela (
        coluna1 tipo1,
        coluna2 tipo2,
        ...,
        PRIMARY KEY (coluna_primaria)
    );

### Inserir Dados (Create)

Adicione registros a uma tabela:

    INSERT INTO nome_da_tabela (coluna1, coluna2, ...) VALUES (valor1, valor2, ...);

### Consultar Dados (Read)

Recupere dados de uma tabela:

    SELECT * FROM nome_da_tabela;

### Filtre os resultados com uma condição:

    SELECT * FROM nome_da_tabela WHERE condicao;

### Atualizar Dados (Update)

Modifique registros existentes:

    UPDATE nome_da_tabela SET coluna1 = novo_valor1, coluna2 = novo_valor2 WHERE condicao;

### Excluir Dados (Delete)

Remova registros de uma tabela:

    DELETE FROM nome_da_tabela WHERE condicao;

### Outros Comandos Essenciais

Mostrar Tabelas

Exiba todas as tabelas em um banco de dados:

    SHOW TABLES;


Estes são comandos SQL básicos para realizar operações CRUD e outros comandos essenciais no MySQL. Lembre-se de substituir os valores específicos, como "seu_usuario", "nome_do_banco", etc., pelos seus próprios. Indico que busque por mais informações, comandos, etc <a href='https://www.w3schools.com/sql/default.asp'>aqui</a> .