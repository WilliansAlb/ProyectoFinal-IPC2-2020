/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#validarDatos").bind("submit", function () {
        var btnEnviar = $("#validar");
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: $(this).serialize(),
            beforeSend: function () {
                btnEnviar.attr("disabled", "disabled");
            },
            complete: function (data) {
                btnEnviar.removeAttr("disabled");
            },
            success: function (data) {
                if (data === 'NOEXISTE') {
                    alert("No existe la cuenta que ingresaste");
                } else {
                    $("#busquedaCuenta").hide();
                    $("#datosBusqueda").fadeIn();
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });
};

function ocultarMostrar(ocultar, mostrar) {
    $("#validarDatos")[0].reset();
    bloquearBoton(document.getElementById("validar"));
    ocultar.hide();
    mostrar.fadeIn();
}

