CREATE DATABASE safelab;
USE safelab;

-- Tabela da Empresa
CREATE TABLE empresa (
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
status_empresa TINYINT NOT NULL DEFAULT 1 -- 0: desativo, 1: ativo
);

-- Tabela de Unidade
CREATE TABLE unidade (
id_unidade INT PRIMARY KEY, 
titulo varchar(60) NOT NULL,
cep CHAR(8) NOT NULL,
numero_endereco INT NOT NULL,
codigo_ativacao CHAR(7) NOT NULL,
fk_empresa INT NOT NULL,
CONSTRAINT ChkFkUnidadeEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

-- Tabela do Funcionário
CREATE TABLE funcionario (
id_funcionario INT,
cpf CHAR(11) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
dt_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
fk_unidade INT,
CONSTRAINT ChkFkFuncionarioUnidade FOREIGN KEY (fk_unidade) REFERENCES unidade(id_unidade),
CONSTRAINT pkFkEmpresaIdFuncionario PRIMARY KEY (id_funcionario, fk_unidade)
);

CREATE TABLE chamado (
id_chamado INT PRIMARY KEY,
descricao VARCHAR(250) NOT NULL,
fk_funcionario INT NOT NULL,
CONSTRAINT ChkFkChamadoFuncionario FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id_funcionario)
);

-- Tabela do refrigerador
CREATE TABLE refrigerador (
id_refrigerador INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
status_refrigerador TINYINT NOT NULL DEFAULT 1, -- 1: Ativo, 0: inativo
fk_unidade INT NOT NULL,
CONSTRAINT ChkFkRefrigeradorUnidade FOREIGN KEY (fk_unidade) REFERENCES unidade(id_unidade)
);

-- Tabela do Sensor - para localizarmos cada sensor
CREATE TABLE sensor (
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
ip INT NOT NULL,
status_sensor TINYINT NOT NULL DEFAULT 1, -- 1: Ativo, 0: inativo
dt_manutencao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
fk_refrigerador INT UNIQUE NOT NULL,
CONSTRAINT ChkFkSensorRefrigerador FOREIGN KEY (fk_refrigerador) REFERENCES refrigerador(id_refrigerador)
);
-- Tabela das temperaturas
CREATE TABLE medida_temperatura (
id_medida INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL(4, 1) NOT NULL,
dt_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
fk_sensor INT NOT NULL,
CONSTRAINT ChkFkMedidaSensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor)
);

CREATE TABLE alerta (
id_alerta INT PRIMARY KEY AUTO_INCREMENT,
tipo_alerta TINYINT NOT NULL, -- 1: Temperatura fora da faixa, 2: Temperatura Crítica
fk_medida INT NOT NULL,
CONSTRAINT ChkFkAlertaMedida FOREIGN KEY (fk_medida) REFERENCES medida_temperatura(id_medida)
);

/*
CREATE USER 'usuario_insert'@'%' IDENTIFIED BY '123';
GRANT SELECT, INSERT ON safelab.* TO 'usuario_insert'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'usuario_insert'@'%'; /
*/