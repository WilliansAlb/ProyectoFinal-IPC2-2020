/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formMontoRetiroCuenta").bind("submit", function () {
        var monto = parseFloat($("#monto").val());
        var noCuenta = $("#noDeCuenta").text();
        console.log(monto);
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {retiro: "CLIENTE", monto: monto, cuenta: noCuenta},
            beforeSend: function () {
                $("#ingresarRetiro").hide();
            },
            complete: function (data) {
                $("#ingresarRetiro").show();
            },
            success: function (data) {
                if (data.includes("ERROR:"))
                {
                    document.getElementById("cerrarRedirigir").textContent = "CERRAR";
                    verMensaje("../resources/img/high_priority.svg", "Los cambios que realizaste fueron guardados en la base de datos", "CAMBIOS GUARDADOS");
                } else {
                    document.getElementById("cerrarRedirigir").textContent = "OK";
                    var datosMostrar = data.split("\n");
                    var saldo = $("#saldoAnterior").text();
                    var nuevoSaldo = saldo - parseFloat($("#monto").val());
                    $("#mostrar1").text(datosMostrar[0]);
                    $("#mostrar2").text(noCuenta);
                    $("#mostrar3").text(nuevoSaldo);
                    $("#mostrar4").text(datosMostrar[1]);
                    verMensaje("../resources/img/approve.svg", "Datos de la transacción", "RETIRO EXITOSO");
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });

};

