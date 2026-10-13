CREATE DATABASE safelab;
USE safelab;

-- Tabela da Empresa
CREATE TABLE empresa (
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
codigo_ativacao CHAR(7) NOT NULL,
status_empresa TINYINT NOT NULL DEFAULT 1 -- 0: desativo, 1: ativo
);

-- Tabela do Funcionário
CREATE TABLE funcionario (
id_funcionario INT,
cpf CHAR(11) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
dt_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
nivel_permicoes TINYINT NOT NULL DEFAULT 1, -- 0: sem permição alguma, 1: analisar dashboards, 2: abrir chamados e solicitações, 3: analisar dados sensiveis
fk_empresa INT NOT NULL,
CONSTRAINT ChkFkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
CONSTRAINT pkFkEmpresaIdFuncionario PRIMARY KEY (id_funcionario, fk_empresa)
);

CREATE TABLE unidade (
id_unidade INT, 
nome varchar(60) NOT NULL,
cep CHAR(8) NOT NULL,
numero_endereco INT NOT NULL,
fk_empresa INT NOT NULL,
CONSTRAINT Chk_Fk_Empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
CONSTRAINT pkFkEmpresaIdUnidade PRIMARY KEY (id_unidade, fk_empresa)
);

-- Tabela do refrigerador
CREATE TABLE refrigerador (
id_refrigerador INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
status_refrigerador TINYINT NOT NULL DEFAULT 1, -- 1: Ativo, 0: inativo
fk_unidade INT NOT NULL,
CONSTRAINT ChkFkUnidade FOREIGN KEY (fk_unidade) REFERENCES unidade(id_unidade)
);

-- Tabela do Sensor - para localizarmos cada sensor
CREATE TABLE sensor (
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
ip INT NOT NULL,
status_sensor TINYINT NOT NULL DEFAULT 1, -- 1: Ativo, 0: inativo
dt_manutencao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
fk_refrigerador INT UNIQUE NOT NULL,
CONSTRAINT ChkFkRefrigerador FOREIGN KEY (fk_refrigerador) REFERENCES refrigerador(id_refrigerador)
);
-- Tabela das temperaturas
CREATE TABLE medida_temperatura (
id_medida INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL(4, 1) NOT NULL,
dt_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
fk_sensor INT NOT NULL,
CONSTRAINT ChkFkSensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor)
);

CREATE TABLE alerta (
id_alerta INT PRIMARY KEY AUTO_INCREMENT,
tipo_alerta TINYINT NOT NULL, -- 1: Temperatura fora da faixa, 2: Temperatura Crítica
fk_medida INT NOT NULL,
CONSTRAINT ChkFkMedida FOREIGN KEY (fk_medida) REFERENCES medida_temperatura(id_medida)
);

/* CREATE USER 'usuario_insert'@'%' IDENTIFIED BY '123';
GRANT SELECT, INSERT ON safelab.* TO 'usuario_insert'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'usuario_insert'@'%'; /

/ CREATE TABLE funcionario (
id_funcionario INT,
cpf CHAR(11) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
dt_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
nivel_permicoes TINYINT NOT NULL DEFAULT 1, -- 0: sem permição alguma, 1: analisar dashboards, 2: abrir chamados e solicitações, 3: analisar dados sensiveis
fk_empresa INT NOT NULL,
CONSTRAINT ChkFkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
CONSTRAINT pkEmpresaFuncionario PRIMARY KEY (fk_empresa, id_funcionario)
); */