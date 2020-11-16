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
                    verMensaje("../resources/img/high_priority.svg", "No existe la cuenta que ingresaste", "CUENTA INEXISTENTE");
                } else if (data === 'PROPIEDAD') {
                    verMensaje("../resources/img/high_priority.svg", "La cuenta que ingresaste es de tu propiedad", "CUENTA PROPIA");
                } else {
                    var datos = data.split("\n");
                    document.getElementById("visorPDF").src = "../archivo?pdf=" + datos[2];
                    $("#campo1").text(datos[0]);
                    $("#campo2").text(datos[1]);
                    $("#campo3").text(datos[2]);
                    $("#campo4").text(datos[3]);
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

function enviarSolicitud() {
    var cuenta = $("#campo1").text();
    var btnEnviar = $("#enviarSolicitud");
    $.ajax({
        type: "POST",
        url: "../asociacion",
        data: {cuenta: cuenta, tipo: "ENVIAR"},
        beforeSend: function () {
            btnEnviar.attr("disabled", "disabled");
        },
        complete: function (data) {
            btnEnviar.removeAttr("disabled");
        },
        success: function (data) {
            if (data.includes("SOLICITUD")) {
                var codigoGenerado = data.split("SOLICITUD");
                $("#cerrarRedirigir").text("OK");
                verMensaje("../resources/img/approve.svg", "Se envio exitosamente la solicitud, el codigo de la misma es " + codigoGenerado[1], "SOLICITUD ENVIADA");
            } else {
                if (data === 'ESPERA') {
                    verMensaje("../resources/img/high_priority.svg", "Ya tienes una solicitud en espera, no puedes enviar otra", "SOLICITUD EN ESPERA");
                    $("#cerrarRedirigir").text("OK");
                } else if (data === 'ACEPTADA') {
                    verMensaje("../resources/img/high_priority.svg", "Ya estas asociado a esta cuenta", "SOLICITUD ACEPTADA");
                    $("#cerrarRedirigir").text("OK");
                } else if (data === 'EXISTEN') {
                    $("#cerrarRedirigir").text("CERRAR");
                    verMensaje("../resources/img/high_priority.svg", "No se pudo enviar la solicitud, intenta de nuevo", "ERROR BASE");
                } else if (data === 'LIMITE') {
                    $("#cerrarRedirigir").text("OK");
                    verMensaje("../resources/img/high_priority.svg", "Ya has llegado al limite de solicitudes de asociacion con esta cuenta", "LIMITE DE SOLICITUDES");
                }
            }
        },
        error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });
}