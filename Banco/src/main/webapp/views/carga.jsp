<%-- 
    Document   : carga
    Created on : 26/10/2020, 01:40:38 AM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banco de Guatemala</title>
    <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,700;0,800;1,300&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="../resources/css/cargar.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/oculto.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/styleTable.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/button2.css" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../resources/js/circulos.js"></script>
    <script type="text/javascript" src="../resources/js/cargar.js"></script>
    <script type="text/javascript" src="../resources/js/modificarEstadoBoton.js"></script>
</head>
<body>
    <div class="page-bg"></div>
    <div id="carga">
        <center>
            <img src="../resources/img/bank.png" width="7%" height="auto" id="logo">
            <br>
            <label for="logo" style="font-weight: bold; font-size: 2em;">Banco de Guatemala</label>
            <hr width="50%">
            <label for="archivo" id="selectorArchivo" tabindex="0" class="input-file-trigger">Seleccionar archivo XML
                con datos a cargar...<img src="../resources/img/data_recovery.svg" width="10%"
                    style="display: inline-block;vertical-align: middle;"></label>
            <p id="ruta" class="file-return"></p>
            <input type="file" id="archivo" accept=".xml" onchange="verificar()">
            <br>
            <div id="opciones" style="display: none;">
                <button class="learn-more" onclick="cambiarArchivo(this)">CAMBIAR ARCHIVO<img src="../resources/img/data_backup.svg"
                        width="10%" style="display: inline-block;vertical-align: middle;"></button>
                <button class="learn-more" onclick="loadDoc(this)" id="verificarDatos">VERIFICAR DATOS<img
                        src="../resources/img/search.svg" width="10%" style="display: inline-block;vertical-align: middle;"></button>
                <button class="learn-more"
                    onclick="verMensaje('Ingresando datos a base')"
                    style="display: none;" id="ingresarDatos">INGRESAR DATOS<img src="../resources/img/add_database.svg" width="10%"
                        style="display: inline-block;vertical-align: middle;"></button>
            </div>
        </center>
    </div>
    <div id="visualizar" style="display: none;">
        <div id='controladores'>
            <button class='selected' id="btn-con-iz" onclick="moverIzquierda()">
                <img src="../resources/img/cancel.svg" width="15%"
                    style="display: inline-block;vertical-align: middle;">ANTERIOR</button>
            <h1 id="h-controlador">GERENTES A INGRESAR</h1>
            <button class="learn-more" id="btn-con-de" onclick="moverDerecha()">SIGUIENTE<img src="../resources/img/next.svg"
                    width="15%" style="display: inline-block;vertical-align: middle;"></button>
        </div>
        <div id="tablas">
            <table class="table-fill tablas" id="gerentes">
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
            <table class="table-fill tablas" id="cajeros" style="display: none;">
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
            <table class="table-fill tablas" id="clientes" style="display: none;">
                <thead>
                    <tr>
                        <th>Codigo</th>
                        <th>Nombre</th>
                        <th>DPI</th>
                        <th>Fecha nacimiento</th>
                        <th>Direccion</th>
                        <th>Sexo</th>
                        <th>Contraseña</th>
                        <th>Cuentas</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>12345</td>
                        <td>Panchito de tal</td>
                        <td>1234567890123</td>
                        <td>2020-07-21</td>
                        <td>3ra calle 4-18 zona 1, San Lorenzo</td>
                        <td>Masculino</td>
                        <td>papitoremolino</td>
                        <td>
                            <center><button class="learn-more" onclick="verCuentas(this)">CUENTAS<img
                                        src="../resources/img/expand.svg" width="15%"
                                        style="display: inline-block;vertical-align: middle;"></button></center>
                            <table class="table-fill cuentas" style="display: none;">
                                <thead>
                                    <tr>
                                        <th>Cuenta</th>
                                        <th>Credito</th>
                                        <th>Fecha creación</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                    <tr>
                                        <td>Cuenta1</td>
                                        <td>1000.00</td>
                                        <td>04-10-2020</td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                        <td>SIN INGRESAR</td>
                    </tr>
                </tbody>
            </table>
            <table class="table-fill tablas" id="transacciones" style="display: none;">
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
                    <tr>
                        <td>15475</td>
                        <td>1111101</td>
                        <td>2020-01-12</td>
                        <td>16:15:25</td>
                        <td>Credito</td>
                        <td>156.75</td>
                        <td>15948711</td>
                        <td>SIN INGRESAR</td>
                    </tr>
                    <tr>
                        <td>15475</td>
                        <td>1111101</td>
                        <td>2020-01-12</td>
                        <td>16:15:25</td>
                        <td>Credito</td>
                        <td>156.75</td>
                        <td>15948711</td>
                        <td>SIN INGRESAR</td>
                    </tr>
                    <tr>
                        <td>15475</td>
                        <td>1111101</td>
                        <td>2020-01-12</td>
                        <td>16:15:25</td>
                        <td>Credito</td>
                        <td>156.75</td>
                        <td>15948711</td>
                        <td>SIN INGRESAR</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <hr width="30%">
        <div class="buttons" id="btn2">
            <div class="container">
                <a onclick="ingresarTodo(this)" class="effect01" target="_blank"><span>INGRESAR TODO</span></a>
            </div>
        </div>
        <center>
            <div id="botonsote">
                <center>
                    <div id="cargando" style="display: none;">
                        <div class="progress" id="pro"></div>
                        <label for="pro" id="actualSubiendo"></label>
                    </div>
                </center>
                <button id="ingresar-todo" onclick="ingresarTodo(this)" style="display: none;">INGRESAR TODO</button>
            </div>
        </center>
    </div>
    <center>
        <div id="contenedorMensaje" class="oculto" style="display:none;">
            <div id="contenedorInterior" class="mensaje2">
                <div style="padding: 0.5em;">
                    <img id="imagen" src="../resources/img/checkmark.svg" width="10%" style="display: none;vertical-align: middle;">
                    <h3 id="tituloMensaje" style="font-weight: bold;font-size: 1.5em; margin: 0;">por defecto</h3>
                </div>
                <center>
                    <div id="cargando">
                        <div class="progress" id="pro"></div>
                        <label for="pro" id="actualSubiendo">ingresando...</label>
                        <article id="articulo" style="display:inline-block;">
                            <span style="font-weight: bold;font-size: 1em;">ERRORES:</span>
                        </article>
                    </div>
                </center>
                <button class="learn-more" onclick="cerrandoFrame()">Cerrar</button>
            </div>
        </div>
    </center>
    <script>
        function verMensaje(titulo) {
            document.getElementById("tituloMensaje").textContent = titulo;
            $("#contenedorMensaje").fadeIn(1000);
            repetir();
        }

        function cerrandoFrame() {
            $("#contenedorMensaje").hide();
        }
        let timeout;
        var veces = 0;
        function repetir() {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                clearTimeout(timeout);
                if (veces < 15){
                    veces++;
                    var parrafo = document.createElement("p");
                    parrafo.innerText = "error "+veces;
                    var contenido = document.getElementById("articulo");
                    contenido.appendChild(parrafo);
                    repetir();
                }
            }, 1000);
        }
    </script>
</body>
</html>
