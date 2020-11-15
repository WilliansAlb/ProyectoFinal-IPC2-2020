<%-- 
    Document   : transacciones
    Created on : 15/11/2020, 03:23:53 PM
    Author     : yelbetto
--%>

<%@page import="DTO.TransaccionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.Conector"%>
<%@page import="Base.TransaccionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <title>Transacciones</title>
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
        <script src="../resources/js/retiro.js" type="text/javascript"></script>
        <script src="../resources/js/comprobar.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            HttpSession sesionRetiro = request.getSession();
            boolean correcto = false;
            boolean enviado = false;
            if (sesionRetiro.getAttribute("tipo") != null) {
                if (sesionRetiro.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {
                    correcto = true;
                    if (sesionRetiro.getAttribute("noCuenta") != null) {
                        enviado = true;
                    } else {
                        enviado = false;
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
        <%if (enviado) {%>
        <%if (sesionRetiro.getAttribute("noCuenta").toString().equalsIgnoreCase("ERROR")) {
                sesionRetiro.setAttribute("noCuenta", null);
                sesionRetiro.removeAttribute("noCuenta");
        %>
        <div id="contenedorMensajeError" class="crear">
            <div class="contenedorFlex" id="errorMensaje">
                <div class="ingreso" id="confirmarError">
                    <div style="padding: 2em;">
                        <center>
                            <img id="imagen" src="../resources/img/high_priority.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                            <h3 id="tituloMensaje" style="margin:0;color:white;">Cuenta inexistente</h3>
                            <article id="articulo" style="display:inline-block;color:grey;">La cuenta que ingresaste no existe o no es de tu propiedad</article>
                            <br>
                            <button class="learn-more buttonEspecial" onclick="window.location = 'cuentas.jsp'">Ver tus cuentas</button>
                        </center>
                    </div>
                </div>
            </div>
        </div>
        <%@include file='footer.html' %>%>
        <%} else {%>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" id="buscarCliente">
                <div class="ingreso" id="ingresoDpiCuenta" style="width:80%;">
                    <center>
                        <img src="../resources/img/007-checkbook.svg" max-width="67px">
                        <div style="display: grid;grid-template-columns:auto auto;width: 30%;">
                            <button class="learn-more buttonEspecial" onclick="window.location = '../transaccion?cuentas=0&verificado=F'">Buscar otra cuenta</button>
                            <button class="learn-more buttonEspecial" onclick="window.location = 'cuentas.jsp'">Ver cuentas</button>
                        </div>
                        <h1 style="font-weight: 900;color:white;">Transacciones de cuenta <%out.print(sesionRetiro.getAttribute("noCuenta").toString());%></h1>
                        <p style="color: grey;">Se muestran las transacciones realizadas para esta cuenta, ordenandolas de forma ascendente</p>
                        <table class="tablaDatos" style="width:70%;">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Cajero</th>
                                    <th>Monto</th>
                                    <th>Tipo(Debito o Credito)</th>
                                    <th>Fecha creación</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    long cuenta = Long.parseLong(sesionRetiro.getAttribute("noCuenta").toString());
                                    Conector cn = new Conector("encender");
                                    TransaccionDAO transacciones = new TransaccionDAO(cn);
                                    ArrayList<TransaccionDTO> transaccion = transacciones.obtenerTransaccionesCuenta(cuenta);
                                    for (int i = 0; i < transaccion.size(); i++) {
                                        TransaccionDTO temporal = transaccion.get(i);
                                %>
                                <tr>
                                    <td><%out.print(temporal.getCodigo());%></td>
                                    <td><%out.print(temporal.getCajero());%></td>
                                    <td><%out.print(temporal.getMonto());%></td>
                                    <td><%out.print(temporal.getTipo());%></td>
                                    <td><%out.print(temporal.getCreacion());%></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>

                    </center>
                </div>
            </div>
        </div>
        <%
                sesionRetiro.setAttribute("noCuenta", null);
                sesionRetiro.removeAttribute("noCuenta");
            }%>
        <%} else {%>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" id="buscarCliente">
                <div class="ingreso" id="ingresoDpiCuenta" style="width:80%;">
                    <center>
                        <img src="../resources/img/007-checkbook.svg" max-width="67px">
                        <h1 style="font-weight: 900;color:white;">Tus cuentas</h1>
                        <div id="retiroBusqueda">
                            <p style="color:grey;">Se muestran tus cuentas, puedes ver las transacciones de cada una</p>
                            <div class="group" style="width: 40%;">
                                <span class="popuptext" id="myPopup">Debe ser un número!</span>
                                <input type="text" id="busqueda" class="inputCentrado" onkeyup="comprobar(this)" style="color: white;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="busqueda" class="labelCentrado">NO. DE CUENTA</label>
                            </div>
                            <button class="learn-more buttonEspecial" style="color:grey;" onclick="enviarNoCuenta()" disabled="true" id="verTransacciones">VER TRANSACCIONES</button>
                        </div>
                    </center>
                </div>
            </div>
        </div>
        <script>
            function llamarMetodoDejoDeEscribir(input) {
                if (Number.isNaN(parseInt(input.value))) {
                    document.getElementById("verTransacciones").style.color = "grey";
                    document.getElementById("verTransacciones").disabled = true;
                } else {
                    document.getElementById("verTransacciones").style.color = "#5264AE";
                    document.getElementById("verTransacciones").disabled = false;
                }
            }
            function enviarNoCuenta() {
                var noCuenta = $("#busqueda").val();
                window.location = "../transaccion?cuentas=" + noCuenta + "&verificado=N";
            }
        </script>
        <%@include file='footer.html' %>
        <%
                    sesionRetiro.setAttribute("noCuenta", null);
                    sesionRetiro.removeAttribute("noCuenta");
                }
            }%>
    </body>
</html>
