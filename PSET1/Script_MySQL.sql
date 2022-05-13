/* CRIANDO USUÁRIO */
create user 'filipebm'@'localhost' identified by '5123';
/* CRIANDO BANCO DE DADOS UVV */
create database uvv;
/* USUÁRIOS 'filipebm' RECEBE PRIVILÉGIOS PARA O BANCO DE DADOS UVV */
grant all on uvv.* to 'filipebm'@'localhost';
/* CONECTO O 'filipebm' AO MYSQL */
system mysql -u filipebm -p
/* ENTRO NO BANCO DE DADOS uvv */
use uvv
/* CRIAÇÃO DE TABELA E SEUS COMENTARIOS */
CREATE TABLE funcionarios (
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                cpf CHAR(11) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(55),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                numero_departamento INT NOT NULL,
                cpf_supervisor CHAR(11) NOT NULL,
                PRIMARY KEY (cpf)
);
ALTER TABLE funcionarios COMMENT 'Tabela que armazena as informações dos funcionários.';
ALTER TABLE funcionarios MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário. Será a PK da tabela.';
ALTER TABLE funcionarios MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário.';
ALTER TABLE funcionarios MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';
ALTER TABLE funcionarios MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.';
ALTER TABLE funcionarios MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do funcionário.';
ALTER TABLE funcionarios MODIFY COLUMN endereco VARCHAR(30) COMMENT 'Endereço do funcionário.';
ALTER TABLE funcionarios MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';
ALTER TABLE funcionarios MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário do funcionário.';
ALTER TABLE funcionarios MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento do funcionário. FK de departamento';
ALTER TABLE funcionarios MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'Cpf do supervisor. É FK da própria tabela.';
ALTER TABLE funcionarios
ADD CHECK (sexo in('M', 'm', 'F', 'f'));
ALTER TABLE funcionarios 
ADD CHECK (salario>=0.0);



CREATE TABLE dependentes (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);
ALTER TABLE dependentes COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';
ALTER TABLE dependentes MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. PK desta tabela e FK de funcionário.';
ALTER TABLE dependentes MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';
ALTER TABLE dependentes MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';
ALTER TABLE dependentes MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';
ALTER TABLE dependentes MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.';
ALTER TABLE dependentes
ADD CHECK (sexo in('M', 'm', 'F', 'f'));



CREATE TABLE departamentos (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);
ALTER TABLE departamentos COMMENT 'Tabela que armazena as informaçoẽs dos departamentos.';
ALTER TABLE departamentos MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É a PK desta tabela.';
ALTER TABLE departamentos MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento. Deve ser único.';
ALTER TABLE departamentos MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'CPF do gerente do departamento.FK de funcionários.';
ALTER TABLE departamentos MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data do início do gerente no departamento.';
CREATE UNIQUE INDEX departamentos_idx
 ON departamentos
 ( nome_departamento );



CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);
ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';
ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';
ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. PK desta tabela.';



CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);
ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';
ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. É a PK desta tabela.';
ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto. Deve ser único.';
ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';
ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É uma FK de departamento.';
CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );



CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);
ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. PK desta tabela e FK de funcionário.';
ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. PK desta tabela e FK de projeto.';
ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';
ALTER TABLE trabalha_em
ADD CHECK (horas>=0.0);



ALTER TABLE departamentos ADD CONSTRAINT funcionarios_departamentos_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



ALTER TABLE dependentes ADD CONSTRAINT funcionarios_dependentes_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



ALTER TABLE trabalha_em ADD CONSTRAINT funcionarios_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



ALTER TABLE funcionarios ADD CONSTRAINT funcionarios_funcionarios_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionarios (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



ALTER TABLE projeto ADD CONSTRAINT departamentos_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamentos (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamentos_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamentos (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;



ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;





INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('Jorge', 'E', 'Brito', '88866555576', '1937-11-10','RuadoHorto35,SãoPaulo,SP', 'M', '55000', '88866555576', 1 );
INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20','AvArthurLima54,SantoAndré,SP', 'F', '43000', '88866555576', 4 );
INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19','RuaSouzaLima35,Curitiba,PR', 'F', '25000', '98765432168', 4 );
INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('André', 'V', 'Pereira', '98798798733', '1969-03-29','RuaTimbira35,SãoPaulo,SP', 'M', '25000', '98765432168', 4 );
INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('Fernando', 'T', 'Wong', '33344555587', '1955-12-08','RuadaLapa34,São Paulo,SP', 'M', '40000', '88866555576', 5 );
INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('João', 'B', 'Silva', '12345678966', '1965-01-09','RuadasFlores751,SãoPaulo,SP', 'M', '30000', '33344555587', 5 );
INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15','RuaRebouças65,Piracicaba,SP', 'M', '38000', '33344555587', 5 );
INSERT INTO funcionarios(primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento ) 
VALUES ('Joice', 'A', 'Leite', '45345345376', '1972-07-31','AvLucasObes74,SãoPaulo,SP', 'F', '25000', '33344555587', 5 );



INSERT INTO departamentos( nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES( 'Matriz', 1, '88866555576', '1981-06-19');
INSERT INTO departamentos( nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES( 'Pesquisa', 5, '33344555587', '1988-05-22');
INSERT INTO departamentos( nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES( 'Administração', 4, '98765432168', ' 1995-01-01');



INSERT INTO localizacoes_departamento( numero_departamento, local)
VALUES( 1, ' São Paulo');
INSERT INTO localizacoes_departamento( numero_departamento, local)
VALUES( 4, ' Mauá');
INSERT INTO localizacoes_departamento( numero_departamento, local)
VALUES( 5, ' Santo André');
INSERT INTO localizacoes_departamento( numero_departamento, local)
VALUES( 5, ' Itu');
INSERT INTO localizacoes_departamento( numero_departamento, local)
VALUES( 5, ' São Paulo');



INSERT INTO projeto( nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES( 'ProdutoX', 1, 'Santo André', 5);
INSERT INTO projeto( nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES( 'ProdutoY', 2, 'Itu', 5);
INSERT INTO projeto( nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES( 'ProdutoZ', 3, 'São Paulo', 5);
INSERT INTO projeto( nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES( 'Informatização', 10, 'Mauá', 4);
INSERT INTO projeto( nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES( 'Reorganização', 20, 'São Paulo', 1);
INSERT INTO projeto( nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES( 'Novosbenefícios', 30, 'Mauá', 4);



INSERT INTO dependentes( cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES( '33344555587', 'Alícia', 'F', '1986-04-05', 'Filha');
INSERT INTO dependentes( cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES( '33344555587', 'Tiago', 'M', '1983-10-25', 'Filho');
INSERT INTO dependentes( cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES( '33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa');
INSERT INTO dependentes( cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES( '98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO dependentes( cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES( '12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO dependentes( cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES( '12345678966', 'Alícia', 'F', '1988-12-30', 'Filha');
INSERT INTO dependentes( cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES( '12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');



INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '12345678966', 1, '32.5');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '12345678966', 2, '7.5');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '66688444476', 3, '40.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '45345345376', 1, '20.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '45345345376', 2, '20.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '33344555587', 2, '10.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '33344555587', 3, '10.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '33344555587', 10, '10.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '33344555587', 20, '10.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '99988777767', 30, '30.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '99988777767', 10, '10.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '98798798733', 10, '35.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '98798798733', 30, '5.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '98765432168', 30, '20.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '98765432168', 20, '15.0');
INSERT INTO trabalha_em( cpf_funcionario, numero_projeto, horas)
VALUES( '88866555576', 20, '0');
