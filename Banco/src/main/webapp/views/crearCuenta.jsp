<%-- 
    Document   : crearCuenta
    Created on : 7/11/2020, 08:32:20 PM
    Author     : yelbetto
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
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
    </head>
    <body>
        <% java.util.Date fecha = new Date();
            SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
            String fecha_actual = formateador.format(fecha);
            System.out.println(fecha_actual);
        %>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida"></div>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" >
                <div class="ingreso" id="ingresoDpiCuenta">
                    <center>
                        <img src="../resources/img/manager.svg" max-width="67px">
                        <h1 style="font-weight: 900;">Crear Cuenta</h1>
                        <div class="group">
                            <input type="text" required id="dpi" style="color: #EBEBEB !important;">
                            <span class="highlight"></span>
                            <span class="bar"></span>
                            <label for="dpi">DPI del dueño de la cuenta</label>
                        </div>
                        <button class="learn-more buttonEspecial" onclick="$('#contenedorMensaje2').show()">Validar</button>
                    </center>
                </div>
            </div>
            <div class="contenedorFlex" >
                <div class="ingreso" id="ingresoDpiCuenta" style="width: 70% !important;">
                    <center>
                        <h1 style="font-weight: 900;">Crear Cuenta</h1>
                        <p>Datos de dueño de cliente a corroborar e ingresar monto de apertura</p>
                        <table class="tablaDatos">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Nombre</th>
                                    <th>Sexo</th>
                                    <th>Telefono</th>
                                    <th>Direccion</th>
                                    <th>Fecha nacimiento</th>
                                    <th>DPI</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>######</td>
                                    <td>aaaaaa</td>
                                    <td>MMMMMM</td>
                                    <td>111111</td>
                                    <td>la cuarta avenida de alguna colonia de un lugar donde no entra la luz en los amaneceres</td>
                                    <td>####-##-##</td>
                                    <td><button class="buttonEspecial learn-more"  onclick="$('#contenedorMensaje3').show()">VER DPI</button></td>
                                </tr>
                            </tbody>
                        </table>
                        <div id="datosCuenta" style="display:none;">
                            <form>
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
                                <button class="learn-more buttonEspecial">Ingresar cuenta</button>
                            </form>
                        </div>
                        <button class="learn-more buttonEspecial" onclick="dpiCorrecto(this)">DPI correcto</button>
                    </center>
                </div>
            </div>
        </div>
    <center>
        <div id="contenedorMensaje" class="oculto" style="display:none;">
            <div id="contenedorInterior" class="mensaje2">
                <div style="padding: 2em;">
                    <img id="imagen" src="../resources/img/checkmark.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                    <h2 id="tituloMensaje" style="font-weight: 900;margin:0;">por defecto</h2><article id="articulo" style="display:inline-block;">asdjfaksjdlfkajsdlkfjalsdjflkasjdlkfjaskldjflasdfa</article>
                </div>
                <button class="learn-more buttonEspecial" onclick="document.getElementById('contenedorMensaje').style.display = 'none'">Cerrar</button>
            </div>
        </div>
        <div id="contenedorMensaje3" class="oculto" style="display:none;">
            <div id="contenedorInterior3" class="mensaje2">
                <center>
                    <h1>DPI de cliente .....</h1>
                    <embed src="https://www.w3docs.com/uploads/media/default/0001/01/540cb75550adf33f281f29132dddd14fded85bfc.pdf" width="80%" height="400px">
                    <br><button class="learn-more buttonEspecial" onclick="document.getElementById('contenedorMensaje3').style.display = 'none'">CERRAR</button>
                </center>
            </div>
        </div>
        <div id="contenedorMensaje2" class="oculto" style="display:none;overflow-y: scroll;">
            <div id="contenedorInterior2" class="mensaje2">
                <h1 style="font-weight: 900;">Crear Cliente</h1>
                <p>Dado que el cliente aún no está en el sistema, ingresa el siguiente formulario con sus datos</p>
                <form>
                    <div class="group">
                        <input type="text" id="dpiCliente" value="" disabled style="color: #EBEBEB !important;">
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="dpiCliente">DPI</label>
                    </div>
                    <div class="group">
                        <input type="text" id="nombreCliente" required style="color: #EBEBEB !important;" value="">
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="nombreCliente">Nombre</label>
                    </div>
                    <div class="group">
                        <input type="date" id="fechaCliente" required style="color: #EBEBEB !important;" value="2000-01-01">
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="fechaCliente">Fecha de nacimiento</label>
                    </div>
                    <div class="group">
                        <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="sexos">Sexo</label>
                        <br>
                        <select id="sexos" style="width:100%;">
                            <option value="M">Masculino</option>
                            <option value="F">Femenino</option>
                        </select>
                    </div>
                    <div class="group">
                        <input type="text" id="direccionCliente" required style="color: #EBEBEB !important;">
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="direccionCliente">Direccion</label>
                    </div>
                    <div style="width:100%;">
                        <label for="archivo" id="selectorArchivo" tabindex="0" class="input-file-trigger">Ingresa PDF de DPI...<img src="../resources/img/data_recovery.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                            <input type="file" id="archivo" accept=".pdf" onchange="verificar()" required></label>
                        <p id="ruta" class="file-return"></p>
                    </div>
                    <div class="group">
                        <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="sexos">¿Generar contraseña aleatoria?</label>
                        <br>
                        <select id="generar" onchange="generarPassword(this)" style="width:100%;">
                            <option value="N" selected>No</option>
                            <option value="S">Sí</option>
                        </select>
                    </div>
                    <div class="group" id="campoPassword">
                        <input type="password" id="passwordCliente" required style="color: #EBEBEB !important;">
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="passwordCliente">Contraseña</label>
                    </div>
                    <button class="learn-more buttonEspecial">Cerrar</button>
                </form>
            </div>
        </div> 
    </center>
    <script>
        function dpiCorrecto(boton) {
            boton.style.display = "none";
            $("#datosCuenta").fadeIn(1000);
            verMensaje("../resources/img/manager.svg", "El número de tu cuenta es #### y tu id de usuario CL-1231", "CUENTA INGRESADA");
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
</body>
<%@include file='footer.html' %>
</html>
