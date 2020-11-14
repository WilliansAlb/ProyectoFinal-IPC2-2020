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
                    verMensaje("../resources/img/high_priority.svg", "La cuenta que ingresaste no existe", "CUENTA INEXISTENTE");
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
    $("#busquedaDepositar").bind("submit", function () {
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
                    verMensaje("../resources/img/high_priority.svg", "La cuenta que ingresaste no existe", "CUENTA INEXISTENTE");
                } else {
                    var datos = data.split("\n");
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
    $("#montoRetiro").bind("submit", function () {
        var monto = $("#monto2").val();
        var noCuenta = $("#cuenta").val();
        console.log(monto);
        console.log(noCuenta);
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {retiro: "CAJERO", monto: monto, cuenta: noCuenta},
            beforeSend: function () {
                $("#aceptarRetiro").hide();
            },
            complete: function (data) {
                $("#aceptarRetiro").show();
            },
            success: function (data) {
                if (data.includes("ERROR:"))
                {
                    document.getElementById("cerrarRedirigir").textContent = "CERRAR";
                    var error = data.split("ERROR:");
                    verMensaje("../resources/img/high_priority.svg", "Los transacción que realizaste no fue guardada en la base de datos por que"+error[1], "INCONVENIENTE");
                } else {
                    document.getElementById("cerrarRedirigir").textContent = "OK";
                    var mostrarse = data.split("\n");
                    verMensaje("../resources/img/004-banknote.svg", "La transacción se realizó exitosamente, el codigo de la misma es "+mostrarse[0]+" y fue ingresada a la fecha y hora "+mostrarse[1], "RETIRO EXITOSO");
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario"+data);
            }
        });
        return false;
    });
    
    $("#montoDeposito").bind("submit", function () {
        var monto = $("#monto2").val();
        var noCuenta = $("#cuenta").val();
        console.log(monto);
        console.log(noCuenta);
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {deposito: "CAJERO", monto: monto, cuenta: noCuenta},
            beforeSend: function () {
                $("#aceptarRetiro").hide();
            },
            complete: function (data) {
                $("#aceptarRetiro").show();
            },
            success: function (data) {
                if (data.includes("ERROR:"))
                {
                    document.getElementById("cerrarRedirigir").textContent = "CERRAR";
                    verMensaje("../resources/img/high_priority.svg", "Los transacción no pudo ser ingresada por fallo en la base de datos, intenta de nuevo", "INCONVENIENTE");
                } else {
                    document.getElementById("cerrarRedirigir").textContent = "OK";
                    var mostrarse = data.split("\n");
                    verMensaje("../resources/img/033-savings.svg", "La transacción se realizó exitosamente, el codigo de la misma es "+mostrarse[0]+" y fue ingresada a la fecha y hora "+mostrarse[1], "RETIRO EXITOSO");
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario"+data);
            }
        });
        return false;
    });
};

