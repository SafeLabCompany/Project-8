var medidaModel = require("../models/medidaModel");

function buscarPermanencia(req, res) {

  var sensor = req.body.idSensor;
    var unidade = req.body.idUnidade;
    console.log(`Recuperando medidas em tempo real`);

    medidaModel.buscarPermanencia(sensor,unidade).then(function (resultado) {
    
        if (resultado.length > 0) {
            res.json(
            resultado
           )
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        // console.log(erro);
        // console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        // res.status(500).json(erro.sqlMessage);
    });
}

function buscarMedidasEmTempoReal(req, res) {

  var sensor = req.body.idSensor;
    var unidade = req.body.idUnidade;
    console.log(`Recuperando medidas em tempo real`);

    medidaModel.buscarMedidasEmTempoReal(sensor,unidade).then(function (resultado) {
    
        if (resultado.length > 0) {
            res.json(
            resultado
           )
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        // console.log(erro);
        // console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        // res.status(500).json(erro.sqlMessage);
    });
}



module.exports = {
   buscarPermanencia,
    buscarMedidasEmTempoReal
    

}