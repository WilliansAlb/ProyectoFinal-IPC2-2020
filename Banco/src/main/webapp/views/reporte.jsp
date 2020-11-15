<%-- 
    Document   : reporte
    Created on : 14/11/2020, 08:46:34 PM
    Author     : yelbetto
--%>

<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte</title>
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <link rel="stylesheet" href="../resources/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="../resources/css/bootstrap-clockpicker.min.css"/>
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
        <script src="../resources/js/oculto.js" type="text/javascript"></script>
        <script src="../resources/js/configuracion.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            HttpSession configuracion = request.getSession();
            Conector cn = new Conector("encender");
            boolean correcto = false;
            if (configuracion.getAttribute("tipo") != null) {
                correcto = true;
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <%if (correcto) {%>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida"></div>
        <%if (configuracion.getAttribute("tipo").toString().equalsIgnoreCase("GERENTE")) {%>
        <div id="contenedorBusqueda" class="crear">
            <div class="contenedorFlex" id="busquedaCuenta">
                <div class="ingreso" id="busqueda" style="width: 70%;">
                    <center>
                        <img src="../resources/img/survey.svg">
                        <h1 style="font-weight: 900; color: white;">Reportes gerente</h1>
                        <p style="color: grey;">Escoge el reporte que quieras generar</p>
                        <select id="tipoReporteGerente" name="tipoReporte" style="width:80%;text-align: center;">
                            <option value="1">Historial de cambios realizados en la información de una entidad en especifíco (Cliente, Cajero o Gerente)</option>
                            <option value="2">Clientes con transacciones monetarias mayores a un limite establecido</option>
                            <option value="3">Clientes con transacciones monetarias sumadas mayores a un límite establecido</option>
                            <option value="4">Los 10 clientes con más dinero en sus cuentas</option>
                            <option value="5">Clientes que no han realizado transacciones dentro de un intervalo de tiempo</option>
                            <option value="6">Historial de transacciones por cliente, se puede realizar la búsqueda basados en nombre, y dentro de limites de dinero en la cuenta</option>
                            <option value="7">Cajero que más transacciones ha realizado en un intervalo de tiempo</option>
                        </select>
                        <br>
                        <button class="learn-more buttonEspecial">Escoger reporte</button>
                        <div id="filtros" style="width:40%;background-color: grey;display:none;" >
                            <form id="filtro1Gerente" method="POST" action="../reporte">
                                <label for="entidades">Entidad:</label>
                                <br>
                                <select id="entidades" name="entidad">
                                    <option value="CLIENTE">Cliente</option>
                                    <option value="CAJERO">Cajero</option>
                                    <option value="GERENTE">Gerente</option>
                                    <option value="CONFIGURACION">Configuracion</option>
                                </select>
                                <hr style="width: 50%;margin: 2px;">
                                <button class="learn-more">Generar reporte</button>
                            </form>
                        </div>
                        <div id="filtros2" style="width:40%;background-color: grey;display:none;" >
                            <form id="filtro2Gerente" method="POST" action="../reporte">
                                <label for="entidades">Entidad:</label>
                                <br>
                                <select id="entidades" name="entidad">
                                    <option value="CLIENTE">Cliente</option>
                                    <option value="CAJERO">Cajero</option>
                                    <option value="GERENTE">Gerente</option>
                                    <option value="CONFIGURACION">Configuracion</option>
                                </select>
                                <hr style="width: 50%;margin: 2px;">
                                <button class="learn-more">Generar reporte</button>
                            </form>
                        </div>
                        <div id="tablaReporte" style="display:none;">
                            <table id="reporteGerente" class="tablaDatos">
                                <thead>
                                    <tr>
                                        <th>Columna por defecto</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Fila por defecto</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div id="pdf" style="display:none;">
                            <embed src="../reporte?tipo=2&filtro=CONFIGURACION" style="width:50%;height: 400px;">
                            <br>
                            <a href="../reporte?tipo=1" download="prueba1.pdf">DESCARGAR</a>
                        </div>
                    </center>
                </div>
            </div>
        </div>
    <center>

    </center>
    <%}%>
    <%}%>
</body>
</html>
