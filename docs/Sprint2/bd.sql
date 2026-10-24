CREATE DATABASE safelab;
USE safelab;

-- Tabela da Empresa
CREATE TABLE empresa (
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
codigo_ativacao CHAR(7),
status_empresa TINYINT NOT NULL DEFAULT 1 -- 0: desativo, 1: ativo
);

-- Tabela do Funcionário
CREATE TABLE funcionario (
id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
cpf CHAR(11) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
dt_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
nivel_permicoes TINYINT NOT NULL DEFAULT 1, -- 0: sem permição alguma, 1: analisar dashboards, 2: abrir chamados e solicitações, 3: analisar dados sensiveis
fk_empresa INT NOT NULL,
CONSTRAINT ChkFkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE unidade (
id_unidade INT PRIMARY KEY AUTO_INCREMENT,
cep CHAR(8) NOT NULL,
numero_endereco INT NOT NULL,
fk_empresa INT NOT NULL,
CONSTRAINT Chk_Fk_Empresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

-- Tabela do Sensor - para localizarmos cada sensor
CREATE TABLE refrigerador (
id_refrigerador INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
fk_unidade INT NOT NULL,
CONSTRAINT ChkFkUnidade FOREIGN KEY (fk_unidade) REFERENCES unidade(id_unidade)
);

-- Tabela das temperaturas
CREATE TABLE medida_temperatura (
id_medida INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL(4, 1),
dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
fk_refrigerador INT NOT NULL,
CONSTRAINT ChkFkRefrigerador FOREIGN KEY (fk_refrigerador) REFERENCES refrigerador(id_refrigerador)
);

CREATE USER 'usuario_insert'@'%' IDENTIFIED BY '123';
GRANT SELECT, INSERT ON safelab.* TO 'usuario_insert'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'usuario_insert'@'%';

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
CONSTRAINT pkEmpresaFuncionario PRIMARY KEY (fk_empresa, id_funcionario)
);