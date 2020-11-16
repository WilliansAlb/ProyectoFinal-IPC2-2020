/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function enviarDatos() {
    var origen = $("#cuentaOrigen").text();
    var destino = $("#cuentaDestino").text();
    var monto = $("#montoCelda").text();
    var boton = document.getElementById("confirmarTransferencia");
    $.ajax({
        type: "POST",
        url: "../transaccion",
        data: {deposito:"CLIENTE",origen:origen,destino:destino,monto:monto},
        beforeSend: function () {
            boton.style.display ="none";
        },
        complete: function (data) {
            boton.style.display ="";
        },
        success: function (data) {
            if (data.includes("ERROR")) {
                verMensaje("../resources/img/high_priority.svg",data, "ERROR");
            } else {
                $("#cerrarRedirigir").text("OK");
                verMensaje("../resources/img/approve.svg", "La transferencia fue realizada con exito", "TRANSFERENCIA EXITOSA");
            }
        },
        error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });
}

