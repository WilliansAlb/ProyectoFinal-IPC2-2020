<%-- 
    Document   : modificarCliente
    Created on : 9/11/2020, 02:56:32 AM
    Author     : yelbetto
--%>

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
    </head>
    <body>
        <%@include file="sidebar.jsp"%>
        <div class="bienvenida">
        </div>
        <div id="contenedorModCajero" class="crear">
            <div class="contenedorFlex" id="busquedaCajero">
                <div class="ingreso" id="ingresoDpiCuenta" style="width:80%;">
                    <center>
                        <img src="../resources/img/clientes.svg">
                        <h1 style="font-weight: 900; color: white;">Clientes</h1>
                        <p style="color: grey;">Se muestran los clientes, puedes filtrarlos ingresando el codigo, dpi, o nombre</p>
                        <div class="group" style="width: 40%;">
                            <input type="text" id="busqueda" onkeyup="comprobar(this)" style="color: white;">
                            <span class="highlight"></span>
                            <span class="bar"></span>
                            <label for="busqueda">DPI/NOMBRE/CODIGO</label>
                        </div>   
                        <table class="tablaDatos tablas" id="cajeros" style="width: 95%;">
                            <thead>
                                <tr>
                                    <th>Codigo</th>
                                    <th>Nombre</th>
                                    <th>DPI</th>
                                    <th>Fecha de nacimiento</th>
                                    <th>Direccion</th>
                                    <th>Sexo</th>
                                    <th>Archivo DPI</th>
                                    <th>Editar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="clienteDatos">
                                    <td>12345</td>
                                    <td>Panchito de tal</td>
                                    <td>1234567890123</td>
                                    <td>2020-07-21</td>
                                    <td>3ra calle 4-18 zona 1, San Lorenzo</td>
                                    <td>Masculino</td>
                                    <td>
                                        <button class="learn-more buttonEspecial" style="width: 100%;">VER DPI<img src="../resources/img/search.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                    <td>
                                        <button class="learn-more buttonEspecial" onclick="rellenarDatos(this.parentNode)">EDITAR<img src="../resources/img/editar.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                </tr>
                                <tr class="clienteDatos">
                                    <td>123456</td>
                                    <td>Marcos Tux</td>
                                    <td>2222222190901</td>
                                    <td>2000-01-12</td>
                                    <td>4ta calle 1-10 zona 13, Guatemala</td>
                                    <td>Masculino</td>
                                    <td>
                                        <button class="learn-more buttonEspecial" style="width: 100%;">VER DPI<img src="../resources/img/search.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                    <td>
                                        <button class="learn-more buttonEspecial" onclick="rellenarDatos(this.parentNode)">EDITAR<img src="../resources/img/editar.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                </tr>
                                <tr class="clienteDatos">
                                    <td>123456</td>
                                    <td>Marcos Tux</td>
                                    <td>2222222190901</td>
                                    <td>2000-01-12</td>
                                    <td>4ta calle 1-10 zona 13, Guatemala</td>
                                    <td>Masculino</td>
                                    <td>
                                        <button class="learn-more buttonEspecial" style="width: 100%;">VER DPI<img src="../resources/img/search.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                    <td>
                                        <button class="learn-more buttonEspecial" onclick="rellenarDatos(this.parentNode)">EDITAR<img src="../resources/img/editar.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                </tr> </tbody>
                        </table>
                    </center>
                </div>
            </div>
            <div id="modificarCajero" class="contenedorFlex" style="display:none;">
                <div class="ingreso" id="ingresoCajero">
                    <center>
                        <img src="../resources/img/businessman.svg">
                        <h1 style="font-weight: 900; color: white;">Modificar cliente</h1>
                        <p style="color: grey;">Se muestran los datos del cliente seleccionado</p>
                        <form>
                            <div class="group">
                                <input type="text" id="codigo" onkeyup="guardarCambios(this)" class="deshabilitado" disabled style="color: grey;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="codigo">CODIGO</label>
                            </div>
                            <div class="group">
                                <input type="text" id="dpi" onkeyup="guardarCambios(this)" class="deshabilitado" disabled style="color: grey;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpi">DPI</label>
                            </div>
                            <div class="group">
                                <input type="text" id="nombre" onkeyup="guardarCambios(this)" required style="color: #EBEBEB !important;" value="">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="nombre">Nombre</label>
                            </div>
                            <div class="group">
                                <input type="date" id="fecha" onkeyup="guardarCambios(this)" required style="color: #EBEBEB !important;" value="2000-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha">Fecha de nacimiento</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="sexos">Sexo</label>
                                <br>
                                <select id="sexos" style="width:100%;" onchange="guardarCambios(this)">
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                            <div class="group">
                                <input type="text" id="direccion" onkeyup="guardarCambios(this)" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="direccion">Direccion</label>
                            </div>
                            <div style="width:100%;">
                                <label for="archivo" id="selectorArchivo" tabindex="0" class="input-file-trigger">Ingresa PDF de DPI...<img src="../resources/img/data_recovery.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                                    <input type="file" id="archivo" accept=".pdf" onchange="verificar()"></label>
                                <p id="ruta" class="file-return"></p>
                            </div>
                            <button class="learn-more buttonEspecial" id="guardarCambios2" onclick="cambios(this)">Cancelar</button>
                        </form>
                    </center>
                </div>
            </div>
        </div>
        <%@include file="footer.html" %>
        <script>
            function comprobar(input) {
                dejarDeEscribir(input);
            }

            let timeout;
            function dejarDeEscribir(input) {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    var trs = document.getElementsByClassName("clienteDatos");
                    for (let tr of trs) {
                        tr.style.display = "";
                    }
                    console.log(trs.length);
                    for (let tr of trs) {
                        if (input.value > 0) {
                            var codigo = tr.querySelectorAll("td")[0];
                            var dpi = tr.querySelectorAll("td")[3];
                            if (codigo.textContent.includes(input.value, 0) || dpi.textContent.includes(input.value, 0)) {
                                tr.style.display = "";
                            } else {
                                tr.style.display = "none";
                            }
                        } else {
                            var nombre = tr.querySelectorAll("td")[1];
                            if (nombre.textContent.toUpperCase().includes(input.value.toUpperCase(), 0)) {
                                tr.style.display = "";
                            } else {
                                tr.style.display = "none";
                            }
                        }
                    }
                    clearTimeout(timeout);
                }, 800);
            }
            function rellenarDatos(tr2) {
                var tr = tr2.parentNode;
                var codigo = tr.querySelectorAll("td")[0].textContent;
                var nombre = tr.querySelectorAll("td")[1].textContent;
                var dpi = tr.querySelectorAll("td")[2].textContent;
                var fecha = tr.querySelectorAll("td")[3].textContent;
                var direccion = tr.querySelectorAll("td")[4].textContent;
                var sexo = tr.querySelectorAll("td")[5].textContent;
                nombreC = nombre;
                direccionC = direccion;
                if (sexo.toUpperCase() === "MASCULINO") {
                    $("#sexos").val("M");
                    sexoC = "M";
                } else {
                    $("#sexos").val("F");
                    sexoC = "F";
                }
                $("#fecha").val(fecha);
                $("#codigo").val(codigo);
                $("#nombre").val(nombre);
                $("#dpi").val(dpi);
                $("#direccion").val(direccion);
                $("#busquedaCajero").hide();
                $("#modificarCajero").fadeIn(1000);
            }
            var nombreC;
            var turnoC;
            var sexoC;
            var direccionC;
            var fechaC;
            function guardarCambios(elemento) {
                var valor = elemento.value;
                var array = [nombreC, turnoC, sexoC, direccionC];
                var array2 = [$("#nombre").val(), $("#turnos").val(), $("#sexos").val(), $("#direccion").val()];
                var noExiste = false;
                for (let i = 0; i < array.length; i++) {
                    if (array[i] !== array2[i]) {
                        noExiste = true;
                        break;
                    }
                }
                if (noExiste) {
                    document.getElementById("guardarCambios2").textContent = "Guardar cambios";
                } else {
                    document.getElementById("guardarCambios2").textContent = "Cancelar";
                }
            }
            function cambios(boton) {
                var tipo = boton.value;
                if (tipo === "Guardar cambios") {

                } else {
                    $("#modificarCajero").hide(1000);
                    $("#busquedaCajero").fadeIn(2000);
                }
            }
            function verificar() {
                const file = document.getElementById("archivo").files[0];
                const file1 = document.getElementById("archivo");
                if (!file) {
                    alert("NECESITAS SELECCIONAR UN ARCHIVO XML PRIMERO");
                } else {
                    document.getElementById('ruta').innerText = ".." + file1.value.slice(12);
                    document.getElementById("verificarDatos").style.display = "";
                    document.getElementById("guardarCambios2").textContent = "Guardar cambios";
                }
            }
        </script>
    </body>
</html>
