<%-- 
    Document   : asociar
    Created on : 9/11/2020, 12:16:09 PM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <title>Asociar</title>
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
        <script src="../resources/js/comprobar.js" type="text/javascript"></script>
        <script src="../resources/js/asociacion.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            HttpSession asociar = request.getSession();
            boolean correcto = false;
            if (asociar.getAttribute("tipo")!=null){
                if (asociar.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")){
                    correcto = true;
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <%if (correcto){%>
        <%@include file="sidebar.jsp" %>
        <div class="bienvenida"></div>
        <div id="contenedorBusqueda" class="crear">
            <div class="contenedorFlex" id="busquedaCuenta">
                <div class="ingreso" id="busqueda">
                    <center>
                        <img src="../resources/img/020-handshake.svg">
                        <h1 style="font-weight: 900; color: white;">Solicitar asociación de cuenta</h1>
                        <p style="color: grey;">Ingresa el número de la cuenta a la que le solicitarás la asociación</p>
                        <form id="validarDatos" method="GET" action="../asociacion">
                            <div class="group" style="width: 60%;">
                                <input type="text" id="busqueda" name="busqueda" class="inputCentrado" required onkeyup="comprobar(this)" pattern="\d+" style="color: white;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="busqueda" class="labelCentrado">Número de cuenta</label>
                            </div>
                            <button class="selected buttonEspecial" disabled id="validar" title="Rellena los campos para activar este botón" style="width: 40%;" type="submit">Validar<img src="../resources/img/cancel.svg" width="15%" class="imagenBoton"></button>
                        </form>
                    </center>
                </div>
            </div>
            <div class="contenedorFlex" id="datosBusqueda" style="display: none;">
                <div class="ingreso" id="solicitarAsociacion" style="width: 70% !important;">
                    <center>
                        <h1 style="font-weight: 900;color: white;">Datos solicitado</h1>
                        <p style="font-weight: 300; color: grey;">Datos del dueño de la cuenta a la que se le solicitará la asociación</p>
                        <table class="tablaDatos" style="width:80%;">
                            <thead>
                                <tr>
                                    <th>Cuenta</th>
                                    <th>Nombre</th>
                                    <th>DPI</th>
                                    <th>Direccion</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="campo1">######</td>
                                    <td id="campo2">MMMMMM</td>
                                    <td id="campo3">111111</td>
                                    <td id="campo4">la cuarta avenida de alguna colonia de un lugar donde no entra la luz en los amaneceres</td>
                                </tr>
                            </tbody>
                        </table>
                        <p style="font-weight: 300; color: grey;">DPI del propietario de la cuenta</p>
                        <embed src="" width="80%" height="250px" id="visorPDF">
                        <hr width="50%">
                        <button class="learn-more buttonEspecial" onclick="enviarSolicitud()" style="width:30%;" id="enviarSolicitud">Solicitar asociacion<img class="imagenBoton" src="../resources/img/checkmark.svg" width="5%"></button>
                        <button class="learn-more buttonEspecial" onclick="ocultarMostrar($('#datosBusqueda'), $('#busquedaCuenta'))" style="width:30%;">Cancelar<img class="imagenBoton" src="../resources/img/cancel.svg" width="5%"></button>
                    </center>
                </div>
            </div>
        </div>
    <center>
        <div id="contenedorMensaje" class="oculto" style="display:none;">
            <div id="contenedorInterior" class="mensaje2" style="background-color: #001a28;">
                <div style="padding: 2em;">
                    <img id="imagen" src="../resources/img/checkmark.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                    <h2 id="tituloMensaje" style="font-weight: 900;margin:0;color: white;">por defecto</h2><article id="articulo" style="color:grey;display:inline-block;">asdjfaksjdlfkajsdlkfjalsdjflkasjdlkfjaskldjflasdfa</article>
                </div>
                <button class="learn-more buttonEspecial" onclick="cerrar(this)" id="cerrarRedirigir">CERRAR</button>
            </div>
        </div>
    </center>
        <script>
            function llamarMetodoDejoDeEscribir(input) {
                if (input.value > 0) {
                    activarBoton(document.getElementById("validar"), "../resources/img/search.svg");
                } else {
                    if (input.value.length > 0) {
                        input.setCustomValidity("No pueden ir letras en el número de cuenta!");
                        input.reportValidity();
                        input.value = "";
                        input.setCustomValidity("");
                    }
                    bloquearBoton(document.getElementById("validar"));
                }
            }
            function cerrar(boton){
                if (boton.textContent === 'CERRAR'){
                    var con1 = boton.parentNode;
                    var con2 = con1.parentNode;
                    con2.style.display = "none";
                } else {
                    window.location = "asociaciones.jsp";
                }
            }
        </script>
        <%@include file="footer.html" %>
        <%}%>
    </body>
</html>
