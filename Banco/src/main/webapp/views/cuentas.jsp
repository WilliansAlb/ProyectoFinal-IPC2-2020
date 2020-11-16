<%-- 
    Document   : cuentas
    Created on : 14/11/2020, 07:21:03 PM
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
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <title>Retirar</title>
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
    </head>
    <body>
        <%
            HttpSession sesionRetiro = request.getSession();
            boolean correcto = false;
            if (sesionRetiro.getAttribute("tipo") != null) {
                if (sesionRetiro.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {
                    correcto = true;
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida"></div>
        <%
            if (correcto) {
                HttpSession sesionRetiroCliente = request.getSession();
                Conector cn = new Conector("encender");
                CuentaDAO cuentas = new CuentaDAO(cn);
                ArrayList<CuentaDTO> listado = cuentas.obtenerCuentas(Long.parseLong(sesionRetiroCliente.getAttribute("codigo").toString()));
                ArrayList<CuentaDTO> listadoAsociada = cuentas.obtenerCuentasAsociadas(Long.parseLong(sesionRetiroCliente.getAttribute("codigo").toString()));
        %>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" id="buscarCliente">
                <div class="ingreso" id="ingresoDpiCuenta" style="width:80%;">
                    <center>
                        <img src="../resources/img/018-insurance.svg" max-width="67px">
                        <h1 style="font-weight: 900;color:white;">Tus cuentas</h1>
                        <div id="retiroBusqueda">
                            <p style="color:grey;">Se muestran tus cuentas, puedes ver las transacciones de cada una</p>
                            <div class="group" style="width: 40%;">
                                <span class="popuptext" id="myPopup">Debe ser un número!</span>
                                <input type="text" id="busqueda" class="inputCentrado" onkeyup="comprobar(this, 'BUSCAR')" style="color: white;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="busqueda" class="labelCentrado">NO. DE CUENTA</label>
                            </div>
                            <table class="tablaDatos" id="listadoCuentas" width="95%">
                                <thead>
                                    <tr>
                                        <th>NO. DE CUENTA</th>
                                        <th>SALDO</th>
                                        <th>ASOCIADO</th>
                                        <th>FECHA DE CREACION</th>
                                        <th>HISTORIAL DE TRANSACCIONES</th>
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
                                        <td><button class="learn-more buttonEspecial" value="<%out.print(temporal.getCodigo());%>" onclick="mostrarTransacciones(this)">VER</button></td>
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
                                        <td><button class="learn-more buttonEspecial" onclick="rellenarDatosElegida(this)">VER</button></td>
                                    </tr>
                                    <%}
                                    %>
                                </tbody>
                            </table>
                            <div id="sinResultados" style="display: none;">
                                <img src="../resources/img/questions.svg" max-width="67px">
                                <p style="color:grey;">No se encontraron resultados para la búsqueda</p>
                            </div>
                        </div>
                    </center>
                </div>
            </div>
        </div>
        <script>
            function mostrarTransacciones(boton){
                window.location = "../transaccion?cuentas="+boton.value+"&verificado=S";
            }
            function cerrarRedirigir(boton) {
                if (boton.textContent === 'CERRAR') {
                    var con1 = boton.parentNode;
                    var con2 = con1.parentNode;
                    con2.style.display = "none";
                } else {
                    window.location = "retiroCliente.jsp";
                }
            }
            function validar(input) {
                if (input.value > 0) {
                    var saldo = input.max;
                    var monto = input.value;
                    if (parseFloat(saldo) < parseFloat(monto)) {
                        console.log(saldo < monto);
                        $("#popUpMonto").text("Saldo insuficiente!");
                        $('#popUpMonto').show();
                        $('#popUpMonto').fadeOut(2000);
                        document.getElementById("ingresarRetiro").style.color = "grey";
                    } else {
                        document.getElementById("ingresarRetiro").style.color = "#5264AE";
                    }
                }
            }
            function rellenarDatosElegida(boton) {
                var filaTD = boton.parentNode;
                var filaTabla = filaTD.parentNode;
                var filas1 = filaTabla.querySelectorAll("td");
                var noCuenta = filas1[0].textContent;
                var saldo = filas1[1].textContent;
                var asociado = filas1[2].textContent;
                var fecha = filas1[3].textContent;
                var filaTabla2 = document.getElementsByClassName("filaDatos")[0];
                var filas2 = filaTabla2.querySelectorAll("td");
                filas2[0].textContent = noCuenta;
                filas2[1].textContent = saldo;
                filas2[2].textContent = asociado;
                filas2[3].textContent = fecha;
                document.getElementById("monto").max = saldo;
                document.getElementById("retiroBusqueda").style.display = "none";
                document.getElementById("retiroMonto").style.display = "";
            }

            function comprobar(input,valor) {
                dejarDeEscribir(input,valor);
            }
            let timeout;
            function dejarDeEscribir(input, valor) {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    if (valor === 'BUSCAR') {
                        buscarCuenta(input);
                    } else {
                        validar(input);
                    }
                    clearTimeout(timeout);
                }, 800);
            }
            function buscarCuenta(input) {
                if (input.value > 0) {
                    var trs = document.getElementsByClassName("cuentaDatos");
                    for (let tr of trs) {
                        tr.style.display = "";
                    }
                    var resultados = false;
                    for (let tr of trs) {
                        var codigo = tr.querySelectorAll("td")[0];
                        if (codigo.textContent.includes(input.value, 0)) {
                            tr.style.display = "";
                            resultados = true;
                        } else {
                            tr.style.display = "none";
                        }
                    }
                    if (resultados) {
                        document.getElementById("listadoCuentas").style.display = "";
                        document.getElementById("sinResultados").style.display = "none";
                    } else {
                        document.getElementById("sinResultados").style.display = "";
                        document.getElementById("listadoCuentas").style.display = "none";
                    }
                } else {
                    if (input.value !== "") {
                        $('#myPopup').fadeIn(1000);
                        $('#myPopup').fadeOut(3000);
                    } else {
                        document.getElementById("listadoCuentas").style.display = "";
                        document.getElementById("sinResultados").style.display = "none";
                        var trs = document.getElementsByClassName("cuentaDatos");
                        for (let tr of trs) {
                            tr.style.display = "";
                        }
                    }
                }
            }
        </script>
        <%@include file='footer.html' %>
        <%}%>
    </body>
</html>
