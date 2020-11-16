<%-- 
    Document   : acciones
    Created on : 14/11/2020, 02:16:22 AM
    Author     : yelbetto
--%>

<%@page import="DTO.AccionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.AccionDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <title>Historial de acciones</title>
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
            HttpSession sesionAcciones = request.getSession();
            boolean correcto = false;
            if (sesionAcciones.getAttribute("tipo") != null) {
                if (sesionAcciones.getAttribute("tipo").toString().equalsIgnoreCase("GERENTE")) {
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
                AccionDAO controladorAcciones = new AccionDAO(cn);
                ArrayList<AccionDTO> acciones = controladorAcciones.listadoAcciones(Long.parseLong(sesionAcciones.getAttribute("codigo").toString()));
        %>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida"></div>
        <div id="contenedorAcciones" class="crear">
            <div class="contenedorFlex" id="listaAcciones">
                <div class="ingreso" id="listadoDeAcciones" style="width: 70%;">
                    <center>
                        <img src="../resources/img/017-tasks-2.svg" style="margin-top: 1em;">
                        <h1 style="font-weight: 900; color: white;">Historial de acciones</h1>
                        <p style="color: grey;">Se muestran las acciones que coinciden con el siguiente filtro, puedes cambiar para ver otros resultados</p>
                        <select id="filtrarAcciones" onchange="filtrarAcciones(this)">
                            <option value="1" selected>Todas las acciones</option>
                            <option value="2">Acciones sobre entidad Cliente</option>
                            <option value="3">Acciones sobre entidad Cajero</option>
                            <option value="4">Acciones sobre entidad Gerente</option>
                            <option value="5">Acciones sobre entidad Configuracion</option>
                            <option value="6">Día especifico</option>
                        </select>
                        <div id="fechaContenedor" style="display: none;background-color: #01283e;padding:1%;width: 40%;">
                            <div class="group" style="width: 60%;">
                                <span class="popuptext" id="popFecha">Debes ingresar una fecha!</span>
                                <input type="date" id="fecha" name="fecha" class="inputCentrado" style="color: white;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="busqueda" class="labelCentrado">Ingresa el día</label>
                            </div>
                            <button class="learn-more buttonEspecial" onclick="filtrarFecha(document.getElementById('fecha'))">FILTRAR</button>
                        </div>
                        <%if (acciones.size() > 0) {%>
                        <div id="tablaAcciones">
                            <%} else {%>
                            <div id="tablaAcciones" style="display: none;">
                                <%}%>
                                <h4 style="font-weight: 900; color: white;">Listado de acciones</h4>
                                <a href="../reporte?tipo=2&filtro=" download="acciones.pdf" id="linkDescarga" style="display:none;color:#5264AE;">Exportar a PDF</a>
                                <table class="tablaDatos" id="hechas" width="95%">
                                    <thead>
                                        <tr>
                                            <th>CODIGO</th>
                                            <th>DESCRIPCION</th>
                                            <th>FECHA REALIZACION</th>
                                            <th>ENTIDAD</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%for (int i = 0; i < acciones.size(); i++) {
                                                AccionDTO temporal = acciones.get(i);
                                        %>
                                        <%if (temporal.getEntidad().equalsIgnoreCase("CONFIGURACION")) {%>
                                        <tr class="accionConfiguracion">
                                            <%} else if (temporal.getEntidad().equalsIgnoreCase("CLIENTE")) {%>
                                        <tr class="accionCliente">
                                            <%} else if (temporal.getEntidad().equalsIgnoreCase("CAJERO")) {%>
                                        <tr class="accionCajero">
                                            <%} else {%>
                                        <tr class="accionGerente">
                                            <%}%>
                                            <td><%out.print(temporal.getCodigo());%></td>
                                            <td><%out.print(temporal.getDescripcion());%></td>
                                            <td><%out.print(temporal.getRealizacion());%></td>
                                            <td><%out.print(temporal.getEntidad());%></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <%if (acciones.size() > 0) {%>
                            <div id="tablaSinResultados" style="display: none;">
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
                </div>
                <script>
                    function filtrarFecha(input) {
                        var hechas = document.querySelector("#hechas > tbody");
                        var filas = hechas.querySelectorAll("tr");
                        var existe = false;
                        if (input.value === '') {
                            $("#popFecha").fadeIn(500);
                            $("#popFecha").fadeOut(2000);
                        } else {
                            var f = input.value;
                            for (let fila of filas) {
                                var celda = fila.querySelectorAll("td")[2];
                                if (celda.textContent === f) {
                                    existe = true;
                                    fila.style.display = "";
                                } else {
                                    fila.style.display = "none";
                                }
                            }
                            if (existe) {
                                $("#tablaAcciones").show();
                                $("#tablaSinResultados").hide();
                            } else {
                                $("#tablaAcciones").hide();
                                $("#tablaSinResultados").show();
                            }
                        }
                    }
                    function filtrarAcciones(select) {
                        var hechas = document.querySelector("#hechas > tbody");
                        var filas = hechas.querySelectorAll("tr");
                        var existen = false;
                        var filtroFecha = false;
                        $("#linkDescarga").hide();
                        var hr = document.getElementById("linkDescarga").href;
                        if (select.value === '1') {
                            for (let fila of filas) {
                                existen = true;
                                fila.style.display = "";
                            }
                        } else if (select.value === '2') {
                            for (let fila of filas) {
                                if (fila.className === 'accionCliente') {
                                    $("#linkDescarga").show();
                                    document.getElementById("linkDescarga").href = "../reporte?tipo=2&filtro=CLIENTE";
                                    existen = true;
                                    fila.style.display = "";
                                } else {
                                    fila.style.display = "none";
                                }
                            }
                        } else if (select.value === '3') {
                            for (let fila of filas) {
                                if (fila.className === 'accionCajero') {
                                    $("#linkDescarga").show();
                                    document.getElementById("linkDescarga").href = "../reporte?tipo=2&filtro=CAJERO";
                                    existen = true;
                                    fila.style.display = "";
                                } else {
                                    fila.style.display = "none";
                                }
                            }
                        } else if (select.value === '4') {
                            for (let fila of filas) {
                                if (fila.className === 'accionGerente') {
                                    $("#linkDescarga").show();
                                    document.getElementById("linkDescarga").href = "../reporte?tipo=2&filtro=GERENTE";
                                    existen = true;
                                    fila.style.display = "";
                                } else {
                                    fila.style.display = "none";
                                }
                            }
                        } else if (select.value === '5') {
                            for (let fila of filas) {
                                if (fila.className === 'accionConfiguracion') {
                                    $("#linkDescarga").show();
                                    document.getElementById("linkDescarga").href = "../reporte?tipo=2&filtro=CONFIGURACION";
                                    console.log("encuentra");
                                    existen = true;
                                    fila.style.display = "";
                                } else {
                                    fila.style.display = "none";
                                }
                            }
                        } else if (select.value === '6') {
                            filtroFecha = true;
                        }
                        if (filtroFecha) {
                            $("#fechaContenedor").show();
                        } else {
                            $("#fechaContenedor").hide();
                            if (existen) {
                                $("#tablaAcciones").show();
                                $("#tablaSinResultados").hide();
                            } else {
                                $("#tablaAcciones").hide();
                                $("#tablaSinResultados").show();
                            }
                        }
                    }
                </script>

                <%@include file="footer.html" %>%>
                <%}%>
                </body>
                </html>
