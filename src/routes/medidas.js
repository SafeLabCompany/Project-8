var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idRefrigerador/:idUnidade", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idUnidade/:idRefrigerador", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/ultima/tempo-real/:idUnidade/:idRefrigerador", function (req, res) {
    medidaController.buscarUltimaMedida(req, res);
})

module.exports = router;