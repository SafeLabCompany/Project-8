var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idRefrigeradores", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});



router.post("/tempo-real", function ( req, res) {
    medidaController.buscarMedidasEmTempoReal( req,res);
})

router.post("/ultimas-24", function ( req, res) {
    medidaController.buscarPermanencia( req,res);
})

module.exports = router;