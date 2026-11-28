var database = require("../database/config");

/*function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
                        temperatura,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}*/


function buscarMedidasEmTempoReal(fkSensor, fkUnidade) {

    var instrucaoSql = `SELECT m.temperatura, TIME(m.dt_hora) as Horario FROM refrigerador AS r
                        JOIN sensor AS s
                        ON s.fk_refrigerador = r.id
                        JOIN medida_temperatura AS m
                            ON m.fk_sensor = s.id
                        WHERE m.fk_sensor = ${fkSensor} AND r.fk_unidade = ${fkUnidade} ORDER BY dt_hora desc LIMIT 7`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
