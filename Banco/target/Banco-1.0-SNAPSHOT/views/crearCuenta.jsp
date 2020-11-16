<%-- 
    Document   : crearCuenta
    Created on : 7/11/2020, 08:32:20 PM
    Author     : yelbetto
--%>

<%@page import="Base.Conector"%>
<%@page import="Base.GerenteDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <title>Crear Cuenta</title>
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
        <script src="../resources/js/creacion.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            HttpSession configuracion = request.getSession();
            Conector cn = new Conector("encender");
            boolean correcto = false;
            boolean turnoCorrecto = false;
            if (configuracion.getAttribute("tipo") != null) {
                if (configuracion.getAttribute("tipo").toString().equalsIgnoreCase("GERENTE")) {
                    GerenteDAO trabajando = new GerenteDAO(cn);
                    correcto = true;
                    turnoCorrecto = trabajando.turnoCorrecto(Long.parseLong(configuracion.getAttribute("codigo").toString()));
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
                java.util.Date fecha = new Date();
                SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
                String fecha_actual = formateador.format(fecha);
        %>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" id="buscarCliente">
                <div class="ingreso" id="ingresoDpiCuenta">
                    <center>
                        <img src="../resources/img/manager.svg" max-width="67px">
                        <h1 style="font-weight: 900;color:white;">Crear Cuenta</h1>
                        <p style="color:grey;">Ingresa el DPI del propietario de la nueva cuenta</p>
                        <form id="formularioValidarCliente" action="../creacion" method="GET">
                            <div class="group">
                                <input type="text" class="inputCentrado" required id="dpi" onkeydown="dpiValido(this)" style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpi" class="labelCentrado">DPI del dueño de la cuenta</label>
                            </div>
                            <button class="learn-more buttonEspecial" style="width: 30%;">Validar<img src="../resources/img/fine_print.svg" width="15%" class="imagenBoton"></button>
                        </form>
                    </center>
                </div>
            </div>
            <div class="contenedorFlex" id="confirmarCliente" style="display:none;">
                <div class="ingreso" id="ingresoDpiCuenta1" style="width: 70% !important;">
                    <center>
                        <img src="../resources/img/manager.svg" max-width="67px">
                        <h1 style="font-weight: 900;">Crear Cuenta</h1>
                        <p>Datos de dueño de cliente a corroborar e ingresar monto de apertura</p>
                        <table class="tablaDatos" style="width: 95%;">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Nombre</th>
                                    <th>Sexo</th>
                                    <th>DPI</th>
                                    <th>Direccion</th>
                                    <th>Fecha nacimiento</th>
                                    <th>PDF DPI</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="celdaCodigo">######</td>
                                    <td id="celdaNombre">aaaaaa</td>
                                    <td id="celdaSexo">MMMMMM</td>
                                    <td id="celdaDPI">111111</td>
                                    <td id="celdaDireccion">la cuarta avenida de alguna colonia de un lugar donde no entra la luz en los amaneceres</td>
                                    <td id="celdaFecha">####-##-##</td>
                                    <td><button class="buttonEspecial learn-more" id="botonDPI" onclick="visualizarDPI(this)">VER DPI</button></td>
                                </tr>
                            </tbody>
                        </table>
                        <div id="datosCuenta" style="display:none;">
                            <form action="../creacion" method="POST" id="formularioCuenta">
                                <h3>Datos para la creación de la cuenta</h3>
                                <div class="group">
                                    <input type="date" id="fecha" style="color: #EBEBEB !important;" value="<%out.print(fecha_actual);%>">
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label for="fecha">Fecha actual</label>
                                </div>
                                <div class="group">
                                    <input type="number" id="monto" min="1.00" step="0.05" required style="color: #EBEBEB !important;" value="<%out.print(fecha_actual);%>">
                                    <span class="highlight"></span>
                                    <span class="bar"></span>
                                    <label for="fecha">Monto con el que aperturar la cuenta</label>
                                </div>
                                <button class="learn-more buttonEspecial" id="ingresarCuenta">Ingresar cuenta</button>
                            </form>
                        </div>
                        <button class="learn-more buttonEspecial" onclick="dpiCorrecto(this)" style="width: 30%;">CONTINUAR</button>
                    </center>
                </div>
            </div>
            <div id="contenedorMensaje2" class="contenedorFlex" style="display:none;overflow-y: scroll;">
                <div id="contenedorInterior2" class="ingreso" style="background-color: inherit;">
                    <center>
                        <h1 style="font-weight: 900;color:white;">Crear Cliente</h1>
                        <p style="color:grey;">Dado que el cliente aún no está en el sistema, ingresa el siguiente formulario con sus datos</p>
                        <form action="../creacion" method="POST" id="formularioCliente" enctype="multipart/form-data">
                            <div class="group">
                                <input type="text" id="dpiCliente" class="deshabilitado" value="" name="dpi" disabled style="color: grey !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpiCliente">DPI</label>
                            </div>
                            <div class="group">
                                <input type="text" id="nombreCliente" name="nombre" required style="color: #EBEBEB !important;" value="">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="nombreCliente">Nombre</label>
                            </div>
                            <div class="group">
                                <input type="date" id="fechaCliente" name="fecha" required style="color: #EBEBEB !important;" value="2000-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fechaCliente">Fecha de nacimiento</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="sexos">Sexo</label>
                                <br>
                                <select id="sexos" style="width:100%;" name="sexo">
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                            <div class="group">
                                <input type="text" id="direccionCliente" name="direccion" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="direccionCliente">Direccion</label>
                            </div>
                            <div style="width:100%;">
                                <label for="archivo" id="selectorArchivo" tabindex="0" class="input-file-trigger">Ingresa PDF de DPI...<img src="../resources/img/data_recovery.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                                    <input type="file" id="archivo" accept=".pdf" name="archivo" onchange="verificar()" required></label>
                                <p id="ruta" class="file-return"></p>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="generar">¿Generar contraseña aleatoria?</label>
                                <br>
                                <select id="generar" onchange="generarPassword(this)" name="generar" style="width:100%;">
                                    <option value="N" selected>No</option>
                                    <option value="S">Sí</option>
                                </select>
                            </div>
                            <div class="group" id="campoPassword">
                                <input type="password" id="passwordCliente" name="password" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="passwordCliente">Contraseña</label>
                            </div>
                            <button class="learn-more buttonEspecial" id="ingresarCliente">CONTINUAR</button>
                        </form>
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
                    <table class="tablaDatos" style="width: 95%;">
                        <thead>
                            <tr>
                                <th id="columna1">No. de cuenta</th>
                                <th id="columna2">Propietario</th>
                                <th id="columna3">Saldo</th>
                                <th id="columna4">Fecha de creacion</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td id="mostrar1"></td>
                                <td id="mostrar2"></td>
                                <td id="mostrar3"></td>
                                <td id="mostrar4"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <button class="learn-more buttonEspecial" onclick="cerrarRedirigir(this)" id="cerrarRedirigir">CONTINUAR</button>
            </div>
        </div>
        <div id="contenedorMensaje3" class="oculto" style="display:none;">
            <div id="contenedorInterior3" class="mensaje2" style="background-color: #001a28;">
                <center>
                    <h1 id="informando1" style="color: white;">DPI de cliente .....</h1>
                    <embed src="" width="80%" height="400px" id="visorPDF">
                    <br><button class="learn-more buttonEspecial" onclick="document.getElementById('contenedorMensaje3').style.display = 'none';">CERRAR</button>
                </center>
            </div>
        </div>
    </center>
    <script>
        function dpiCorrecto(boton) {
            boton.style.display = "none";
            $("#datosCuenta").fadeIn();
        }
        function verificar() {
            const file = document.getElementById("archivo").files[0];
            const file1 = document.getElementById("archivo");
            document.getElementById('ruta').innerText = ".." + file1.value.slice(12);
        }
        function generarPassword(select) {
            var valor = select.value;
            if (valor === 'N') {
                $("#campoPassword").show();
                $("#passwordCliente").attr("required");
            } else {
                $("#campoPassword").hide();
                $("#passwordCliente").removeAttr("required");
            }
        }
    </script>
    <%@include file='footer.html' %>
    <%} else {%>
    <%@include file="turno.jsp" %>
    <%@include file='footer.html' %>
    <%}%>
    <%}%>
</body>
</html>
