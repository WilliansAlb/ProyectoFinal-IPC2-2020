<%-- 
    Document   : datosGerente
    Created on : 8/11/2020, 08:48:39 PM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
        <title>Datos personales</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../resources/css/sidebar.css">
        <link rel="stylesheet" href="../resources/css/input.css"/>
        <link rel="stylesheet" href="../resources/css/creacion.css"/>
        <link rel="stylesheet" href="../resources/css/ocultoGeneral.css"/>
        <link rel="stylesheet" href="../resources/css/inputArchivo.css"/>
        <link rel="stylesheet" href="../resources/css/fondo.css"/>
        <link rel="stylesheet" href="../resources/css/button2.css">
        <script src="../resources/js/oculto.js" type="text/javascript"></script>
        <script src="../resources/js/modificarEstadoBoton.js" type="text/javascript"></script>
    </head>
    <body>
        <%@include file="sidebar.jsp"%>
        <div class="bienvenida">
        </div>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" >
                <div class="ingreso" id="ingresoDpiCuenta">
                    <center>
                        <img src="../resources/img/businessman.svg">
                        <h1 style="font-weight: 900; color: white;">Tus datos</h1>
                        <p style="color: grey;">Se muestran los datos</p>
                        <form>
                            <div class="group">
                                <input type="text" id="codigo" onkeyup="activarGuardarCambios(this)" class="deshabilitado" value="1234543" disabled required>
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="codigo">Codigo</label>
                            </div>
                            <div class="group">
                                <input type="text" id="dpi" onkeyup="activarGuardarCambios(this)" class="deshabilitado" value="1832048181007" disabled required>
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpi">DPI</label>
                            </div>
                            <div class="group">
                                <input type="text" id="nombre" onkeyup="activarGuardarCambios(this)" required value="juan" style="color: #EBEBEB !important;" value="">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="nombre">Nombre</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="turnos">Turno</label>
                                <br>
                                <select id="turnos" style="width:100%;" onchange="activarGuardarCambios(this)">
                                    <option value="M">Matutino</option>
                                    <option value="V">Vespertino</option>
                                </select>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="sexos">Sexo</label>
                                <br>
                                <select id="sexos" style="width:100%;" onchange="activarGuardarCambios(this)">
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                            <div class="group">
                                <input type="text" id="direccion" onkeyup="activarGuardarCambios(this)" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="direccion">Direccion</label>
                            </div>
                            <button class="selected buttonEspecial" disabled id="guardarCambios" style="font-weight: inherit !important;">Guardar cambios<img src="../resources/img/cancel.svg" width="15%"
                                    style="display: inline-block;vertical-align: middle;"></button>
                        </form>
                    </center>
                </div>
            </div>
        </div>
        <script>
            var nombre = $("#nombre").val();
            var turno = $("#turnos").val();
            var sexo = $("#sexos").val();
            var direccion = $("#direccion").val();
            function activarGuardarCambios(elemento){
                var valor = elemento.value;
                var array = [nombre,turno,sexo,direccion];
                var array2 = [$("#nombre").val(),$("#turnos").val(),$("#sexos").val(),$("#direccion").val()];
                var noExiste = false;
                for (let i = 0; i < array.length; i++){
                    if (array[i]!==array2[i]){
                        noExiste = true;
                        break;
                    }
                }
                console.log(array[0]);
                if (noExiste){
                    activarBoton(document.getElementById("guardarCambios"),"../resources/img/safe.svg");
                } else {
                    bloquearBoton(document.getElementById("guardarCambios"));
                }
            }
        </script>
    </body>
    <%@include file='footer.html' %>
</html>
