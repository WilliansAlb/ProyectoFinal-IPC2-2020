<%-- 
    Document   : crearCajero
    Created on : 8/11/2020, 12:53:36 AM
    Author     : yelbetto
--%>

<%@page import="Base.GerenteDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
        <title>Crear Cajero</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../resources/css/sidebar.css">
        <link rel="stylesheet" href="../resources/css/button2.css">
        <link rel="stylesheet" href="../resources/css/input.css"/>
        <link rel="stylesheet" href="../resources/css/creacion.css"/>
        <link rel="stylesheet" href="../resources/css/ocultoGeneral.css"/>
        <link rel="stylesheet" href="../resources/css/inputArchivo.css"/>
        <link rel="stylesheet" href="../resources/css/home.css"/>
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
                    turnoCorrecto = trabajando.turnoCorrecto(Integer.parseInt(configuracion.getAttribute("codigo").toString()));
                } else {
                    response.sendRedirect("home.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <%if (correcto) {%>
        <%@include file="sidebar.jsp"%>
        <div class="bienvenida">
        </div>
        <%if (turnoCorrecto) {%>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" >
                <div class="ingreso" id="ingresoDpiCuenta">
                    <center>
                        <img src="../resources/img/businessman.svg">
                        <h1 style="font-weight: 900; color: white;">Crear Trabajador</h1>
                        <p style="color: grey;">Completa el formulario para ingresar al trabajador al sistema</p>
                        <form action="../creacion" method="POST" id="formularioCajero">
                            <div class="group">
                                <input type="text" id="dpiCajero" value="" name="dpi" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpiCajero">DPI</label>
                            </div>
                            <div class="group">
                                <input type="text" id="nombreCajero" name="nombre" required style="color: #EBEBEB !important;" value="">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="nombreCajero">Nombre</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="turnos">Turno</label>
                                <br>
                                <select id="turnos" style="width:100%;" name="turno">
                                    <option value="M">Matutino</option>
                                    <option value="V">Vespertino</option>
                                </select>
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
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="tipos">Tipo de trabajador:</label>
                                <br>
                                <select id="tipos" style="width:100%;" name="tipo">
                                    <option value="C">Cajero</option>
                                    <option value="G">Gerente</option>
                                </select>
                            </div>
                            <div class="group">
                                <input type="text" id="direccionCajero" required name="direccion" style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="direccionCajero">Direccion</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="generar">¿Generar contraseña aleatoria?</label>
                                <br>
                                <select id="generar" onchange="generarPasswordCajero(this)" name="generar" style="width:100%;">
                                    <option value="N" selected>No</option>
                                    <option value="S">Sí</option>
                                </select>
                            </div>
                            <div class="group" id="campoPassword">
                                <input type="password" id="passwordCajero" name="password" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="passwordCajero">Contraseña</label>
                            </div>
                            <button class="learn-more buttonEspecial" id="ingresarCajero">Ingresar</button>
                        </form>
                    </center>
                </div>
            </div>
        </div>
    <center>
        <div id="contenedorMensaje" class="oculto" style="display:none;">
            <div id="contenedorInterior" class="mensaje2">
                <div style="padding: 2em;">
                    <img id="imagen" src="../resources/img/checkmark.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                    <h3 id="tituloMensaje" style="margin:0;">por defecto</h3><article id="articulo" style="display:inline-block;">asdjfaksjdlfkajsdlkfjalsdjflkasjdlkfjaskldjflasdfa</article>
                </div>
                <button class="learn-more buttonEspecial" onclick="document.getElementById('contenedorMensaje').style.display = 'none'">Cerrar</button>
            </div>
        </div> 
    </center>
    <%@include file='footer.html' %>
    <%} else {%>
    <%@include file="turno.jsp" %>
    <%@include file='footer.html' %>
    <%}%>
    <%}%>
</body>
</html>
