/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formModificacionCajero").bind("submit", function () {
        var tipo = document.getElementById("guardarCambios2").textContent;
        if (tipo === "GUARDAR CAMBIOS") {
            var nombre = $("#nombre").val();
            var codigo = $("#codigo").val();
            var turno = $("#turnos").val();
            var sexos = $("#sexos").val();
            var direccion = $("#direccion").val();
            $.ajax({
                type: $(this).attr("method"),
                url: $(this).attr("action"),
                data: {modificado: "CAJERO", codigo: codigo, nombre: nombre, turno: turno, sexo: sexos, direccion: direccion},
                beforeSend: function () {
                    $("#guardarCambios2").hide();
                },
                complete: function (data) {
                    $("#guardarCambios2").show();
                },
                success: function (data) {
                    if (data === 'ACTUALIZADO')
                    {
                        actualizarFormulario();
                        document.getElementById("cerrarRedirigir").textContent = "OK";
                        verMensaje("../resources/img/approve.svg", "Los cambios que realizaste fueron guardados en la base de datos", "CAMBIOS GUARDADOS");
                    } else {
                        verMensaje("../resources/img/high_priority.svg", "No se pudieron actualizar los cambios, intenta de nuevo", "INCONVENIENTE");
                    }
                },
                error: function (data) {
                    alert("Problemas al tratar de enviar el formulario");
                }
            });
        } else {
            window.location = "modificarCajero.jsp";
        }
        return false;
    });

    $("#formModificacionGerente").bind("submit", function () {
        var nombre = $("#nombre").val();
        var codigo = $("#codigo").val();
        var turno = $("#turnos").val();
        var sexos = $("#sexos").val();
        var direccion = $("#direccion").val();
        var dpi = $("#dpi").val();
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {modificado: "GERENTE", codigo: codigo, nombre: nombre, turno: turno, sexo: sexos, direccion: direccion, dpi: dpi},
            beforeSend: function () {
                $("#guardarCambios").hide();
            },
            complete: function (data) {
                $("#guardarCambios").show();
            },
            success: function (data) {
                if (data === 'ACTUALIZADO')
                {
                    actualizarFormulario();
                    activarGuardarCambios();
                    document.getElementById("cerrarRedirigir").textContent = "OK";
                    verMensaje("../resources/img/approve.svg", "Los cambios que realizaste fueron guardados en la base de datos", "CAMBIOS GUARDADOS");
                } else {
                    document.getElementById("cerrarRedirigir").textContent = "CERRAR";
                    verMensaje("../resources/img/high_priority.svg", "No se pudieron actualizar los cambios, intenta de nuevo", "INCONVENIENTE");
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });

    $("#formModificacionCliente").bind("submit", function () {
        $("#dpi").removeAttr("disabled");
        $("#codigo").removeAttr("disabled");
        var guardar = $("#guardarCambios2").text();
        if (guardar === 'GUARDAR CAMBIOS') {
            $.ajax({
                type: $(this).attr("method"),
                url: $(this).attr("action"),
                data: new FormData(this),
                processData: false,
                contentType: false,
                beforeSend: function () {
                    $("#guardarCambios2").hide();
                },
                complete: function (data) {
                    $("#guardarCambios2").show();
                },
                success: function (data) {
                    if (data === 'ACTUALIZADO')
                    {
                        document.getElementById("cerrarRedirigir").textContent = "OK";
                        verMensaje("../resources/img/approve.svg", "Los cambios que realizaste fueron guardados en la base de datos", "CAMBIOS GUARDADOS");
                    } else {
                        document.getElementById("cerrarRedirigir").textContent = "CERRAR";
                        console.log(data);
                        verMensaje("../resources/img/high_priority.svg", "No se pudieron actualizar los cambios, intenta de nuevo", "INCONVENIENTE");
                    }
                },
                error: function (data) {
                    alert("Problema1");
                }
            });
        } else {
            window.location = "modificarCliente.jsp";
        }
        return false;
    });
};

function cerrarRedirigir(boton) {
    if (boton.textContent === 'CERRAR') {
        var contenedor = boton.parentNode;
        var contenedor2 = contenedor.parentNode;
        contenedor2.style.display = "none";
    } else {
        window.location = "modificarCajero.jsp";
    }
}
function visualizarDPI(boton) {
    var dpiCliente = boton.value;
    document.getElementById("visorPDF").src = "../archivo?pdf=" + dpiCliente;
    $("#informando1").text("DPI de cliente " + $("#celdaCodigo").text());
    $('#contenedorMensaje3').show();
}
