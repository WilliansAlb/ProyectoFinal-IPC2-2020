/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formConfiguracion").bind("submit", function () {
        var limite_menor = parseFloat(document.getElementById("limiteMenor").value);
        var limite_mayor = parseFloat(document.getElementById("limiteMayor").value);
        console.log(limite_menor +" "+limite_mayor);
        if (limite_menor < limite_mayor) {
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
        } else {
            verMensaje("../resources/img/high_priority.svg", "El limite menor no debe ser mayor que el limite mayor", "INCONVENIENTE");
        }
        return false;
    });
}
