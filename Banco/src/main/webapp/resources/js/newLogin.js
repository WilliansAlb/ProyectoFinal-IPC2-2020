/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function metodo(x, y) {
    if (x!=='' && y!==''){
        $.ajax({
        type: 'GET',
        data: {usuario: x, password: y},
        url: '../sesion',
        success: function (result) {
            if (result==='NOEXISTE'){
                $('#password').val("");
                verMensaje('../resources/img/disapprove.svg','El usuario y la contraseña no coinciden con ningún registro válido','Credenciales incorrectas');
            } else if (result === 'BIEN'){
                window.location = "home.jsp";
            } else {
                $('#password').val("");
                alert("ERROR: fallo al conectar con la base de datos");
                verMensaje('../resources/img/disapprove.svg','El usuario y la contraseña no coinciden con ningún registro válido','Credenciales incorrectas');
            } 
        }
    });
    } else {
        if (x===''){
            $('#usuario').focus();
            var popup = document.getElementById("myPopup");
            $('#myPopup').fadeIn(1000);
            $('#myPopup').fadeOut(3000);
        } else {
            $('#password').focus();
            var popup = document.getElementById("myPopup1");
            $('#myPopup1').fadeIn(1000);
            $('#myPopup1').fadeOut(3000);
        }
    }
}

function comprobar() {
    dejarDeEscribir();
}

let timeout;
function dejarDeEscribir() {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        var usuario1 = $("#usuario").val();
        var contraseña1 = $("#password").val();
        var deshabilitar = usuario1.length === 0 || contraseña1.length === 0;
        if (deshabilitar){
            bloquearBoton(document.getElementById("ingresarCredenciales"));
        } else {
            activarBoton(document.getElementById("ingresarCredenciales"),"../resources/img/advance.svg")
        }
        clearTimeout(timeout);
    }, 800);
}

