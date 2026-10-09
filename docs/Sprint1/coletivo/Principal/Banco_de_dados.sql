CREATE DATABASE projetoPI_1ccok;
USE projetoPI_1ccok;

-- Tabela da Empresa
CREATE TABLE empresa (
id INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) NOT NULL,
nome VARCHAR(50) NOT NULL
);

-- Tabela do Funcionário
CREATE TABLE funcionario (
id INT PRIMARY KEY AUTO_INCREMENT,
cpf CHAR(11) NOT NULL,
nome VARCHAR(50) NOT NULL,
email VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
clinica_trabalha VARCHAR(50),
data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela do Sensor - para localizarmos cada sensor
CREATE TABLE sensor (
id INT PRIMARY KEY AUTO_INCREMENT,
modelo VARCHAR(20),
local_instalacao VARCHAR(50)
);

-- Tabela de Vacina
CREATE TABLE vacina (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
lote VARCHAR(30) NOT NULL,
onde_esta_guardada VARCHAR(50)
);

-- Tabela das temperaturas
CREATE TABLE monit_temperatura (
id INT PRIMARY KEY AUTO_INCREMENT,
nome_geladeira VARCHAR(50) NOT NULL,
temperatura DECIMAL(4, 1),
data_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo as Empresas (Clínicas)
INSERT INTO empresa (cnpj, nome, email) VALUES
('12345678000199', 'Clínica Vacina Bem', 'contato@vacinabem.com.br'),
('98765432000188', 'Hospital Imuniza', 'admin@imuniza.com.br');

-- Inserindo os Funcionários
INSERT INTO funcionario (cpf, nome, email, senha, clinica_trabalha) VALUES
('11122233344', 'Enzo Zamaro Bertoluci', 'enzo@vacinabem.com.br', 'senhaSegura123', 'Clínica Vacina Bem'),
('99988877766', 'Leonardo Fogaça', 'leonardo@imuniza.com.br', 'senhaForte456', 'Hospital Imuniza');

-- Inserindo os Sensores (O hardware)
INSERT INTO sensor (modelo, local_instalacao) VALUES
('LM35', 'Geladeira 1 - Clínica Vacina Bem'),
('LM35', 'Freezer A - Hospital Imuniza');

-- Inserindo as Vacinas
INSERT INTO vacina (nome, lote, onde_esta_guardada) VALUES
('Covid-19 Bivalente', 'LOTE-CV12', 'Geladeira 1 - Clínica Vacina Bem'),
('Febre Amarela', 'LOTE-FA99', 'Freezer A - Hospital Imuniza');

-- Inserindo os Eventos de Temperatura (Simulando as leituras do Arduino)
INSERT INTO monit_temperatura (nome_geladeira, temperatura) VALUES
('Geladeira 1 - Clínica Vacina Bem', 4.5),
('Geladeira 1 - Clínica Vacina Bem', 1.0),
('Freezer A - Hospital Imuniza', 9.8);

-- Ele avalia cada temperatura gravada e alerta se a vacina corre perigo
SELECT
    nome_geladeira AS 'Equipamento e Local',
    data_hora AS 'Data/hora da leitura',
    CASE
        WHEN temperatura < 2.0 THEN CONCAT('ALERTA: Temperatura muito baixa - ', temperatura, 'ºC')
        WHEN temperatura > 8.0 THEN CONCAT('ALERTA CRÍTICO: Temperatura Elevada - ', temperatura, 'ºC')
        ELSE CONCAT('Normal: Temperatura comum - ', temperatura, 'ºC')
    END AS 'Status da Temperatura'
FROM monit_temperatura;

-- Mostra de forma simples quais lotes temos e onde estão guardados
SELECT 
    nome AS 'Nome da Vacina', 
    lote AS 'Lote Registrado', 
    onde_esta_guardada AS 'Localização Atual'
FROM vacina;

-- Traz as clínicas cadastradas e quem é o responsável
SELECT 
    nome AS 'Nome do Funcionário', 
    clinica_trabalha AS 'Clínica/Hospital', 
    email AS 'E-mail de Contato'
FROM funcionario;