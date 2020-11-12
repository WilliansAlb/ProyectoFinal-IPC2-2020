/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formularioCajero").bind("submit", function () {
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: $(this).serialize(),
            beforeSend: function () {
                $("#ingresarCajero").hide();
            },
            complete: function (data) {
                $("#ingresarCajero").show();
            },
            success: function (data) {
                if (data !== 'EXISTE')
                {
                    if (data.includes("ERROR") || data.includes("No fue posible crearle el usuario")) {
                        verMensaje("../resources/img/high_priority.svg", data, "INCONVENIENTE");
                    } else {
                        $("#contenedorMensaje2").hide();
                        verMensaje("../resources/img/approval.svg", data, "TRABAJADOR INGRESADO");
                        $("#campoPassword").show();
                        document.getElementById("passwordCajero").required = true;
                        $("#formularioCajero")[0].reset();
                    }
                } else {
                    verMensaje("../resources/img/high_priority.svg", "Ya existe un registro con el mismo dpi", "DPI YA EXISTENTE");
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });

    $("#formularioCliente").bind("submit", function () {
        $("#dpiCliente").removeAttr("disabled");
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: new FormData(this),
            processData: false,
            contentType: false,
            beforeSend: function () {
                $("#ingresarCliente").hide();
            },
            complete: function (data) {
                $("#ingresarCliente").show();
            },
            success: function (data) {
                if (data !== 'EXISTE')
                {
                    if (data.includes("ERROR") || data.includes("No fue posible crearle el usuario")) {
                        verMensaje("../resources/img/high_priority.svg", data, "INCONVENIENTE");
                    } else {
                        verMensaje("../resources/img/approval.svg", "Se muestran los datos básicos del cliente ingresado", "CLIENTE INGRESADO");
                        $("#campoPassword").show();
                        document.getElementById("passwordCliente").required = true;
                        var codigo = data.split("|");
                        $("#celdaCodigo").text(codigo[0]);
                        $("#columna1").text("CODIGO");
                        $("#columna2").text("NOMBRE");
                        $("#columna3").text("USUARIO");
                        $("#columna4").text("PASSWORD");
                        $("#celdaNombre").text($("#nombreCliente").val());
                        $("#celdaFecha").text($("#fechaCliente").val());
                        $("#celdaSexo").text($("#sexos").val());
                        $("#celdaDireccion").text($("#direccionCliente").val());
                        $("#celdaDPI").text($("#dpi").val());
                        $("#botonDPI").val($("#dpi").val());
                        $("#mostrar1").text(codigo[0]);
                        $("#mostrar2").text($("#nombreCliente").val());
                        $("#mostrar3").text(codigo[1]);
                        $("#mostrar4").text(codigo[2]);
                        $("#formularioCliente")[0].reset();
                        document.getElementById("cerrarRedirigir").textContent = "CONTINUAR";
                        $("#contenedorMensaje2").hide();
                        $("#confirmarCliente").fadeIn(1000);
                    }
                } else {
                    verMensaje("../resources/img/high_priority.svg", "Ya existe un registro con el mismo dpi, cambia el dpi", "DPI YA EXISTENTE");
                    $("#dpiCliente").css("color", "white");
                    $("#dpiCliente").focus();
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });

    $("#formularioCuenta").bind("submit", function () {
        var monto = $("#monto").val();
        var fecha = $("#fecha").val();
        var cliente = $("#celdaCodigo").text();
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {monto: monto, creacion: fecha, cliente: cliente},
            beforeSend: function () {
                $("#ingresarCuenta").hide();
            },
            complete: function (data) {
                $("#ingresarCuenta").show();
            },
            success: function (data) {
                if (data.includes("ERROR:")) {
                    verMensaje("../resources/img/high_priority.svg", data, "INCONVENIENTE");
                } else {
                    document.getElementById("cerrarRedirigir").textContent = "OK";
                    $("#datosCuenta").fadeIn(1000);
                    verMensaje("../resources/img/approval.svg", "Datos de la cuenta ingresada", "CUENTA INGRESADA EXITOSAMENTE");
                    $("#columna1").text("NO. DE CUENTA");
                    $("#columna2").text("CLIENTE");
                    $("#columna3").text("MONTO");
                    $("#columna4").text("FECHA");
                    $("#mostrar1").text(data);
                    $("#mostrar2").text($("#celdaNombre").text());
                    $("#mostrar3").text($("#monto").val());
                    $("#mostrar4").text($("#fecha").val());
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });
    $("#formularioValidarCliente").bind("submit", function () {
        var dpi = $("#dpi").val();
        $.ajax({
            type: "GET",
            url: "../creacion",
            data: {dpi: dpi},
            beforeSend: function () {
                $("#ingresarCajero").hide();
            },
            complete: function (data) {
                $("#ingresarCajero").show();
            },
            success: function (data) {
                if (data === 'NOEXISTE')
                {
                    $("#buscarCliente").hide();
                    $("#contenedorMensaje2").fadeIn(1000);
                    $("#dpiCliente").val($("#dpi").val());
                } else {
                    var array = data.split("\n");
                    $("#celdaCodigo").text(array[0]);
                    $("#celdaNombre").text(array[1]);
                    $("#celdaFecha").text(array[4]);
                    $("#celdaSexo").text(array[5]);
                    $("#celdaDireccion").text(array[2]);
                    $("#celdaDPI").text(array[3]);
                    $("#botonDPI").val(array[3]);
                    $("#buscarCliente").hide();
                    $("#confirmarCliente").fadeIn(1000);
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });
};


function generarPasswordCajero(select) {
    var valor = select.value;
    if (valor === 'N') {
        $("#campoPassword").show();
        $("#passwordCajero").attr("required");
    } else {
        $("#campoPassword").hide();
        $("#passwordCajero").removeAttr("required");
    }
}

function visualizarDPI(boton) {
    var dpiCliente = boton.value;
    document.getElementById("visorPDF").src = "../archivo?pdf=" + dpiCliente;
    $("#informando1").text("DPI de cliente " + $("#celdaCodigo").text());
    $('#contenedorMensaje3').show();
}

function cerrarRedirigir(boton) {
    if (boton.textContent === "CONTINUAR") {
        var contenedor = boton.parentNode;
        var otroContenedor = contenedor.parentNode;
        otroContenedor.style.display = "none";
        console.log(otroContenedor.id);
    } else {
        window.location = "crearCuenta.jsp";
    } 
}

function dpiValido(input) {
    if (input.length === 0) {
        input.setCustomValidity("Ingresa un DPI");
    } else {
        if (input.value > 0) {
            input.setCustomValidity("");
        } else {
            input.setCustomValidity('El DPI no debe contener letras');
        }
    }
}