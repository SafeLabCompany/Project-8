// const { buscarPermanencia } = require("../controllers/medidaController");
var database = require("../database/config");

function buscarUltimasMedidas(idRefrigerador, limite_linhas) {

    var instrucaoSql = `Select m.temperatura, m.dt_hora from medida_temperatura as m where m.fk_sensor = ${idRefrigerador} limit ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(fkSensor, fkUnidade) {

    var instrucaoSql = `SELECT m.temperatura, TIME(m.dt_hora) as Horario FROM refrigerador AS r
                        JOIN sensor AS s
                        ON s.fk_refrigerador = r.id
                        JOIN medida_temperatura AS m
                            ON m.fk_sensor = s.id
                        WHERE m.fk_sensor = ${fkSensor} AND r.fk_unidade = ${fkUnidade} ORDER BY dt_hora desc LIMIT 7;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarRefrigerador(fkUnidade){
    var instrucaoSql = `select id from refrigeradores where fk_unidade = ${fkUnidade};`;

    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarPermanencia(fkSensor,fkUnidade){
   var instrucaoSql =  `SELECT count(case when m.temperatura > 8 OR m.temperatura < 2 then 1 end) AS fora, count(case when m.temperatura <= 8 AND m.temperatura >= 2 then 1 end) AS dentro
FROM refrigerador AS r
    JOIN sensor AS s
        ON s.fk_refrigerador = r.id
    JOIN medida_temperatura AS m
        ON m.fk_sensor = s.id
WHERE m.fk_sensor = ${fkSensor} AND r.fk_unidade = ${fkUnidade};`;

   
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarMedidasEmTempoReal,
    buscarRefrigerador,
    buscarPermanencia
}
