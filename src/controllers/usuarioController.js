var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {
  var email = req.body.Email;
  var senha = req.body.Senha;

  if (email == undefined) {
    res.status(400).send("Seu email está undefined!");
  } else if (senha == undefined) {
    res.status(400).send("Sua senha está indefinida!");
  } else {
    usuarioModel
      .autenticar(email, senha)
      .then(function (resultadoAutenticar) {
        console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
        console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`);

        if (resultadoAutenticar.length == 1) {
          console.log(resultadoAutenticar[0]);
          var fkEmpresa = resultadoAutenticar[0].id;
          var idFuncionario = resultadoAutenticar[0].id_funcionario;
          usuarioModel.autenticarUnidadesAcesso(fkEmpresa, idFuncionario)
            .then(function(resultadoUnidades){
                res.json({
                    email: resultadoAutenticar[0].email,
                    nome: resultadoAutenticar[0].nome,
                    id: resultadoAutenticar[0].id,
                    unidades: resultadoUnidades,
                });
            })
            .catch(function (erro) {
              console.log(erro);
              console.log(
                "Houve um erro ao realizar o cadastro de desempenho! Erro: ",
                erro.sqlMessage,
              );
              res.status(500).json(erro.sqlMessage);
            });
        } else if (resultadoAutenticar.length == 0) {
          res.status(403).send("Email e/ou senha inválido(s)");
        } else {
          res.status(403).send("Mais de um usuário com o mesmo login e senha!");
        }
      })
      .catch(function (erro) {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o login! Erro: ",
          erro.sqlMessage,
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

function cadastrar(req, res) {
  var nome = req.body.Nome;
  var email = req.body.Email;
  var senha = req.body.Senha;
  var codigo_empresa = req.body.codEmpresa;
  var cpf = req.body.CPF;

  // Faça as validações dos valores
  if (nome == undefined) {
    res.status(400).send("Seu nome está undefined!");
  } else if (email == undefined) {
    res.status(400).send("Seu email está undefined!");
  } else if (senha == undefined) {
    res.status(400).send("Sua senha está undefined!");
  } else if (codigo_empresa == undefined) {
    res.status(400).send("Empresa inexistente!");
  } else if (cpf == undefined) {
    res.status(400).send("Seu cpf está undefined!");
  } else {
    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    usuarioModel
      .AtivarCodigo(codigo_empresa)
      .then(function (resultado) {
        if (resultado.length == 1) {
          usuarioModel
            .cadastrar(nome, email, senha, cpf)
            .then(function (result) {
              console.log("\ Olha aqui o InsertId: ", result.insertId);
              usuarioModel
                .correlacionar(resultado[0].unidadeId, result.insertId)
                .then(function () {
                  return res.status(201).json({ nome: nome, email: email });
                });
            })
            .catch(function (erro) {
              console.log(erro);
              console.log(
                "\nHouve um erro ao realizar o cadastro! Erro: ",
                erro.sqlMessage,
              );
              res.status(500).json(erro.sqlMessage);
            });
        } else if (resultado.length == 0) {
          res.status(403).send("Código autenticar invalido!");
        } else {
          res.status(403).send("Código duplicado");
        }
      })
      .catch(function (erro) {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage,
        );

        res.status(500).json(erro.sqlMessage);
      });
  }
}

module.exports = {
  autenticar,
  cadastrar,
};
