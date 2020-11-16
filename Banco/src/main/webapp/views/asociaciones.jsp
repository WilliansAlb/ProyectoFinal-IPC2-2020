<%-- 
    Document   : asociaciones
    Created on : 12/11/2020, 11:34:44 PM
    Author     : yelbetto
--%>

<%@page import="DTO.AsociacionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.AsociacionDAO"%>
<%@page import="Base.Conector"%>
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
        <script src="../resources/js/listadoAsociaciones.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="bienvenida"></div>
        <%
            HttpSession sesionAsociaciones = request.getSession();
            boolean correcto = false;
            if (sesionAsociaciones.getAttribute("tipo") != null) {
                if (sesionAsociaciones.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {
                    correcto = true;
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }

        %>
        <%if (correcto) {
                Conector cn = new Conector("encender");
                AsociacionDAO asociaciones = new AsociacionDAO(cn);
                ArrayList<AsociacionDTO> asociacion = asociaciones.obtenerAsociacionesRecibidas(Long.parseLong(sesionAsociaciones.getAttribute("codigo").toString()));
                ArrayList<AsociacionDTO> asociacion2 = asociaciones.obtenerAsociacionesRealizadas(Long.parseLong(sesionAsociaciones.getAttribute("codigo").toString()));
                boolean mensaje = false;
        %>
        <%@include file="sidebar.jsp" %>
        <div id="contenedorBusqueda" class="crear">
            <div class="contenedorFlex" id="busquedaCuenta">
                <div class="ingreso" id="busqueda" style="width: 70%;">
                    <center>
                        <img src="../resources/img/conference_call.svg">
                        <h1 style="font-weight: 900; color: white;">Solicitudes de asociación</h1>
                        <p style="color: grey;">Se muestran las solicitudes de asociacion de cuenta que coinciden con el siguiente filtro</p>
                        <select id="filtrarSolicitudes" onchange="filtrarSolicitudes(this)">
                            <option value="1">Todas las solicitudes recibidas</option>
                            <option value="2">Todas las solicitudes realizadas</option>
                            <option value="3" selected>Solicitudes recibidas pendientes</option>
                            <option value="4">Solicitudes realizadas pendientes</option>
                            <option value="5">Solicitudes recibidas aceptadas</option>
                            <option value="6">Solicitudes realizadas aceptadas</option>
                        </select>
                        <div id="tablaRealizadas" style="display:none;">
                            <h4 style="font-weight: 900; color: white;">Solicitudes realizadas</h4>
                            <table class="tablaDatos" id="realizadas" width="95%">
                                <thead>
                                    <tr>
                                        <th>CODIGO</th>
                                        <th>NO DE CUENTA</th>
                                        <th>ESTADO</th>
                                        <th>VER</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < asociacion2.size(); i++) {
                                            AsociacionDTO temporal = asociacion2.get(i);
                                    %>
                                    <%if (temporal.getEstado().equalsIgnoreCase("EN ESPERA")) {%>
                                    <tr class="solicitudEspera">
                                        <%} else if (temporal.getEstado().equalsIgnoreCase("ACEPTADA")) {%>
                                    <tr class="solicitudAceptada">
                                        <%} else {%>
                                    <tr class="solicitudRechazada">
                                        <%}%>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getCuenta());%></td>
                                        <td><%out.print(temporal.getEstado());%></td>
                                        <td><button class="learn-more buttonEspecial" onclick="verDatosSolicitado(this)">VER</button></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <%for (int i = 0; i < asociacion.size(); i++) {
                                AsociacionDTO temporal = asociacion.get(i);
                                if (temporal.getEstado().equalsIgnoreCase("EN ESPERA")) {
                                    mensaje = true;
                                }
                            }
                        %>
                        <%if (asociacion.size() == 0 || !mensaje) {%>
                        <div id="tablaRecibidas" style="display:none;">
                            <%} else {%>
                            <div id="tablaRecibidas">
                                <%}%>
                                <h4 style="font-weight: 900; color: white;">Solicitudes recibidas</h4>
                                <table class="tablaDatos" id="recibidas" width="95%">
                                    <thead>
                                        <tr>
                                            <th>CODIGO</th>
                                            <th>NO DE CUENTA</th>
                                            <th>SOLICITANTE</th>
                                            <th>ESTADO</th>
                                            <th>VER</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%for (int i = 0; i < asociacion.size(); i++) {
                                                AsociacionDTO temporal = asociacion.get(i);
                                        %>
                                        <%if (temporal.getEstado().equalsIgnoreCase("EN ESPERA")) {
                                                mensaje = true;
                                        %>
                                        <tr class="solicitudEspera">
                                            <%} else if (temporal.getEstado().equalsIgnoreCase("ACEPTADA")) {%>
                                        <tr class="solicitudAceptada" style="display:none">
                                            <%} else {%>
                                        <tr class="solicitudRechazada" style="display:none">
                                            <%}%>
                                            <td><%out.print(temporal.getCodigo());%></td>
                                            <td><%out.print(temporal.getCuenta());%></td>
                                            <td><%out.print(temporal.getCliente());%></td>
                                            <td><%out.print(temporal.getEstado());%></td>
                                            <td><button class="learn-more buttonEspecial" onclick="verDatosSolicitante(this)">VER</button></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <%
                                if (asociacion.size() > 0) {
                                    if (mensaje) {%>
                            <div id="tablaSinResultados" style="display:none;">
                                <%} else {%>
                                <div id="tablaSinResultados">
                                    <%}%>
                                    <%} else {%>
                                    <div id="tablaSinResultados">
                                        <%}%>
                                        <img src="../resources/img/questions.svg">
                                        <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                        <p style="color: grey;">El filtro que elegiste no tiene resultados</p>
                                    </div>

                                    </center>
                                </div>
                            </div>
                            <div class="contenedorFlex" id="datosSolicitado" style="display:none;">
                                <div class="ingreso" id="datosS2" style="width: 70% !important;">
                                    <center>
                                        <h1 style="font-weight: 900;color: white;">Datos solicitado</h1>
                                        <p style="font-weight: 300; color: grey;">Datos del dueño de la cuenta a la que se le solicitó la asociación y de la cuenta solicitada</p>
                                        <table class="tablaDatos" style="width:80%;">
                                            <thead>
                                                <tr>
                                                    <th>Codigo solicitud<th>
                                                    <th>Cuenta</th>
                                                    <th>Nombre</th>
                                                    <th>DPI</th>
                                                    <th>Direccion</th>
                                                    <th>Estado solicitud</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td id="campo6"></td>
                                                    <td id="campo1">######</td>
                                                    <td id="campo2">MMMMMM</td>
                                                    <td id="campo3">111111</td>
                                                    <td id="campo4">la cuarta avenida de alguna colonia de un lugar donde no entra la luz en los amaneceres</td>
                                                    <td id="campo5"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <p style="font-weight: 300; color: grey;">DPI del propietario de la cuenta</p>
                                        <embed src="" width="80%" height="250px" id="visorPDF">
                                        <hr width="50%">
                                        <button class="learn-more buttonEspecial" onclick="movilidad()" style="width:30%;">Regresar<img class="imagenBoton" src="../resources/img/previous.svg" width="5%"></button>
                                    </center>
                                </div>
                            </div>
                            <div class="contenedorFlex" id="datosSolicitante" style="display:none;">
                                <div class="ingreso" id="datosS1" style="width: 70% !important;">
                                    <center>
                                        <h1 style="font-weight: 900;color: white;">Datos solicitante</h1>
                                        <p style="font-weight: 300; color: grey;">Datos de la solicitud y del solicitante de la asociación</p>
                                        <table class="tablaDatos" style="width:80%;">
                                            <thead>
                                                <tr>
                                                    <th>Codigo solicitud</th>
                                                    <th>Cuenta solicitada</th>
                                                    <th>Nombre</th>
                                                    <th>DPI</th>
                                                    <th>Direccion</th>
                                                    <th>Estado solicitud</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td id="campoS6"></td>
                                                    <td id="campoS1">######</td>
                                                    <td id="campoS2">MMMMMM</td>
                                                    <td id="campoS3">111111</td>
                                                    <td id="campoS4">la cuarta avenida de alguna colonia de un lugar donde no entra la luz en los amaneceres</td>
                                                    <td id="campoS5"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <p style="font-weight: 300; color: grey;">DPI del propietario de la cuenta</p>
                                        <embed src="" width="80%" height="250px" id="visorPDF2">
                                        <div id="cancelarAceptar" style="display:none;">
                                            <p style="color:grey;">¿Qué quieres hacer con esta solicitud?</p>
                                            <button class="learn-more buttonEspecial" onclick="editarSolicitud(this)" value="ACEPTADA">ACEPTAR</button>
                                            <button class="learn-more buttonEspecial" onclick="editarSolicitud(this)" value="RECHAZADA">RECHAZAR</button>
                                        </div>
                                        <hr width="50%">
                                        <button class="learn-more buttonEspecial" onclick="movilidad()" style="width:30%;">Regresar<img class="imagenBoton" src="../resources/img/previous.svg" width="5%"></button>
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

                            function cerrar(boton) {
                                if (boton.textContent === 'CERRAR') {
                                    var con1 = boton.parentNode;
                                    var con2 = con1.parentNode;
                                    con2.style.display = "none";
                                } else {
                                    window.location = "asociaciones.jsp";
                                }
                            }
                        </script>
                        <%@include file='footer.html' %>
                        <%}%>
                        </body>
                        </html>
