<%-- 
    Document   : configuracion
    Created on : 8/11/2020, 02:17:21 AM
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
        <title>Configuración</title>
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
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
    </head>
    <body>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida"></div>
        <%
            Conector cn = new Conector("encender");
            ConfiguracionDAO configuraciones = new ConfiguracionDAO(cn);
            ConfiguracionDTO confi = configuraciones.obtenerConfiguracion();
        %>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" >
                <div class="ingreso" id="ingresoDpiCuenta">
                    <center>
                        <img src="../resources/img/engineering.svg" max-width="67px">
                        <h1 style="font-weight: 900;color:white;">Configurar</h1>
                        <p style="font-size: 0.8em;font-weight: 300; color: grey;">Configura mediante el cambio y guardado de los siguientes campos algunos aspectos para reportes</p>
                        <form>
                            <div class="group">
                                <input type="number" required id="limiteMenor" onkeyup="activarGuardarConfiguracion(this)" value="<%out.print(confi.getLimite_menor());%>" style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="limiteMenor">Limite menor</label>
                            </div>
                            <div class="group">
                                <input type="number" required id="limiteMayor" onkeyup="activarGuardarConfiguracion(this)" value="<%out.print(confi.getLimite_mayor());%>" style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="limiteMayor">Limite menor</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="matutino">Turno matutino</label>
                                <br>
                                <div id="matutino" style="display:grid; grid-template-columns:auto auto auto auto; color:white;">
                                    Desde -
                                    <div class="input-group clockpicker">
                                        <input type="text" class="form-control" onchange="activarGuardarConfiguracion(this)" value="<%out.print(confi.getD_matutino());%>" pattern="^\d{2}:\d{2}(:\d{2})?$" oninvalid="setCustomValidity('Tienes que ingresar una hora')">
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-time"></span>
                                        </span>
                                    </div>
                                    - Hasta -
                                    <div class="input-group clockpicker">
                                        <input type="text" class="form-control" onchange="activarGuardarConfiguracion(this)" value="<%out.print(confi.getH_matutino());%>" pattern="^\d{2}:\d{2}(:\d{2})?$" oninvalid="setCustomValidity('Tienes que ingresar una hora')">
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-time"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="vespertino">Turno vespertino</label>
                                <br>
                                <div id="vespertino" style="display:grid; grid-template-columns:auto auto auto auto; color:white;">
                                    Desde -
                                    <div class="input-group clockpicker">
                                        <input type="text" class="form-control" onchange="activarGuardarConfiguracion(this)" value="<%out.print(confi.getD_vespertino());%>" pattern="^\d{2}:\d{2}(:\d{2})?$" oninvalid="setCustomValidity('Tienes que ingresar una hora')">
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-time"></span>
                                        </span>
                                    </div>
                                    - Hasta -
                                    <div class="input-group clockpicker">
                                        <input type="text" class="form-control" onchange="activarGuardarConfiguracion(this)" value="<%out.print(confi.getH_vespertino());%>" pattern="^\d{2}:\d{2}(:\d{2})?$" oninvalid="setCustomValidity('Tienes que ingresar una hora')">
                                        <span class="input-group-addon">
                                            <span class="glyphicon glyphicon-time"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <button class="learn-more buttonEspecial" style="color:grey;" id="guardarCambios">Guardar cambios</button>
                        </form>
                    </center>
                </div>
            </div>
        </div>
        <script type="text/javascript" src="../resources/js/jquery.min.js"></script>
        <script type="text/javascript" src="../resources/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="../resources/js/bootstrap-clockpicker.min.js"></script>
        <script type="text/javascript" src="../resources/js/highlight.min.js"></script>
        <script type="text/javascript">
                            $('.clockpicker').clockpicker({
                                placement: 'top',
                                align: 'left',
                                donetext: 'Hecho'
                            });
                            function activarGuardarConfiguracion(){
                                document.getElementById("guardarCambios").style.color = "#5264AE";
                            }
        </script>
    </body>
    <%@include file='footer.html' %>
</html>
