var database = require("../database/config");

function buscarUltimasMedidas(idUnidade, idRefrigerador, limite_linhas) {

    var instrucaoSql = `select * from vw_ultimos_registros WHERE id_unidade = ${idUnidade} AND id_refrigerador = ${idRefrigerador} LIMIT ${limite_linhas};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idUnidade, idRefrigerador) {

    var instrucaoSql = `SELECT * from vw_ultimos_registros WHERE u.id = ${idUnidade} AND r.id = ${idRefrigerador};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
