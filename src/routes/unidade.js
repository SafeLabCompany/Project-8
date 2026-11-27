var express = require("express");
var router = express.Router();

var unidadeController = require("../controllers/unidadeController");

router.post("/cadastrar", function (req, res) {
    unidadeController.cadastrar(req, res);
});

router.get("/buscarRefri/:fk_empresa", function (req, res){
    unidadeController.buscarRefri(req, res)
})

module.exports = router;