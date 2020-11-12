<%-- 
    Document   : modificarCliente
    Created on : 9/11/2020, 02:56:32 AM
    Author     : yelbetto
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DTO.ClienteDTO"%>
<%@page import="Base.ClienteDAO"%>
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
            ClienteDAO clientes = new ClienteDAO(cn);
            ArrayList<ClienteDTO> cliente = clientes.obtenerClientes();
        %>
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
                                <%for (int i = 0; i < cliente.size(); i++) {
                                        ClienteDTO temporal = cliente.get(i);
                                %>
                                <tr class="clienteDatos">
                                    <td><%out.print(temporal.getCodigo());%></td>
                                    <td><%out.print(temporal.getNombre());%></td>
                                    <td><%out.print(temporal.getDpi());%></td>
                                    <td><%out.print(temporal.getFecha());%></td>
                                    <td><%out.print(temporal.getDireccion());%></td>
                                    <td><%out.print(temporal.getSexo());%></td>
                                    <td>
                                        <button class="learn-more buttonEspecial" style="width: 100%;font-weight: 300;" value="<%out.print(temporal.getDpi());%>" onclick="visualizarDPI(this)">VER DPI<img src="../resources/img/search.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                    <td>
                                        <button class="learn-more buttonEspecial" style="font-weight: 300;" onclick="rellenarDatos(this.parentNode)">EDITAR<img src="../resources/img/editar.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button>
                                    </td>
                                </tr> 
                                <%
                                    }
                                %>
                            </tbody>
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
                        <form id="formModificacionCliente" method="POST" action="../modificacion" enctype="multipart/form-data">
                            <div class="group">
                                <input type="text" id="codigo" name="codigo" onkeyup="guardarCambios()" class="deshabilitado" disabled style="color: grey;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="codigo">CODIGO</label>
                            </div>
                            <div class="group">
                                <input type="text" id="dpi" name="dpi" onkeyup="guardarCambios()" class="deshabilitado" disabled style="color: grey;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="dpi">DPI</label>
                            </div>
                            <div class="group">
                                <input type="text" id="nombre" name="nombre" onkeyup="guardarCambios()" required style="color: #EBEBEB !important;" value="">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="nombre">Nombre</label>
                            </div>
                            <div class="group">
                                <input type="date" id="fecha" name="fecha" onchange="guardarCambios()" required style="color: #EBEBEB !important;" value="2000-01-01">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="fecha">Fecha de nacimiento</label>
                            </div>
                            <div class="group">
                                <label  style="top: -20px;font-size: 1em;color: #5264AE;" for="sexos">Sexo</label>
                                <br>
                                <select id="sexos" style="width:100%;" name="sexo" onchange="guardarCambios()">
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                            <div class="group">
                                <input type="text" id="direccion" name="direccion" onkeyup="guardarCambios()" required style="color: #EBEBEB !important;">
                                <span class="highlight"></span>
                                <span class="bar"></span>
                                <label for="direccion">Direccion</label>
                            </div>
                            <div style="width:100%;">
                                <label for="archivo" id="selectorArchivo" tabindex="0" class="input-file-trigger">Ingresa PDF de DPI...<img src="../resources/img/data_recovery.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                                    <input type="file" id="archivo" name="archivo" accept=".pdf" onchange="verificar()"></label>
                                <p id="ruta" class="file-return"></p>
                            </div>
                            <button class="learn-more buttonEspecial" id="guardarCambios2" onclick="cambios(this)">Cancelar</button>
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
        <div id="contenedorMensaje3" class="oculto" style="display:none;">
            <div id="contenedorInterior3" class="mensaje2" style="background-color: #001a28;">
                <h1 id="informando1" style="color: white;">DPI de cliente .....</h1>
                <embed src="" width="80%" height="400px" id="visorPDF">
                <br><button class="learn-more buttonEspecial" onclick="cerrar(this)">CERRAR</button>
            </div>
        </div>
    </center>
    <%@include file="footer.html" %>
    <script>
        function comprobar(input) {
            dejarDeEscribir(input);
        }
        function cerrar(boton) {
            if (boton.textContent === 'OK') {
                window.location = "modificarCliente.jsp";
            } else {
                var con = boton.parentNode;
                var con2 = con.parentNode;
                con2.style.display = "none";
            }
        }
        let timeout;
        function dejarDeEscribir(input) {
            clearTimeout(timeout);
            timeout = setTimeout(() => {
                var trs = document.getElementsByClassName("clienteDatos");
                for (let tr of trs) {
                    tr.style.display = "";
                }
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
            if (sexo.toUpperCase() === "M") {
                $("#sexos").val("M");
                sexoC = "M";
            } else {
                $("#sexos").val("F");
                sexoC = "F";
            }
            fechaC = fecha;
            $("#fecha").val(fecha);
            $("#codigo").val(codigo);
            $("#nombre").val(nombre);
            $("#dpi").val(dpi);
            $("#direccion").val(direccion);
            $("#busquedaCajero").hide();
            $("#modificarCajero").fadeIn(1000);
        }
        var nombreC;
        var sexoC;
        var direccionC;
        var fechaC;
        var archivoSubido = false;

        function guardarCambios() {
            var array = [nombreC, fechaC, sexoC, direccionC];
            var array2 = [$("#nombre").val(), $("#fecha").val(), $("#sexos").val(), $("#direccion").val()];
            var noExiste = false;
            for (let i = 0; i < array.length; i++) {
                if (array[i] !== array2[i]) {
                    noExiste = true;
                    break;
                }
            }
            if (noExiste || archivoSubido) {
                document.getElementById("guardarCambios2").textContent = "GUARDAR CAMBIOS";
            } else {
                document.getElementById("guardarCambios2").textContent = "CANCELAR";
            }
        }
        function verificar() {
            const file1 = document.getElementById("archivo");
            document.getElementById("guardarCambios2").textContent = "GUARDAR CAMBIOS";
            archivoSubido = true;
            document.getElementById('ruta').innerText = ".." + file1.value.slice(12);
            document.getElementById("verificarDatos").style.display = "";
        }
    </script>
</body>
</html>
