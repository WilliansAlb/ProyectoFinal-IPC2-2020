<%-- 
    Document   : reporte
    Created on : 14/11/2020, 08:46:34 PM
    Author     : yelbetto
--%>

<%@page import="DTO.ConfiguracionDTO"%>
<%@page import="Base.ConfiguracionDAO"%>
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
        <link rel="stylesheet" href="../resources/css/PopUp.css">
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
            ConfiguracionDAO confi = new ConfiguracionDAO(cn);
            boolean configuraciones = confi.existeConfiguracion();
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
                <div class="ingreso" id="busqueda" style="width: 60%;">
                    <center>
                        <div id="selectorG">
                            <img src="../resources/img/survey.svg">
                            <h1 style="font-weight: 900; color: white;">Reportes gerente</h1>
                            <p style="color: grey;">Escoge el reporte que quieras generar</p>
                            <select id="tipoReporteGerente" name="tipoReporte" style="width:80%;text-align: center; margin-bottom: 20px;">
                                <option value="0" onclick="$('#escoger').hide()">Elige un tipo de reporte</option>
                                <option value="1" onclick="$('#escoger').show()">Historial de cambios realizados en la información de una entidad en especifíco (Cliente, Cajero o Gerente)</option>
                                <option value="2" onclick="$('#escoger').show()">Clientes con transacciones monetarias mayores a un limite establecido</option>
                                <option value="3" onclick="$('#escoger').show()">Clientes con transacciones monetarias sumadas mayores a un límite establecido</option>
                                <option value="4" onclick="$('#escoger').show()">Los 10 clientes con más dinero en sus cuentas</option>
                                <option value="5" onclick="$('#escoger').show()">Clientes que no han realizado transacciones dentro de un intervalo de tiempo</option>
                                <option value="6" onclick="$('#escoger').show()">Historial de transacciones por cliente, se puede realizar la búsqueda basados en nombre, y dentro de limites de dinero en la cuenta</option>
                                <option value="7" onclick="$('#escoger').show()">Cajero que más transacciones ha realizado en un intervalo de tiempo</option>
                            </select>
                            <br>
                            <button class="learn-more buttonEspecial" style="display:none;" id="escoger" onclick="escogido()">Escoger reporte</button>
                        </div>
                        <div id="filtroConfiguracion" style="display:none;">
                            <%
                                if (configuraciones) {
                                    ConfiguracionDTO con = confi.obtenerConfiguracion();
                            %>
                            <img src="../resources/img/survey.svg">
                            <h4 style="color:grey;">Reporte</h4>
                            <p style="color:grey;">Para generar el reporte se utilizará alguno de estos limites, puedes cambiarlos en configuracion</p>
                            <table class="tablaDatos tablas">
                                <thead>
                                    <tr>
                                        <th>Límite mayor</th>
                                        <th>Límite menor</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%out.print(con.getLimite_mayor());%></td>
                                        <td><%out.print(con.getLimite_menor());%></td>
                                    </tr>
                                </tbody>
                            </table>
                            <button class="learn-more buttonEspecial" onclick="enviarAGenerado()">Generar reporte</button>
                            <button class="learn-more buttonEspecial" onclick="window.location = 'configuracion.jsp'">Cambiar limites</button>
                            <%} else {%>
                            <img src="../resources/img/high_priority.svg">
                            <h1 style="font-weight: 900; color: white;">NO EXISTE CONFIGURACION PREVIA</h1>
                            <p style="color: grey;">Para este reporte se debe contar con limites establecidos anteriormente, ingresalos y regresa acá</p>
                            <button class="learn-more buttonEspecial" onclick="window.location = 'configuracion.jsp'">Ingresar limites</button>
                            <%}%>
                        </div>
                        <div id="filtroReporteC5" style="display: none;">
                            <img src="../resources/img/survey.svg">
                            <h4 style="color:grey;">Reporte</h4>
                            <p style="color:grey;">Para este reporte tienes que ingresar un intervalo de tiempo</p>
                            <div class="group">
                                <input type="date" id="fecha1" name="fecha1" class="inputCentrado" required style="color: #EBEBEB !important;" value="2000-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha1" class="labelCentrado">Fecha de nacimiento</label>
                            </div>
                            <div class="group">
                                <input type="date" id="fecha2" name="fecha2" class="inputCentrado" required style="color: #EBEBEB !important;" value="2020-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha2" class="labelCentrado">Fecha de nacimiento</label>
                            </div>
                            <span class="popuptext" id="popUpFechas">Rellena las fechas!</span>
                            <button class="learn-more buttonEspecial" onclick="enviarFechas()">Generar reporte</button>
                        </div>
                        <div id="botonCancelar" style="display:none;">
                            <button class="learn-more buttonEspecial" onclick="window.location = 'reporte.jsp'">Cancelar</button>
                        </div>
                    </center>
                </div>
            </div>
        </div>
        <script>
            function escogido() {
                var tipo = $("#tipoReporteGerente").val();
                $("#selectorG").hide();
                if (tipo === '1') {
                    window.location = "acciones.jsp";
                } else if (tipo === '2') {
                    $("#botonCancelar").show();
                    $("#filtroConfiguracion").show();
                } else if (tipo === '3') {
                    $("#botonCancelar").show();
                    $("#filtroConfiguracion").show();
                } else if (tipo === '4') {
                    window.location = "../redireccion?tipo=G" + tipo;
                } else if (tipo === '5') {
                    $("#botonCancelar").show();
                    $("#filtroReporteC5").show();
                } else if (tipo === '6') {

                } else if (tipo === '7') {
                    $("#botonCancelar").show();
                    $("#filtroReporteC5").show();
                }
            }
            function enviarAGenerado() {
                var tipo = $("#tipoReporteGerente").val();
                window.location = "../redireccion?tipo=G" + tipo;
            }
            function enviarFechas() {
                var tipo = $("#tipoReporteGerente").val();
                var fechaD = $("#fecha1").val();
                var fechaH = $("#fecha2").val();
                if (fechaD !== '' && fechaH !== '') {
                    window.location = "../redireccion?tipo=G" + tipo + "&fecha1=" + fechaD + "&fecha2=" + fechaH;
                } else {
                    $("#popUpFechas").fadeIn(500);
                    $("#popUpFechas").fadeOut(2000);
                }
            }
        </script>
        <%} else if (configuracion.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {%>
        <div id="contenedorC" class="crear">
            <div class="contenedorFlex" id="ventanaC">
                <div class="ingreso" id="reportesC" style="width: 70%;">
                    <center>
                        <div id="selectorC">
                            <img src="../resources/img/survey.svg">
                            <h1 style="font-weight: 900; color: white;">Reportes cliente</h1>
                            <p style="color: grey;">Escoge el reporte que quieras generar</p>
                            <select id="tipoReporteCliente" name="tipoReporte" style="width:80%;text-align: center;">
                                <option value="0" onclick="$('#escoger').hide()">Elige un tipo de reporte</option>
                                <option value="1" onclick="$('#escoger').show()">Las últimas 15 transacciones más grandes realizadas en el último año, por cuenta</option>
                                <option value="2" onclick="$('#escoger').show()">Listado de todas las transacciones realizadas dentro de un intervalo de tiempo mostrando el cambio del dinero de la cuenta por cada transacción</option>
                                <option value="3" onclick="$('#escoger').show()">La cuenta con más dinero y sus transacciones con una fecha inicio a ingresar y la fecha en curso como limite superior</option>
                                <option value="4" onclick="$('#escoger').show()">Reporte listado de solicitudes de asociación de cuenta recibidas con su estado</option>
                                <option value="5" onclick="$('#escoger').show()">Reporte listado de solicitudes de asociación de cuenta realizadas con su estado</option>
                            </select>
                            <br>
                            <button class="learn-more buttonEspecial" style="display: none;" id="escoger" onclick="escogido()">Escoger reporte</button>
                        </div>
                        <div id="filtroReporteC5" style="display: none;">
                            <img src="../resources/img/survey.svg">
                            <h4 style="color:grey;">Reporte</h4>
                            <p style="color:grey;">Para este reporte tienes que ingresar un intervalo de tiempo</p>
                            <div class="group">
                                <input type="date" id="fecha1" name="fecha1" class="inputCentrado" required style="color: #EBEBEB !important;" value="2000-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha1" class="labelCentrado">Fecha de nacimiento</label>
                            </div>
                            <div class="group">
                                <input type="date" id="fecha2" name="fecha2" class="inputCentrado" required style="color: #EBEBEB !important;" value="2020-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha2" class="labelCentrado">Fecha de nacimiento</label>
                            </div>
                            <span class="popuptext" id="popUpFechas">Rellena las fechas!</span>
                            <button class="learn-more buttonEspecial" onclick="enviarFechas()">Generar reporte</button>
                        </div>
                        <div id="filtroReporteC4" style="display: none;">
                            <img src="../resources/img/survey.svg">
                            <h4 style="color:grey;">Reporte</h4>
                            <p style="color:grey;">Para este reporte tienes que ingresar una fecha para que puedas crear el intervalo entre esa fecha y hoy</p>
                            <div class="group">
                                <input type="date" id="fecha3" name="fecha3" class="inputCentrado" required style="color: #EBEBEB !important;" value="2000-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha3" class="labelCentrado">Fecha de nacimiento</label>
                            </div>
                            <span class="popuptext" id="popUpFechas2">Rellena las fechas!</span>
                            <button class="learn-more buttonEspecial" onclick="enviarFechas2()">Generar reporte</button>
                        </div>
                        <div id="botonCancelar" style="display:none;">
                            <button class="learn-more buttonEspecial" onclick="window.location = 'reporte.jsp'">Cancelar</button>
                        </div>
                    </center>
                </div>
            </div>
        </div>
        <script>
            function escogido() {
                var tipo = $("#tipoReporteCliente").val();
                if (tipo === '1') {
                    window.location = "../redireccion?tipo=C" + tipo;
                } else if (tipo === '2') {
                    $("#selectorC").hide();
                    $("#botonCancelar").show();
                    $("#filtroReporteC5").show();
                } else if (tipo === '3') {
                    $("#selectorC").hide();
                    $("#botonCancelar").show();
                    $("#filtroReporteC4").show();
                } else if (tipo === '4') {
                    window.location = "../redireccion?tipo=C" + tipo;
                } else if (tipo === '5') {
                    window.location = "../redireccion?tipo=C" + tipo;
                }
            }
            function enviarFechas() {
                var tipo = $("#tipoReporteCliente").val();
                var fechaD = $("#fecha1").val();
                var fechaH = $("#fecha2").val();
                if (fechaD !== '' && fechaH !== '') {
                    window.location = "../redireccion?tipo=C" + tipo + "&fecha1=" + fechaD + "&fecha2=" + fechaH;
                } else {
                    $("#popUpFechas").fadeIn(500);
                    $("#popUpFechas").fadeOut(2000);
                }
            }
            function enviarFechas2() {
                var tipo = $("#tipoReporteCliente").val();
                var fechaD = $("#fecha3").val();
                if (fechaD !== '') {
                    window.location = "../redireccion?tipo=C" + tipo + "&fecha1=" + fechaD;
                } else {
                    $("#popUpFechas2").fadeIn(500);
                    $("#popUpFechas2").fadeOut(2000);
                }
            }
        </script>
        <%} else {%>
        <div id="contenedorC" class="crear">
            <div class="contenedorFlex" id="ventanaC">
                <div class="ingreso" id="reportesC" style="width: 70%;">
                    <center>
                        <div id="selectorCA">
                            <img src="../resources/img/survey.svg">
                            <h1 style="font-weight: 900; color: white;">Reportes cajero</h1>
                            <p style="color: grey;">Escoge el reporte que quieras generar</p>
                            <select id="tipoReporteCajero" name="tipoReporte" style="width:80%;text-align: center;">
                                <option value="0" onclick="$('#escoger').hide()">Elige un tipo de reporte</option>
                                <option value="1" onclick="$('#escoger').show()">Listado de depósitos y retiros realizados durante su turno de manera ordenada, mostrando el total existente en caja (depósitos - retiros)</option>
                                <option value="2" onclick="$('#escoger').show()">Listado de las transacciones realizadas por día en un intervalo de tiempo, mostrando el balance final</option>
                            </select>
                            <br>
                            <button class="learn-more buttonEspecial" style="display: none;" id="escoger" onclick="escogido()">Escoger reporte</button>
                        </div>
                        <div id="filtroReporteCA2" style="display: none;">
                            <img src="../resources/img/survey.svg">
                            <h4 style="color:grey;">Reporte</h4>
                            <p style="color:grey;">Para este reporte tienes que ingresar un intervalo de tiempo</p>
                            <div class="group">
                                <input type="date" id="fecha1" name="fecha1" class="inputCentrado" required style="color: #EBEBEB !important;" value="2000-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha1" class="labelCentrado">Fecha de nacimiento</label>
                            </div>
                            <div class="group">
                                <input type="date" id="fecha2" name="fecha2" class="inputCentrado" required style="color: #EBEBEB !important;" value="2020-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha2" class="labelCentrado">Fecha de nacimiento</label>
                            </div>
                            <span class="popuptext" id="popUpFechas">Rellena las fechas!</span>
                            <button class="learn-more buttonEspecial" onclick="enviarFechas()">Generar reporte</button>
                        </div>
                    </center>
                </div>
            </div>
        </div>

        <script>
            function escogido() {
                var tipo = $("#tipoReporteCajero").val();
                $("#selectorCA").hide();
                if (tipo === '1') {
                    
                } else if (tipo === '2') {
                    $("#botonCancelar").show();
                    $("#filtroReporteCA2").show();
                }
            }
            function enviarFechas() {
                var tipo = $("#tipoReporteCajero").val();
                var fechaD = $("#fecha1").val();
                var fechaH = $("#fecha2").val();
                if (fechaD !== '' && fechaH !== '') {
                    window.location = "../redireccion?tipo=CA" + tipo + "&fecha1=" + fechaD + "&fecha2=" + fechaH;
                } else {
                    $("#popUpFechas").fadeIn(500);
                    $("#popUpFechas").fadeOut(2000);
                }
            }
        </script>
        <%}%>
        <%}%>
        <%@include file='footer.html' %>
    </body>
</html>
