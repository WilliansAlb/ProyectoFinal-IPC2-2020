<%-- 
    Document   : datosGerente
    Created on : 8/11/2020, 08:48:39 PM
    Author     : yelbetto
--%>

<%@page import="DTO.ClienteDTO"%>
<%@page import="Base.ClienteDAO"%>
<%@page import="DTO.CajeroDTO"%>
<%@page import="Base.CajeroDAO"%>
<%@page import="DTO.GerenteDTO"%>
<%@page import="Base.GerenteDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
        <title>Datos personales</title>
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
        <script src="../resources/js/modificacion.js" type="text/javascript"></script>
    </head>
    <body>
        <%@include file="sidebar.jsp"%>
        <div class="bienvenida">
        </div>
        <%
            HttpSession sesionModificarCliente = request.getSession();
            Conector cn = new Conector("encender");
            if (sesionModificarCliente.getAttribute("tipo").toString().equalsIgnoreCase("GERENTE")) {
                GerenteDAO gerentes = new GerenteDAO(cn);
                GerenteDTO gerente = gerentes.obteniendoDatosPersonales(Integer.parseInt(sesionModificarCliente.getAttribute("codigo").toString()));
        %>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" >
                <div class="ingreso" id="ingresoDpiCuenta">
                    <center>
                        <img src="../resources/img/businessman.svg">
                        <h1 style="font-weight: 900; color: white;">Tus datos</h1>
                        <p style="color: grey;">Se muestran los datos</p>
                        <form id="formModificacionGerente" action="../modificacion" method="POST">
                            <div class="group">
                                <input type="text" id="codigo" onkeyup="activarGuardarCambios(this)" class="deshabilitado" value="<%out.print(gerente.getCodigo());%>" disabled required>
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="codigo">Codigo</label>
                            </div>
                            <div class="group">
                                <input type="text" id="dpi" onkeyup="activarGuardarCambios(this)" class="deshabilitado" value="<%out.print(gerente.getDpi());%>" disabled required>
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpi">DPI</label>
                            </div>
                            <div class="group">
                                <input type="text" id="nombre" onkeyup="activarGuardarCambios(this)" required value="<%out.print(gerente.getNombre());%>" style="color: #EBEBEB !important;" value="">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="nombre">Nombre</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="turnos">Turno</label>
                                <br>
                                <select id="turnos" style="width:100%;" value="<%out.print(gerente.getTurno());%>" onchange="activarGuardarCambios(this)">
                                    <%if (gerente.getTurno().equalsIgnoreCase("M")) {%>
                                    <option value="M" selected>Matutino</option>
                                    <option value="V">Vespertino</option>
                                    <%} else {%>
                                    <option value="M">Matutino</option>
                                    <option value="V" selected>Vespertino</option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="sexos">Sexo</label>
                                <br>
                                <select id="sexos" style="width:100%;" value="<%out.print(gerente.getSexo());%>" onchange="activarGuardarCambios(this)">
                                    <%if (gerente.getSexo().equalsIgnoreCase("M")) {%>
                                    <option value="M" selected>Masculino</option>
                                    <option value="F">Femenino</option>
                                    <%} else {%>
                                    <option value="M">Masculino</option>
                                    <option value="F" selected>Femenino</option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="group">
                                <input type="text" id="direccion" value="<%out.print(gerente.getDireccion());%>" onkeyup="activarGuardarCambios(this)" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="direccion">Direccion</label>
                            </div>
                            <button class="selected buttonEspecial" disabled id="guardarCambios" style="font-weight: inherit !important;">GUARDAR CAMBIOS<img src="../resources/img/cancel.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
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
                </div>
                <button class="learn-more buttonEspecial" onclick="cerrar(this)" id="cerrarRedirigir">CERRAR</button>
            </div>
        </div>
    </center>
    <script>
        var nombre = $("#nombre").val();
        var turno = $("#turnos").val();
        var sexo = $("#sexos").val();
        var direccion = $("#direccion").val();
        function cerrar(boton) {
            if (boton.textContent === 'OK') {
                window.location = "datos.jsp";
            } else {
                var contenedor = boton.parentNode;
                var contenedor2 = contenedor.parentNode;
                contenedor2.style.display = 'none';
            }
        }
        function activarGuardarCambios() {
            var array = [nombre, turno, sexo, direccion];
            var array2 = [$("#nombre").val(), $("#turnos").val(), $("#sexos").val(), $("#direccion").val()];
            var noExiste = false;
            for (let i = 0; i < array.length; i++) {
                if (array[i] !== array2[i]) {
                    noExiste = true;
                    break;
                }
            }
            console.log(array[0]);
            if (noExiste) {
                activarBoton(document.getElementById("guardarCambios"), "../resources/img/safe.svg");
            } else {
                bloquearBoton(document.getElementById("guardarCambios"));
            }
        }
        function actualizarFormulario() {
            var nombre = $("#nombre").val();
            var turno = $("#turnos").val();
            var sexos = $("#sexos").val();
            var direccion = $("#direccion").val();
            nombreC = nombre;
            turnoC = turno;
            sexoC = sexos;
            direccionC = direccion;
            bloquearBoton(document.getElementById("guardarCambios"));
        }
    </script>                     
    <%} else if (sesionModificarCliente.getAttribute("tipo").toString().equalsIgnoreCase("CAJERO")) {
        CajeroDAO cajeros = new CajeroDAO(cn);
        CajeroDTO cajero = cajeros.obteniendoDatosPersonales(Integer.parseInt(sesionModificarCliente.getAttribute("codigo").toString()));
        String sexo = "Masculino";
        String turno = "Matutino";
    %>
    <div id="contenedorCuenta" class="crear">
        <div class="contenedorFlex" >
            <div class="ingreso" id="ingresoDpiCuenta">
                <center>
                    <img src="../resources/img/businessman.svg">
                    <h1 style="font-weight: 900; color: white;">Tus datos</h1>
                    <p style="color: grey;">Se muestran los datos</p>
                    <div class="group">
                        <input type="text" id="id" class="deshabilitado inputCentrado" value="<%out.print(sesionModificarCliente.getAttribute("id").toString());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="id" class="labelCentrado">Usuario</label>
                    </div>
                    <div class="group">
                        <input type="text" id="codigo" class="deshabilitado inputCentrado" value="<%out.print(cajero.getCodigo());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="codigo" class="labelCentrado">Codigo</label>
                    </div>
                    <div class="group">
                        <input type="text" id="dpi" class="deshabilitado inputCentrado" value="<%out.print(cajero.getDpi());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="dpi" class="labelCentrado">DPI</label>
                    </div>
                    <div class="group">
                        <input type="text" id="nombre" class="deshabilitado inputCentrado" value="<%out.print(cajero.getNombre());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="nombre" class="labelCentrado">Nombre</label>
                    </div>
                    <div class="group">
                        <%
                            if (cajero.getTurno().equalsIgnoreCase("M")) {
                                turno = "Matutino";
                            } else {
                                turno = "Vespertino";
                            }
                        %>
                        <input type="text" id="turno" class="deshabilitado inputCentrado" value="<%out.print(turno);%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="turno" class="labelCentrado">Turno</label>
                    </div>
                    <div class="group">
                        <%
                            if (cajero.getSexo().equalsIgnoreCase("M")) {
                                sexo = "Masculino";
                            } else {
                                sexo = "Femenino";
                            }
                        %>
                        <input type="text" id="sexo" class="deshabilitado inputCentrado" value="<%out.print(sexo);%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="sexo" class="labelCentrado">Sexo</label>
                    </div>
                    <div class="group">
                        <input type="text" id="direccion" class="deshabilitado inputCentrado" value="<%out.print(cajero.getDireccion());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="direccion" class="labelCentrado">Direccion</label>
                    </div>
                </center>
            </div>
        </div>
    </div>
    <%} else if (sesionModificarCliente.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {
        ClienteDAO clientes = new ClienteDAO(cn);
        ClienteDTO cliente = clientes.obtenerClienteConCodigo(Integer.parseInt(sesionModificarCliente.getAttribute("codigo").toString()));
        String sexo = "Masculino";
    %>
    <div id="contenedorCuenta" class="crear">
        <div class="contenedorFlex" >
            <div class="ingreso" id="ingresoDpiCuenta">
                <center>
                    <img src="../resources/img/businessman.svg">
                    <h1 style="font-weight: 900; color: white;">Tus datos</h1>
                    <p style="color: grey;">Se muestran los datos</p>
                    <div class="group">
                        <input type="text" id="id" class="deshabilitado inputCentrado" value="<%out.print(sesionModificarCliente.getAttribute("id").toString());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="id" class="labelCentrado">Usuario</label>
                    </div>
                    <div class="group">
                        <input type="text" id="codigo" class="deshabilitado inputCentrado" value="<%out.print(cliente.getCodigo());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="codigo" class="labelCentrado">Codigo</label>
                    </div>
                    <div class="group">
                        <input type="text" id="dpi" class="deshabilitado inputCentrado" value="<%out.print(cliente.getDpi());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="dpi" class="labelCentrado">DPI</label>
                    </div>
                    <div class="group">
                        <input type="text" id="nombre" class="deshabilitado inputCentrado" value="<%out.print(cliente.getNombre());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="nombre" class="labelCentrado">Nombre</label>
                    </div>
                    <div class="group">
                        <input type="text" id="nacimiento" class="deshabilitado inputCentrado" value="<%out.print(cliente.getFecha());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="nacimiento" class="labelCentrado">Fecha de nacimiento</label>
                    </div>
                    <div class="group">
                        <%
                            if (cliente.getSexo().equalsIgnoreCase("M")) {
                                sexo = "Masculino";
                            } else {
                                sexo = "Femenino";
                            }
                        %>
                        <input type="text" id="sexo" class="deshabilitado inputCentrado" value="<%out.print(sexo);%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="sexo" class="labelCentrado">Sexo</label>
                    </div>
                    <div class="group">
                        <input type="text" id="direccion" class="deshabilitado inputCentrado" value="<%out.print(cliente.getDireccion());%>" disabled>
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="direccion" class="labelCentrado">Direccion</label>
                    </div>
                </center>
            </div>
        </div>
    </div>
    <%}%>
</body>
<%@include file='footer.html' %>
</html>
