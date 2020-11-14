/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formConfiguracion").bind("submit", function () {
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: $(this).serialize(),
            beforeSend: function () {
                $("#guardarCambios").hide();
            },
            complete: function (data) {
                $("#guardarCambios").show();
            },
            success: function (data) {
                if (data.includes("ERROR:"))
                {
                    document.getElementById("cerrarRedirigir").textContent = "CERRAR";
                    verMensaje("../resources/img/high_priority.svg", data, "INCONVENIENTE");
                } else {
                    document.getElementById("cerrarRedirigir").textContent = "OK";
                    verMensaje("../resources/img/approve.svg", "Se han actualizado los cambios que realizaste", "CAMBIOS GUARDADOS");
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });
}
