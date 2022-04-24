# PSET 1# PSET 1

## Git

O _Git_ é um sistema de controle de versões distribuído, ou seja, ele serve para controlarmos o histórico de alterações dos nossos arquivos e de nossos projetos.
O _Git_ nasceu e foi tomando espaço dos outros sistemas de controle. Seu criador principal é o mesmo que o do Linux: Linus Torvalds, e ganhou o coração das pessoas que trabalham com open source.

## GitHub

Já o _GitHub_ é um site de hospedagem de códigos e arquivos de controle de versão em git. Nele, podemos compartilhar os nossos projetos com outras pessoas e até mesmo contribuir com o projeto de terceiro.
## SQL Power Architect - Modelo do Elmasri

Para o início do PSET, comecei reconstruindo as tabelas apresentada por Elmasri, utilizando o _SQL Power Architect_, a qual cada relação e cada atributo foi comentado conforme requisitado. Ao finalizar as tabelas ela ficou deste jeito:

![imagem](bdFuncionarios.PNG)

Podendo ser visualizada no subdiretório o código que foi gerado e usado para dar continuação no _PostgreSQL_ e _MySQL_.


## Implementação no PostgreSQL

 Usando o _terminal Linux_, fiz as atualizações que se pedia na orientação do professor, logo em seguida criei meu usuário e inseri uma senha para esse usuário no _postgreSQL_ usando o _terminal Linux_ com os seguintes comandos:
 >Lembrando! Durante o processo, foi exigida algumas senhas, ao qual estavam no documento fornecido pelo professor.

 ```
 su - postgres

 psql

 create user filipebm superuser inherit createdb createrole;

 alter user filipebm password '5123';
```
Após ter criado meu usuário, tive que criar o banco de dados **uvv**:

```
create database uvv
with
owner = 'filipebm'
template = template0
encoding = 'UTF8'
lc_collate = 'pt_BR.UTF-8'
lc_ctype = 'pt_BR.UTF-8'
allow_connections = true:

```
Agora a conexão entre banco de dados com o usuário:
```
\c uvv filipebm;
```
Feito isso, criei o schema _elmasri_ que foi pedido:
```
create schema elmasri
authorization "filipebm";
```
Ajustando o esquema _elmasri_ como padrão:
```
alter user "filipebm"
set search_path to elmasri, "\user", public;
```
Se encerrando esse processo, acessei o _postgreSQL_ para ver se estava tudo de acordo com que foi implementado. E dei continuidade com o que foi feito no _SQL Power Architect_.

## MySQL

De início criei o user filipebm:
```
create user 'filipebm'@'localhost' identified by '5123';
```
E criei a database **uvv**:
```
create database uvv;
```
Logo, nosso usuário 'filipebm' recebeu privilégios:
```
grant all on uvv.* to 'filipebm'@'localhost';
```
E se conectei ao _MySQL_ com usuário que acabei de criar:
```
mysql> system mysql -u filipebm -p
```
Veriquei os bancos de dados com o comando `show databases;` e entrei no banco de dados **UVV** com o comando `use uvv;`:
```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| uvv                |
+--------------------+
2 rows in set (0.00 sec)

mysql> use uvv;
Database changed
```
Apartir daqui, copiei todo o processo efetuado no _SQL Power Architect_.

>Scripts com uma explicação mais detalhadas, podem ser encontrados logo acima deste readme.
>Para o SQL Power Architect utilizar o elmasri.architect, para o PostgreSQL utilizar PostgreSQL.txt, para MySQL Script_MySQL.sql.
