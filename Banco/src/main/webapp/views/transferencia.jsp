<%-- 
    Document   : transferencia
    Created on : 15/11/2020, 09:50:59 PM
    Author     : yelbetto
--%>

<%@page import="DTO.CuentaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.CuentaDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transferencia</title>
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
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
        <script src="../resources/js/comprobar.js" type="text/javascript"></script>
        <script src="../resources/js/transferencia.js" type="text/javascript"></script>
    </head>
    <body>
        <%@include file='sidebar.jsp' %>
        <div class="bienvenida"></div>
        <%
            HttpSession sesionRetiroCliente = request.getSession();
            Conector cn = new Conector("encender");
            boolean correcto = false;
            if (sesionRetiroCliente.getAttribute("tipo")!=null){
                if (sesionRetiroCliente.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")){
                    correcto = true;
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        
        <%if (correcto){
            CuentaDAO cuentas = new CuentaDAO(cn);
            ArrayList<CuentaDTO> listado = cuentas.obtenerCuentas(Long.parseLong(sesionRetiroCliente.getAttribute("codigo").toString()));
            ArrayList<CuentaDTO> listadoAsociada = cuentas.obtenerCuentasAsociadas(Long.parseLong(sesionRetiroCliente.getAttribute("codigo").toString()));
        %>
        <div class="crear">
            <div class="contenedorFlex">
                <div class="ingreso">
                    <center>
                        <img src="../resources/img/009-transfer.svg" max-width="67px">
                        <h1 style="font-weight: 900;color:white;">Banca virtual</h1>
                        <p style="color:grey;" id="mensaje1">Elige la cuenta de dónde se transferirá el dinero</p>
                        <table class="tablaDatos" id="listadoCuentas" width="95%">
                            <thead>
                                <tr>
                                    <th>No. de cuenta</th>
                                    <th>Saldo</th>
                                    <th>Asociado</th>
                                    <th>Fecha de creación</th>
                                    <th>Transferir de</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%for (int i = 0; i < listado.size(); i++) {
                                        CuentaDTO temporal = listado.get(i);
                                %>
                                <tr class="cuentaDatos">
                                    <td><%out.print(temporal.getCodigo());%></td>
                                    <%
                                        if (temporal.getCredito() > 0.25) {
                                    %>
                                    <td style="color:green;"><%out.print(temporal.getCredito());%></td>
                                    <%
                                    } else {
                                    %>
                                    <td style="color:red;"><%out.print(temporal.getCredito());%></td>
                                    <%}%>
                                    <td>NO</td>
                                    <td><%out.print(temporal.getCreacion());%></td>
                                    <%
                                        if (temporal.getCredito() > 0.25) {
                                    %>
                                    <td><input type="radio" onclick="elegidoTransferir(this)" name="elegir"></td>
                                        <%
                                        } else {
                                        %>
                                    <td style="background-color: red;">Saldo insuficiente</td>
                                    <%}%>
                                </tr>
                                <%}
                                %>
                                <%for (int i = 0; i < listadoAsociada.size(); i++) {
                                        CuentaDTO temporal = listadoAsociada.get(i);
                                %>
                                <tr class="cuentaDatos">
                                    <td><%out.print(temporal.getCodigo());%></td>
                                    <%
                                        if (temporal.getCredito() > 0.25) {
                                    %>
                                    <td style="color:green;"><%out.print(temporal.getCredito());%></td>
                                    <%
                                    } else {
                                    %>
                                    <td style="color:red;"><%out.print(temporal.getCredito());%></td>
                                    <%}%>
                                    <td>SI</td>
                                    <td><%out.print(temporal.getCreacion());%></td>
                                    <%
                                        if (temporal.getCredito() > 0.25) {
                                    %>
                                    <td><input type="radio" onclick="elegidoTransferir(this)" name="elegir"></td>
                                        <%
                                        } else {
                                        %>
                                    <td style="background-color: red;">Saldo insuficiente</td>
                                    <%}%>
                                </tr>
                                <%}
                                %>
                            </tbody>
                        </table>
                        <div id="contenedorMonto" style="display:none;">
                            <div class="group" style="width: 40%;">
                                <span class="popuptext" id="myPopup">Saldo insuficiente!</span>
                                <input type="number" id="monto" class="inputCentrado" max="" min="1" step="0.25" onkeyup="comprobar(this)" style="color: white;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="busqueda" class="labelCentrado">Monto</label>
                            </div>
                            <button class="learn-more buttonEspecial" id="elegirCuenta1" onclick="elegida()">Elegir</button>
                        </div>
                        <div id="contenedorTablaTransferencia" style="display:none;">
                            <p style="color: grey;">Datos de transferencia</p>
                            <table id="tablaTransferencia" class="tablaDatos">
                                <thead>
                                    <tr>
                                        <th>Cuenta origen</th>
                                        <th>Cuenta destino</th>
                                        <th>Monto</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td id="cuentaOrigen"></td>
                                        <td id="cuentaDestino">------</td>
                                        <td id="montoCelda"></td>
                                    </tr>
                                </tbody>
                            </table>
                            <hr style="width:40%;">
                            <table class="tablaDatos" id="cuentasDestino" width="95%">
                                <thead>
                                    <tr>
                                        <th>No. de cuenta</th>
                                        <th>Saldo</th>
                                        <th>Asociado</th>
                                        <th>Fecha de creación</th>
                                        <th>Elegir</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < listado.size(); i++) {
                                            CuentaDTO temporal = listado.get(i);
                                    %>
                                    <tr class="filasDestino">
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <%
                                            if (temporal.getCredito() > 0.25) {
                                        %>
                                        <td style="color:green;"><%out.print(temporal.getCredito());%></td>
                                        <%
                                        } else {
                                        %>
                                        <td style="color:red;"><%out.print(temporal.getCredito());%></td>
                                        <%}%>
                                        <td>NO</td>
                                        <td><%out.print(temporal.getCreacion());%></td>
                                        <td><input type="radio" onclick="elegidoTransferir2(this)" name="elegir2"></td>
                                    </tr>
                                    <%}
                                    %>
                                    <%for (int i = 0; i < listadoAsociada.size(); i++) {
                                            CuentaDTO temporal = listadoAsociada.get(i);
                                    %>
                                    <tr class="filasDestino">
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <%
                                            if (temporal.getCredito() > 0.25) {
                                        %>
                                        <td style="color:green;"><%out.print(temporal.getCredito());%></td>
                                        <%
                                        } else {
                                        %>
                                        <td style="color:red;"><%out.print(temporal.getCredito());%></td>
                                        <%}%>
                                        <td>SI</td>
                                        <td><%out.print(temporal.getCreacion());%></td>
                                        <td><input type="radio" onclick="elegidoTransferir2(this)" name="elegir2"></td>
                                    </tr>
                                    <%}
                                    %>
                                </tbody>
                            </table>
                            <button class="learn-more buttonEspecial" style="color:#5264AE;display:none;" onclick="enviarDatos()" id="confirmarTransferencia">Confirmar transferencia</button>
                            <button class="learn-more buttonEspecial" onclick="window.location = 'transferencia.jsp'">CANCELAR</button>
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
                <button class="learn-more buttonEspecial" onclick="cerrarRedirigir(this)" id="cerrarRedirigir">CERRAR</button>
            </div>
        </div>
    </center>
    <script>
        function elegidoTransferir(radio) {
            var TD = radio.parentNode;
            var TR = TD.parentNode;
            var celda = TR.querySelectorAll("td")[0];
            var monto = TR.querySelectorAll("td")[1];
            $("#cuentaOrigen").text(celda.textContent);
            document.getElementById("monto").max = parseFloat(monto.textContent);
            $("#contenedorMonto").show();
        }

        function cerrarRedirigir(boton) {
            if (boton.textContent === 'CERRAR'){
                var con = boton.parentNode;
                var con2 = con.parentNode;
                con2.style.display = "none";
            } else {
                window.location = "cuentas.jsp";
            }
        }

        function elegidoTransferir2(radio) {
            var TD = radio.parentNode;
            var TR = TD.parentNode;
            var celda = TR.querySelectorAll("td")[0];
            $("#cuentaDestino").text(celda.textContent);
            $("#confirmarTransferencia").show();
        }
        function llamarMetodoDejoDeEscribir(input) {
            var numero = parseFloat(input.value);
            var max = parseFloat(input.max);
            if (numero < max) {
                document.getElementById("elegirCuenta1").disabled = false;
                document.getElementById("elegirCuenta1").style.color = "#5264AE";
            } else {
                document.getElementById("elegirCuenta1").disabled = true;
                document.getElementById("elegirCuenta1").style.color = "grey";

                $("#myPopup").fadeIn(500);
                $("#myPopup").fadeOut(2000);
            }
        }
        function elegida() {
            var input = document.getElementById("monto");
            var numero = parseFloat(input.value);
            var max = parseFloat(input.max);
            var cuentaOrigen1 = $("#cuentaOrigen").text();
            if (!Number.isNaN(numero)) {
                if (numero > max) {
                    $("#myPopup").fadeIn(500);
                    $("#myPopup").fadeOut(2000);
                } else {
                    $("#montoCelda").text(numero);
                    var trs = document.getElementsByClassName("filasDestino");
                    for (let tr of trs) {
                        var td = tr.querySelectorAll("td")[0];
                        if (cuentaOrigen1 === td.textContent) {
                            tr.style.display = "none";
                        }
                    }
                    $("#mensaje1").hide();
                    $("#listadoCuentas").hide();
                    $("#contenedorMonto").hide();
                    $("#contenedorTablaTransferencia").show();
                }
            }
        }
    </script>
    <%@include file='footer.html' %>
    <%}%>
</body>
</html>
