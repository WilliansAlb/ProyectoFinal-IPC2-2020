/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function filtrarSolicitudes(select) {
    var filas = document.querySelector("#recibidas > tbody");
    var campos = filas.querySelectorAll("tr");
    for (let campo of campos) {
        campo.style.display = "";
    }
    var filas2 = document.querySelector("#realizadas > tbody");
    var campos2 = filas2.querySelectorAll("tr");
    for (let campo2 of campos2) {
        campo2.style.display = "";
    }
    if (select.value == 1) {
        $("#tablaRealizadas").hide();
        var filas4 = document.querySelector("#recibidas > tbody");
        var campos4 = filas4.querySelectorAll("tr");
        if (campos4.length === 0) {
            $("#tablaSinResultados").show();
            $("#tablaRecibidas").hide();
        } else {
            $("#tablaSinResultados").hide();
            $("#tablaRecibidas").show();
        }
    } else if (select.value == 2) {
        $("#tablaRecibidas").hide();
        var filas4 = document.querySelector("#realizadas > tbody");
        var campos4 = filas4.querySelectorAll("tr");
        if (campos4.length === 0) {
            $("#tablaSinResultados").show();
            $("#tablaRealizadas").hide();
        } else {
            $("#tablaSinResultados").hide();
            $("#tablaRealizadas").show();
        }
    } else if (select.value == 3) {
        $("#tablaRealizadas").hide();
        $("#tablaRecibidas").show();
        var filas4 = document.querySelector("#recibidas > tbody");
        var campos4 = filas4.querySelectorAll("tr");
        var hay_filas = false;
        for (let campo4 of campos4) {
            if (campo4.className == 'solicitudEspera') {
                hay_filas = true;
                campo4.style.display = "";
            } else {
                campo4.style.display = "none";
            }
        }
        if (campos4.length === 0) {
            $("#tablaSinResultados").show();
            $("#tablaRecibidas").hide();
        } else {
            if (hay_filas) {
                $("#tablaSinResultados").hide();
            } else {
                $("#tablaSinResultados").show();
                $("#tablaRecibidas").hide();
            }
        }
    } else if (select.value == 4) {
        $("#tablaRecibidas").hide();
        $("#tablaRealizadas").show();
        var filas5 = document.querySelector("#realizadas > tbody");
        var campos5 = filas5.querySelectorAll("tr");
        var hay_filas = false;
        for (let campo5 of campos5) {
            if (campo5.className == 'solicitudEspera') {
                campo5.style.display = "";
                hay_filas = true;
            } else {
                campo5.style.display = "none";
            }
        }
        if (campos5.length === 0) {
            $("#tablaSinResultados").show();
            $("#tablaRealizadas").hide();
        } else {
            if (hay_filas) {
                $("#tablaSinResultados").hide();
            } else {
                $("#tablaSinResultados").show();
                $("#tablaRealizadas").hide();
            }
        }
    } else if (select.value == 5) {
        $("#tablaRealizadas").hide();
        $("#tablaRecibidas").show();
        var filas4 = document.querySelector("#recibidas > tbody");
        var campos4 = filas4.querySelectorAll("tr");
        var hay_filas = false;
        for (let campo4 of campos4) {
            if (campo4.className == 'solicitudAceptada') {
                campo4.style.display = "";
                hay_filas = true;
            } else {
                campo4.style.display = "none";
            }
        }
        if (campos4.length === 0) {
            $("#tablaSinResultados").show();
            $("#tablaRecibidas").hide();
        } else {
            if (hay_filas) {
                $("#tablaSinResultados").hide();
            } else {
                $("#tablaSinResultados").show();
                $("#tablaRecibidas").hide();
            }
        }
    } else if (select.value == 6) {
        $("#tablaRecibidas").hide();
        $("#tablaRealizadas").show();
        var filas5 = document.querySelector("#realizadas > tbody");
        var campos5 = filas5.querySelectorAll("tr");
        var hay_filas = false;
        for (let campo5 of campos5) {
            if (campo5.className == 'solicitudAceptada') {
                campo5.style.display = "";
                hay_filas = true;
            } else {
                campo5.style.display = "none";
            }
        }
        if (campos5.length === 0) {
            $("#tablaSinResultados").show();
            $("#tablaRealizadas").hide();
        } else {
            if (hay_filas) {
                $("#tablaSinResultados").hide();
            } else {
                $("#tablaSinResultados").show();
                $("#tablaRealizadas").hide();
            }
        }
    }
}
function verDatosSolicitante(boton) {
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
function verDatosSolicitado(boton) {
    var td = boton.parentNode;
    var tr = td.parentNode;
    var campos = tr.querySelectorAll("td");
    $.ajax({
        type: "GET",
        url: "../asociacion",
        data: {busqueda: campos[1].textContent},
        beforeSend: function () {

        },
        complete: function (data) {

        },
        success: function (data) {
            if (data === 'PROPIEDAD') {
                verMensaje("../resources/img/high_priority.svg", "La cuenta que ingresaste es de tu propiedad", "CUENTA PROPIA");
            } else {
                var datos = data.split("\n");
                document.getElementById("visorPDF").src = "../archivo?pdf=" + datos[2];
                $("#campo5").text(campos[2].textContent);
                $("#campo6").text(campos[0].textContent);
                $("#campo1").text(datos[0]);
                $("#campo2").text(datos[1]);
                $("#campo3").text(datos[2]);
                $("#campo4").text(datos[3]);
                $("#busqueda").hide();
                $("#datosSolicitado").show();
            }
        },
        error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });
}
function verDatosSolicitante(boton) {
    var td = boton.parentNode;
    var tr = td.parentNode;
    var campos = tr.querySelectorAll("td");
    $.ajax({
        type: "GET",
        url: "../asociacion",
        data: {cliente: campos[2].textContent},
        beforeSend: function () {

        },
        complete: function (data) {

        },
        success: function (data) {
            if (data === 'PROPIEDAD') {
                verMensaje("../resources/img/high_priority.svg", "La cuenta que ingresaste es de tu propiedad", "CUENTA PROPIA");
            } else {
                var datos = data.split("\n");
                document.getElementById("visorPDF2").src = "../archivo?pdf=" + datos[2];
                if (campos[3].textContent === 'EN ESPERA') {
                    $("#cancelarAceptar").show();
                } else {
                    $("#cancelarAceptar").hide();
                }
                $("#campoS5").text(campos[3].textContent);
                $("#campoS6").text(campos[0].textContent);
                $("#campoS1").text(campos[1].textContent);
                $("#campoS2").text(datos[1]);
                $("#campoS3").text(datos[2]);
                $("#campoS4").text(datos[3]);
                $("#busqueda").hide();
                $("#datosSolicitante").show();
            }
        },
        error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });
}
function movilidad() {
    window.location = "asociaciones.jsp";
}

function editarSolicitud(boton) {
    var campos = $("#campoS6").text();
    var valor = boton.value;
    $.ajax({
        type: "GET",
        url: "../asociacion",
        data: {asociacion: campos, estado: valor},
        beforeSend: function () {
            boton.disabled = true;
        },
        complete: function (data) {
            boton.disabled = false;
        },
        success: function (data) {
            if (data === 'ERROR') {
                $("#cerrarRedirigir").text("CERRAR");
                verMensaje("../resources/img/high_priority.svg", "No se pudo actualizar el estado de la solicitud", "ERROR");
            } else {
                if (valor === 'ACEPTADA') {
                    $("#cerrarRedirigir").text("OK");
                    verMensaje("../resources/img/approve.svg", "El cliente solicitante ya puede utilizar la cuenta que solicitó", "SOLICITUD ACEPTADA");
                } else {
                    $("#cerrarRedirigir").text("OK");
                    verMensaje("../resources/img/approve.svg", "Se ha rechazado correctamente la solicitud", "SOLICITUD RECHAZADA");
                }
            }
        },
        error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });
}