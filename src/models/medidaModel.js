var database = require("../database/config");

function buscarUltimasMedidas(idUnidade, idRefrigerador, limite_linhas) {

    var instrucaoSql = `select * from vw_ultimos_registros WHERE id_unidade = ${idUnidade} AND id_refrigerador = ${idRefrigerador} LIMIT ${limite_linhas};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idUnidade, idRefrigerador) {

    var instrucaoSql = `SELECT * FROM vw_ultimos_registros WHERE id_unidade = ${idUnidade} AND id_refrigerador = ${idRefrigerador} ORDER BY momento_grafico DESC LIMIT 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarDadosTabela(idUnidade){
    var instrucaoSql = `select * from vw_dados_tabela where id = ${idUnidade};`
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarDadosTabela
}
