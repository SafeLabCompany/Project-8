var database = require("../database/config");

function buscarUltimasMedidas(idRefrigerador, limite_linhas) {

    var instrucaoSql = `Select m.temperatura, m.dt_hora from medida_temperatura as m where m.fk_sensor = ${idRefrigerador} limit ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(fkSensor, fkUnidade) {

    var instrucaoSql = `SELECT m.temperatura, m.dt_hora FROM refrigerador AS r
                        JOIN sensor AS s
                        ON s.fk_refrigerador = r.id
                        JOIN medida_temperatura AS m
                            ON m.fk_sensor = s.id
                        WHERE m.fk_sensor = ${fkSensor} AND r.fk_unidade = ${fkUnidade} ORDER BY dt_hora DESC LIMIT 7;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarRefrigerador(fkUnidade){
    var instrucaoSql = `select id from refrigeradores where fk_unidade = ${fkUnidade};`;

    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarRefrigerador
}
