var database = require("../database/config");

function cadastrar (titulo, cep, numero_endereco, fk_empresa) {
console.log("ACESSEI O UNIDADE MODEL:", titulo, cep, numero_endereco, fk_empresa);

var instrucaoSql = `
INSERT INTO unidade (titulo, cep, numero_endereco, fk_empresa) VALUES 
('${titulo}', '${cep}',${numero_endereco}, ${fk_empresa});
`;

console.log("Executando a instrução SQL: \n" + instrucaoSql);
return database.executar(instrucaoSql);
}

module.exports = {
  cadastrar
};