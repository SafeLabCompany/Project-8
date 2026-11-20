var unidadeModel = require("../models/unidadeModel");

function cadastrar(req, res) {
    var titulo = req.body.nova_unidade;
    var cep = req.body.novo_cep;
    var numero_endereco = req.body.novo_numero;
    var fk_empresa = req.body.novo_empresa_id;

    if (titulo == undefined || titulo == "") {
        res.status(400).send("O nome da unidade está inválido!");
    } else if (cep == undefined || cep == "") {
        res.status(400).send("O CEP está inválido!");
    } else if (numero_endereco == undefined || numero_endereco == "") {
        res.status(400).send("O número do endereço está inválido!");
    } else if (fk_empresa == undefined) {
        res.status(400).send("Empresa não identificada!");
    } else {
        unidadeModel.cadastrar(titulo, cep, numero_endereco, fk_empresa)
            .then(function (resultado) {
                console.log("Unidade cadastrada com sucesso!");

                res.status(201).json({
                    mensagem: "Unidade cadastrada com sucesso!",
                    titulo: titulo
                });
            })


            .catch(function (erro) {
                console.log(erro);
                console.log("Erro ao cadastrar unidade:", erro.sqlMessage);

                res.status(500).json(erro.sqlMessage);
            });

    }
}


module.exports = {
    cadastrar
};