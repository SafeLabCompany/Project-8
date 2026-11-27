function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;
    var fkempresa = sessionStorage.FKEMPRESA;
    var empresa = sessionStorage.empresa_id;
    var nivel_acesso = sessionStorage.nivel_id;

    var b_usuario = document.getElementById("b_usuario");

    if (email != null && nome != null && fkempresa != null && empresa != null && nivel_acesso != null) {
        b_usuario.innerHTML = nome;
        b_usuario.innerHTML = nome;
        b_usuario.innerHTML = nome;
    } else {
        window.location = "../login.html";
    }
}


