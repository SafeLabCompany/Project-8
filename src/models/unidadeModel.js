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


function buscarRefri(fk_empresa) {
    console.log("ACESSEI O UNIDADE MODEL:", fk_empresa);

    var instrucaoSql = `
        SELECT u.id, u.titulo, COUNT(r.id) AS qtd_refrigeradores
        FROM unidade AS u
        LEFT JOIN refrigerador AS r
        ON r.fk_unidade = u.id
        WHERE u.fk_empresa = ${fk_empresa}
        GROUP BY u.id, u.titulo;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
  cadastrar,
  buscarRefri
};