<%-- 
    Document   : carga
    Created on : 26/10/2020, 01:40:38 AM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>El Billeton</title>
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../resources/css/cargar.css" type="text/css">
        <link rel="stylesheet" href="../resources/css/ocultoGeneral.css" type="text/css">
        <link rel="stylesheet" href="../resources/css/button2.css" type="text/css">
        <link rel="stylesheet" href="../resources/css/fondo.css" type="text/css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="../resources/js/circulos.js"></script>
        <script type="text/javascript" src="../resources/js/cargar.js"></script>
        <script type="text/javascript" src="../resources/js/modificarEstadoBoton.js"></script>
    </head>
    <body style="display: inline;margin: 0;">
        <div class="page-bg"></div>
        <div class="bienvenida"></div>
        <div id="carga">
            <center>
                <img src="../resources/img/033-savings.svg" width="7%" height="auto" id="logo">
                <br>
                <label for="logo" style="font-weight: 900; font-size: 2em;color: white;">Banco El Billeton</label>
                <hr width="50%">
                <label for="archivo" id="selectorArchivo" tabindex="0" class="input-file-trigger">Seleccionar archivo XML
                    con datos a cargar...<img src="../resources/img/data_recovery.svg" width="10%"
                                              style="display: inline-block;vertical-align: middle;"></label>
                <p id="ruta" class="file-return"></p>
                <form action="../archivo" method="POST" enctype="multipart/form-data" id="prueba1">
                    <input type="file" id="archivo" name="archivo" onchange="verificar()" webkitdirectory directory multiple>
                </form>
                <br>
                <div id="opciones" style="display: none;">
                    <button class="learn-more buttonEspecial" onclick="cambiarArchivo(this)">CAMBIAR ARCHIVO<img src="../resources/img/data_backup.svg"
                                                                                                                 width="10%" style="display: inline-block;vertical-align: middle;"></button>
                    <button class="learn-more buttonEspecial" onclick="loadDoc(this)" id="verificarDatos">VERIFICAR DATOS<img
                            src="../resources/img/search.svg" width="10%" style="display: inline-block;vertical-align: middle;"></button>
                    <button class="learn-more buttonEspecial"
                            onclick="verMensaje('Ingresando datos a base')"
                            style="display: none;" id="ingresarDatos">INGRESAR DATOS<img src="../resources/img/add_database.svg" width="10%" style="display: inline-block;vertical-align: middle;"></button>
                            <button class="learn-more buttonEspecial" onclick="mandarLogin()" style="display: none;" id="iniciarSesion">Inicio de sesión<img src="../resources/img/next.svg" width="10%" style="display: inline-block;vertical-align: middle;"></button>
                </div>
            </center>
        </div>
        <div id="visualizar" style="display: none;">
            <div id='controladores'>
                <button class='selected buttonEspecial' id="btn-con-iz" onclick="moverIzquierda()">
                    <img src="../resources/img/cancel.svg" width="15%"
                         style="display: inline-block;vertical-align: middle;">ANTERIOR</button>
                <h1 id="h-controlador">GERENTES A INGRESAR</h1>
                <button class="learn-more buttonEspecial" id="btn-con-de" onclick="moverDerecha()">SIGUIENTE<img src="../resources/img/next.svg"
                                                                                                                 width="15%" style="display: inline-block;vertical-align: middle;"></button>
            </div>
            <div id="tablas">
                <center>
                    <table class="tablaDatos tablas" id="gerentes" style="width: 95%;">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Turno</th>
                                <th>DPI</th>
                                <th>Direccion</th>
                                <th>Sexo</th>
                                <th>Password</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table class="tablaDatos tablas" id="cajeros" style="display: none; width: 95%;">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>Turno</th>
                                <th>DPI</th>
                                <th>Direccion</th>
                                <th>Sexo</th>
                                <th>Password</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table class="tablaDatos tablas" id="clientes" style="display: none; width: 95%;">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Nombre</th>
                                <th>DPI</th>
                                <th>PDF DPI</th>
                                <th>Fecha nacimiento</th>
                                <th>Direccion</th>
                                <th>Sexo</th>
                                <th>Contraseña</th>
                                <th>Cuentas</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table class="tablaDatos tablas" id="transacciones" style="display: none; width: 95%;">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Cuenta</th>
                                <th>Fecha</th>
                                <th>Hora</th>
                                <th>Tipo</th>
                                <th>Monto</th>
                                <th>Cajero</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </center>
            </div>
        </div>
    <center>
        <div id="contenedorMensaje" class="oculto" style="display:none;">
            <div id="contenedorInterior" class="mensaje2" style="background-color:#001a28">
                <div style="padding: 0.5em;">
                    <img id="imagen" src="../resources/img/checkmark.svg" width="10%" style="display: none;vertical-align: middle;">
                    <h3 id="tituloMensaje" style="font-weight: bold;font-size: 1.5em; margin: 0;color:white;">por defecto</h3>
                </div>
                <center>
                    <div id="cargando">
                        <div class="progress" id="pro"></div>
                        <label for="pro" id="actualSubiendo" style="color: grey;">ingresando...</label>
                    </div>
                    <div style="width:100%;overflow-y: scroll;display: none;" id="resumenContenedor">
                        <label for="resumen" style="color: grey;">RESUMEN</label>
                        <table id="resumen" style="text-align: center;" class="tablaDatos">
                            <thead>
                                <tr>
                                    <th>Ingresados</th>
                                    <th>Tabla</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div style="height:130px;width:100%;overflow-y: scroll;display:none;" id="historialContenedor">
                        <label for="historial" style="color:grey;">ERRORES</label>
                        <table id="historial" style="text-align: center;" class="tablaDatos">
                            <thead>
                                <tr>
                                    <th>Registro</th>
                                    <th>Estado</th>
                                    <th>Usuario</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </center>
                <p id="informar1" style="color:grey"></p>
                <div id="botonesIngresado" style="display:none;">
                    <button class="learn-more buttonEspecial" onclick="cerrandoFrame()">Revisar registros<img src="../resources/img/search.svg" width="10%" style="display: inline-block;vertical-align: middle;"></button>
                    <button class="learn-more buttonEspecial" onclick="mandarLogin()">Inicio de sesión<img src="../resources/img/next.svg" width="10%" style="display: inline-block;vertical-align: middle;"></button>
                </div>
            </div>
        </div>
    </center>
    <center>
        <div id="mostradorDPI" class="oculto" style="display:none;">
            <div id="contenedorEmbed" class="mensaje2">
                <div style="padding: 0.5em;">
                    <img id="imagen" src="../resources/img/document.svg" width="10%" style="display: none;vertical-align: middle;">
                    <h3 id="tituloMensaje2" style="font-weight: bold;font-size: 1.5em; margin: 0;">DPI de cliente </h3>
                    <embed src="" title="DPI" width="70%" height="400px" id="embeberDPI">
                </div>
                <br>
                <button class="learn-more buttonEspecial" onclick="cerrandoFrame1()">Cerrar</button>
            </div>
        </div>
    </center>
    <script>
        function cerrandoFrame1() {
            $("#mostradorDPI").hide();
        }
        function mandarLogin(){
            window.location = 'login.jsp';
        }
        let timeout;
        var veces = 0;
        function repetir() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                clearTimeout(timeout);
                if (veces < 15) {
                    veces++;
                    var parrafo = document.createElement("p");
                    parrafo.innerText = "error " + veces;
                    var contenido = document.getElementById("articulo");
                    contenido.appendChild(parrafo);
                    repetir();
                }
            }, 1000);
        }
    </script>
</body>
<%@include file='footer.html' %>
</html>
