CREATE DATABASE safelab;
USE safelab;

SELECT * FROM funcionario;

-- Tabela da Empresa
CREATE TABLE empresa (
id INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
codigo_ativacao CHAR(7) NOT NULL,
statuss TINYINT NOT NULL DEFAULT 1 -- 0: desativo, 1: ativo
);

-- Tabela de Unidade
CREATE TABLE unidade (
id INT PRIMARY KEY, 
titulo varchar(60) NOT NULL,
cep CHAR(8) NOT NULL,
numero_endereco INT NOT NULL,
fk_empresa INT NOT NULL,
CONSTRAINT ConstFkUnidadeEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

-- Tabela do Funcionário
CREATE TABLE funcionario (
id INT PRIMARY KEY AUTO_INCREMENT,
cpf CHAR(11) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
dt_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela registro de funcionario
CREATE TABLE registro_funcionario (
nivel TINYINT NOT NULL DEFAULT 0,
fk_funcionario INT,
CONSTRAINT ConstFkRegistroFuncionario FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id),
fk_unidade INT,
CONSTRAINT ConstFkRegistroUnidade FOREIGN KEY (fk_unidade) REFERENCES unidade(id),
PRIMARY KEY (fk_funcionario, fk_unidade)
);

-- Tabela Chamado feito pelo usuario
CREATE TABLE chamado (
id INT PRIMARY KEY,
descricao VARCHAR(250) NOT NULL,
fk_funcionario INT NOT NULL,
CONSTRAINT ConstFkChamadoFuncionario FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id)
);

-- Tabela do refrigerador
CREATE TABLE refrigerador (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
fk_unidade INT NOT NULL,
CONSTRAINT ConstFkRefrigeradorUnidade FOREIGN KEY (fk_unidade) REFERENCES unidade(id)
);

-- Tabela do Sensor - para localizarmos cada sensor
CREATE TABLE sensor (
id INT PRIMARY KEY AUTO_INCREMENT,
ip INT NOT NULL,
dt_manutencao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
fk_refrigerador INT UNIQUE NOT NULL,
CONSTRAINT ConstFkSensorRefrigerador FOREIGN KEY (fk_refrigerador) REFERENCES refrigerador(id)
);

-- Tabela das temperaturas
CREATE TABLE medida_temperatura (
id INT PRIMARY KEY AUTO_INCREMENT,
temperatura DECIMAL(4, 1) NOT NULL,
dt_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
fk_sensor INT NOT NULL,
CONSTRAINT ConstFkMedidaSensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id)
);

-- Tabale alertas capturados
CREATE TABLE alerta (
id INT PRIMARY KEY AUTO_INCREMENT,
tipo_alerta TINYINT NOT NULL, -- 1: Temperatura fora da faixa, 2: Temperatura Crítica
fk_medida INT NOT NULL,
CONSTRAINT ConstFkAlertaMedida FOREIGN KEY (fk_medida) REFERENCES medida_temperatura(id)
);

-- Tabela Historico de status do refrigerador
CREATE TABLE historico_status_refrigerador (
id INT PRIMARY KEY AUTO_INCREMENT,
dth_registro DATETIME NOT NULL,
statuss TINYINT NOT NULL,
fk_refrigerador INT NOT NULL,
CONSTRAINT ConstFkHisc_RefrigeradorSensor FOREIGN KEY (fk_refrigerador) REFERENCES refrigerador(id)
);

-- Tabela Historico de status do sensor
CREATE TABLE historico_status_sensor (
id INT PRIMARY KEY AUTO_INCREMENT,
dth_registro DATETIME NOT NULL,
statuss TINYINT NOT NULL,
fk_sensor INT NOT NULL,
CONSTRAINT ConstFkHisc_sensorSensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id),
fk_historico_refrigerador INT NOT NULL,
CONSTRAINT ConstFkHist_sensorHist_refrigerador FOREIGN KEY (fk_historico_refrigerador) REFERENCES historico_status_refrigerador(id)
);

CREATE VIEW dados_funcionario AS
SELECT DISTINCT e.id, f.id AS id_funcionario, f.nome, f.email, f.senha FROM funcionario AS f
JOIN registro_funcionario AS r
ON r.fk_funcionario = f.id
JOIN unidade AS u
ON r.fk_unidade = u.id
JOIN empresa AS e
ON u.fk_empresa = e.id;

SELECT * FROM dados_funcionario AS d WHERE d.email = '${email}' AND d.senha = '${senha}';

CREATE VIEW unidades_acesso AS
SELECT u.fk_empresa, r.* FROM empresa AS e
RIGHT JOIN unidade AS u
ON e.id = u.fk_empresa
LEFT JOIN registro_funcionario AS r
ON u.id = r.fk_unidade
LEFT JOIN funcionario AS f
ON r.fk_funcionario = f.id;

SELECT * FROM unidades_acesso AS d WHERE d.fk_empresa = ${fkEmpresa} AND d.fk_funcionario = ${id_funcionario};