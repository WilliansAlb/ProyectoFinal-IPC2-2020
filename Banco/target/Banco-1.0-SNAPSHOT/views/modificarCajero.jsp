<%-- 
    Document   : modificarCajero
    Created on : 8/11/2020, 09:19:26 PM
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
                        <img src="../resources/img/030-team.svg">
                        <h1 style="font-weight: 900; color: white;">Cajeros</h1>
                        <p style="color: grey;">Se muestran los cajeros, puedes filtrar los cajeros ingresando el codigo, dpi, o nombre</p>
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
                                    <th>Turno</th>
                                    <th>DPI</th>
                                    <th>Direccion</th>
                                    <th>Sexo</th>
                                    <th>Editar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="cajerosDatos"><td>123456</td><td>Carlos Perez</td><td>MATUTINO</td><td>1111111190901</td><td>4ta calle 1-10 zona 13, Guatemala</td><td>Masculino</td>
                                    <td><button class="learn-more buttonEspecial" onclick="rellenarCajero(this.parentNode)">EDITAR</button></td></tr>
                                <tr class="cajerosDatos"><td>654321</td><td>Juan Gonzalez</td><td>MATUTINO</td><td>2222222222222</td><td>4ta calle 1-10 zona 13, Guatemala</td><td>Masculino</td>
                                    <td><button class="learn-more buttonEspecial" onclick="rellenarCajero(this.parentNode)">EDITAR</button></td></tr>
                                <tr class="cajerosDatos"><td>891234</td><td>Pedro Perez</td><td>MATUTINO</td><td>333333333333</td><td>4ta calle 1-10 zona 13, Guatemala</td><td>Masculino</td>
                                    <td><button class="learn-more buttonEspecial" onclick="rellenarCajero(this.parentNode)">EDITAR</button></td></tr>
                            </tbody>
                        </table>
                    </center>
                </div>
            </div>
            <div id="modificarCajero" class="contenedorFlex" style="display:none;">
                <div class="ingreso" id="ingresoCajero">
                    <center>
                        <img src="../resources/img/businessman.svg">
                        <h1 style="font-weight: 900; color: white;">Modificar cajero</h1>
                        <p style="color: grey;">Se muestran los datos del cajero seleccionado</p>
                        <form>
                            <div class="group">
                                <input type="text" id="codigo" onkeyup="guardarCambios(this)" class="deshabilitado" value="1234543" disabled required>
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="codigo">Codigo</label>
                            </div>
                            <div class="group">
                                <input type="text" id="dpi" onkeyup="guardarCambios(this)" class="deshabilitado" value="1832048181007" disabled required>
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpi">DPI</label>
                            </div>
                            <div class="group">
                                <input type="text" id="nombre" onkeyup="guardarCambios(this)" required value="juan" style="color: #EBEBEB !important;" value="">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="nombre">Nombre</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="turnos">Turno</label>
                                <br>
                                <select id="turnos" style="width:100%;" onchange="guardarCambios(this)">
                                    <option value="M">Matutino</option>
                                    <option value="V">Vespertino</option>
                                </select>
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
                    var trs = document.getElementsByClassName("cajerosDatos");
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
            function rellenarCajero(tr2) {
                var tr = tr2.parentNode;
                var codigo = tr.querySelectorAll("td")[0].textContent;
                var nombre = tr.querySelectorAll("td")[1].textContent;
                var dpi = tr.querySelectorAll("td")[3].textContent;
                var turno = tr.querySelectorAll("td")[2].textContent;
                var direccion = tr.querySelectorAll("td")[4].textContent;
                var sexo = tr.querySelectorAll("td")[5].textContent;
                nombreC = nombre;
                direccionC = direccion;
                if (turno.toUpperCase() === "MATUTINO") {
                    $("#turnos").val("M");
                    sexoC = "M";
                } else {
                    $("#turnos").val("V");
                    sexoC = "V";
                }

                if (sexo.toUpperCase() === "MASCULINO") {
                    $("#sexos").val("M");
                    turnoC = "M";
                } else {
                    $("#sexos").val("F");
                    turnoC = "F";
                }
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
                    $("#busquedaCajero").fadeIn();
                }
            }
        </script>
    </body>
</html>
