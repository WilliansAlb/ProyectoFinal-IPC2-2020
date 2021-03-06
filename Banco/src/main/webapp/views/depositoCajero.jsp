<%-- 
    Document   : depositoCajero
    Created on : 13/11/2020, 10:40:21 PM
    Author     : yelbetto
--%>

<%@page import="Base.CajeroDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <title>Depositar</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../resources/css/sidebar.css">
        <link rel="stylesheet" href="../resources/css/button2.css">
        <link rel="stylesheet" href="../resources/css/input.css"/>
        <link rel="stylesheet" href="../resources/css/creacion.css"/>
        <link rel="stylesheet" href="../resources/css/ocultoGeneral.css"/>
        <link rel="stylesheet" href="../resources/css/inputArchivo.css"/>
        <link rel="stylesheet" href="../resources/css/fondo.css"/>
        <link rel="stylesheet" href="../resources/css/PopUp.css" type="text/css">
        <script src="../resources/js/oculto.js" type="text/javascript"></script>
        <script src="../resources/js/modificarEstadoBoton.js" type="text/javascript"></script>
        <script src="../resources/js/comprobar.js" type="text/javascript"></script>
        <script src="../resources/js/retiro.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            HttpSession configuracion = request.getSession();
            Conector cn = new Conector("encender");
            boolean correcto = false;
            boolean turnoCorrecto = false;
            if (configuracion.getAttribute("tipo") != null) {
                if (configuracion.getAttribute("tipo").toString().equalsIgnoreCase("CAJERO")) {
                    CajeroDAO trabajando = new CajeroDAO(cn);
                    if (configuracion.getAttribute("codigo").toString().equalsIgnoreCase("101")) {
                        response.sendRedirect("home.jsp");
                    } else {
                        correcto = true;
                        turnoCorrecto = trabajando.turnoCorrecto(Long.parseLong(configuracion.getAttribute("codigo").toString()));
                    }
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <%if (correcto) {%>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida"></div>
        <%
            if (turnoCorrecto) {
            HttpSession sesionRetiroCajero = request.getSession();
        %>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" id="busquedaCuenta">
                <div class="ingreso" id="busqueda">
                    <center>
                        <img src="../resources/img/033-savings.svg">
                        <h1 style="font-weight: 900; color: white;">Depositar</h1>
                        <p style="color: grey;">Ingresa el número de cuenta a la que se le depositará</p>
                        <form id="busquedaDepositar" method="GET" action="../transaccion">
                            <div class="group" style="width: 60%;">
                                <span class="popuptext" id="popCuenta">Debe ser un número!</span>
                                <input type="text" id="cuenta" name="cuenta" class="inputCentrado" required onkeyup="comprobar(this)" pattern="\d+" style="color: white;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="busqueda" class="labelCentrado">Número de cuenta</label>
                            </div>
                            <button class="selected buttonEspecial" disabled id="validar" title="Rellena los campos para activar este botón" style="width: 40%;" type="submit">Ver datos<img src="../resources/img/cancel.svg" width="15%" class="imagenBoton"></button>
                        </form>
                    </center>
                </div>
            </div>
            <div class="contenedorFlex" id="datosBusqueda" style="display: none;">
                <div class="ingreso" id="solicitarAsociacion" style="width: 70% !important;">
                    <center>
                        <img src="../resources/img/033-savings.svg">
                        <h1 style="font-weight: 900;color: white;">Depositar</h1>
                        <p style="color: grey;">Datos del dueño de la cuenta a la que se le depositará</p>
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
                        <hr width="50%">
                        <div id="botonesVerificacion">
                            <p style="color:grey;">¿Es la cuenta correcta?</p>
                            <button class="learn-more buttonEspecial" onclick="verificado(this, document.getElementById('monto'))" style="width:30%;" id="verificado">Si<img class="imagenBoton" src="../resources/img/checkmark.svg" width="5%"></button>
                            <button class="learn-more buttonEspecial" onclick="cancelar()" style="width:30%;" id="cancelado">No<img class="imagenBoton" src="../resources/img/checkmark.svg" width="5%"></button>  
                        </div>
                        <div id="monto" style="display:none;">
                            <form action="../transaccion" method="POST" id="montoDeposito">
                                <div class="group" style="width: 50%;">
                                    <span class="popuptext" id="popMonto">Debe ser un número!</span>
                                    <input type="number" id="monto2" name="monto2" class="inputCentrado" required onkeyup="comprobar(this)" min="1" step="0.25" style="color: white;">
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label for="monto" class="labelCentrado">Monto a depositar</label>
                                </div>
                                <button class="selected buttonEspecial" id="aceptarRetiro" style="width:30%;color:grey;">Aceptar deposito<img class="imagenBoton" src="../resources/img/checkmark.svg" width="5%"></button>
                            </form>
                            <button class="learn-more buttonEspecial" onclick="cancelar()" style="width:30%;">Cancelar<img class="imagenBoton" src="../resources/img/cancel.svg" width="5%"></button>
                        </div>
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
    <%@include file='footer.html' %>
    <script>
        function cerrar(boton){
            if (boton.textContent === 'CERRAR'){
                var con = boton.parentNode;
                var con2 = con.parentNode;
                con2.style.display = "none";
            } else {
                window.location = "depositoCajero.jsp";
            }
        }
        function llamarMetodoDejoDeEscribir(input) {
            var valor = parseInt(input.value);
            if (Number.isNaN(valor)) {
                if (input.id === 'cuenta') {
                    $("#popCuenta").fadeIn(500);
                    $("#popCuenta").fadeOut(2000);
                    bloquearBoton(document.getElementById("validar"));
                } else {
                    $("#popMonto").fadeIn(500);
                    $("#popMonto").fadeOut(2000);
                    bloquearBoton(document.getElementById("aceptarRetiro"));
                    document.getElementById("aceptarRetiro").style.color = "grey";
                }
            } else {
                if (input.id === 'cuenta') {
                    activarBoton(document.getElementById("validar"), "../resources/img/search.svg");
                } else {
                    activarBoton(document.getElementById("aceptarRetiro"), "../resources/img/checkmark.svg");
                    document.getElementById("aceptarRetiro").style.color = "#5264AE";
                }
            }
        }
        function verificado(ocultar, mostrar) {
            var div = ocultar.parentNode;
            div.style.display = "none";
            mostrar.style.display = "";
        }
        function cancelar() {
            window.location = "depositoCajero.jsp";
        }
    </script>
    <%} else {%>
    <%@include file="turno.jsp" %>
    <%@include file='footer.html' %>
    <%}%>
    <%}%>
</body>
</html>