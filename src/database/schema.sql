CREATE DATABASE safelab;
USE safelab;

-- Tabela da Empresa
CREATE TABLE empresa (
id INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL UNIQUE,
nome VARCHAR(50) NOT NULL,
status TINYINT NOT NULL DEFAULT 1 -- 0: desativo, 1: ativo
);

-- Tabela de Unidade
CREATE TABLE unidade (
id INT PRIMARY KEY, 
titulo varchar(60) NOT NULL,
cep CHAR(8) NOT NULL,
numero_endereco INT NOT NULL,
codigo_ativacao CHAR(7) NOT NULL,
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
fk_funcionario INT,
CONSTRAINT ConstFkRegistroFuncionario FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id),
fk_unidade INT,
CONSTRAINT ConstFkRegistroUnidade FOREIGN KEY (fk_unidade) REFERENCES unidade(id),
PRIMARY KEY (fk_funcionario, fk_unidade)
);

-- Tabela Nivel de acesso dos usuarios
CREATE TABLE nivel_acesso (
id INT PRIMARY KEY AUTO_INCREMENT,
fk_funcionario INT NOT NULL,
CONSTRAINT ConstFkAcessoFuncionario FOREIGN KEY (fk_funcionario) REFERENCES registro_funcionario(fk_funcionario),
fk_unidade INT NOT NULL,
CONSTRAINT ConstFkAcessoUnidade FOREIGN KEY (fk_unidade) REFERENCES registro_funcionario(fk_unidade)
);

-- Tabela de Permissões
CREATE TABLE permissao (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45) NOT NULL UNIQUE,
descricao VARCHAR(250) NOT NULL
);

-- Tabela Permissões de cada acesso
CREATE TABLE permissao_acesso (
fk_permissao INT,
CONSTRAINT ConstFkPermissao_acessoNivelPermissao FOREIGN KEY (fk_permissao) REFERENCES registro_funcionario(fk_unidade),
fk_nivel_acesso INT,
CONSTRAINT ConstFkPermissao_acessoNivel FOREIGN KEY (fk_nivel_acesso) REFERENCES registro_funcionario(fk_unidade),
PRIMARY KEY (fk_permissao, fk_nivel_acesso)
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

/*
CREATE USER 'usuario_insert'@'%' IDENTIFIED BY '123';
GRANT SELECT, INSERT ON safelab.* TO 'usuario_insert'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'usuario_insert'@'%'; /
*/
/*
INSERT INTO empresa (cnpj, nome, status) VALUES
('12345678000190', 'BioVida Laboratórios', 1),
('98765432000110', 'ImunoSaúde Distribuidora', 1);

-- Unidades (id_unidade não tem AUTO_INCREMENT, por isso o id é informado)
INSERT INTO unidade (id, titulo, cep, numero_endereco, codigo_ativacao, fk_empresa) VALUES
(1, 'BioVida - Matriz', '01310100', 1000, 'BV00001', 1),
(2, 'BioVida - Filial Campinas', '13010111', 250, 'BV00002', 1),
(3, 'ImunoSaúde - Centro de Distribuição', '04538133', 87, 'IS00001', 2);

-- Funcionários (id_funcionario também não é AUTO_INCREMENT)
INSERT INTO funcionario (id, cpf, nome, email, senha, fk_unidade) VALUES
(1, '11122233344', 'Leandro Ramos', 'leandro@biovida.com', 'senha123', 1),
(2, '22233344455', 'Gabriel Falcão', 'gabriel@biovida.com', 'senha123', 1),
(3, '33344455566', 'Júlio Lino', 'julio@biovida.com', 'senha123', 2),
(4, '44455566677', 'Claudio Frizzarini', 'claudio@imunosaude.com', 'senha123', 3),
(5, '55566677788', 'Vinicius Kenzo', 'vinicius@imunosaude.com', 'senha123', 3);

-- Chamados
INSERT INTO chamado (id, descricao, fk_funcionario) VALUES
(1, 'Sensor do refrigerador 1 apresentando leituras instáveis.', 1),
(2, 'Alerta crítico disparado, mas a porta estava fechada. Solicito verificação.', 3),
(3, 'Preciso redefinir o acesso ao dashboard de temperaturas.', 4);

-- Refrigeradores
INSERT INTO refrigerador (nome, status, fk_unidade) VALUES
('Geladeira Vacinas A', 1, 1),
('Geladeira Vacinas B', 1, 1),
('Geladeira Campinas 01', 1, 2),
('Câmara Fria Distribuição 01', 1, 3);

-- Sensores (1 sensor por refrigerador, pois fk_refrigerador é UNIQUE)
INSERT INTO sensor (ip, status, dt_manutencao, fk_refrigerador) VALUES
(101, 1, '2026-09-01 08:00:00', 1),
(102, 1, '2026-09-01 08:30:00', 2),
(103, 1, '2026-09-05 09:00:00', 3),
(104, 1, '2026-09-10 10:00:00', 4);

-- Medidas de temperatura (faixa ideal para vacinas: 2 a 8 °C)
INSERT INTO medida_temperatura (temperatura, dt_hora, fk_sensor) VALUES
(4.2, '2026-11-03 08:00:00', 1),
(5.0, '2026-11-03 08:05:00', 1),
(9.3, '2026-11-03 08:10:00', 1),
(4.7, '2026-11-03 08:15:00', 1),
(3.5, '2026-11-03 08:00:00', 2),
(6.1, '2026-11-03 08:05:00', 2),
(10.8, '2026-11-03 08:10:00', 2),
(5.4, '2026-11-03 08:15:00', 2),
(2.9, '2026-11-03 08:00:00', 3),
(1.2, '2026-11-03 08:05:00', 3),
(4.4, '2026-11-03 08:10:00', 3),
(5.8, '2026-11-03 08:15:00', 3),
(6.7, '2026-11-03 08:00:00', 4),
(15.2, '2026-11-03 08:05:00', 4),
(7.9, '2026-11-03 08:10:00', 4),
(4.0, '2026-11-03 08:15:00', 4);

INSERT INTO alerta (tipo_alerta, fk_medida) VALUES
(1, 3),
(2, 7),
(1, 10),
(2, 14);


SELECT
	mt.temperatura 'Temperatura',
	mt.dt_hora 'Data e hora',
	r.nome 'Refrigerador',
	e.nome 'Nome da empresa',
	u.nome 'Unidade'
FROM
	medida_temperatura mt JOIN sensor
	ON mt.fk_sensor = sensor.id
	JOIN refrigerador r
	ON r.id = sensor.fk_refrigerador
	JOIN unidade uSSSss
	ON u.id = r.fk unidade
	JOIN empresa e
	ON e.id = u.fk_empresa;
*/