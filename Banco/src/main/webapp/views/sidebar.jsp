<%-- 
    Document   : sidebar
    Created on : 7/11/2020, 12:52:13 AM
    Author     : yelbetto
--%>
<%
    HttpSession sInicio = request.getSession();
    if (sInicio.getAttribute("tipo") != null) {
%>
<div class="page-bg"></div>
<div class="w3-sidebar w3-bar-block" style="display:none" id="menuBar">
    <button onclick="w3_close()" class="boton">CERRAR &times;</button>
    <%
        if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("GERENTE")) {
    %>
    <a href="crearCuenta.jsp" class="w3-bar-item"><img src="../resources/img/add_database.svg" width="20%">Crear cuenta</a>
    <a href="crearCajero.jsp" class="w3-bar-item"><img src="../resources/img/add_database.svg" width="20%">Crear trabajador</a>
    <a href="modificarCliente.jsp" class="w3-bar-item"><img src="../resources/img/editar.svg" width="20%">Modificar cliente</a>
    <a href="modificarCajero.jsp" class="w3-bar-item"><img src="../resources/img/editar.svg" width="20%">Modificar cajero</a>
    <a href="configuracion.jsp" class="w3-bar-item"><img src="../resources/img/settings.svg" width="20%">Configuracion</a>
    <a href="acciones.jsp" class="w3-bar-item"><img src="../resources/img/017-tasks-2.svg" width="20%">Reporte de acciones</a>
    <a href="#" class="w3-bar-item"><img src="../resources/img/survey.svg" width="20%">Reportes</a>
    <%} else if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {%>
    <a href="transferencia.jsp" class="w3-bar-item"><img src="../resources/img/009-transfer.svg" width="20%">Transferir dinero</a>
    <a href="retiroCliente.jsp" class="w3-bar-item"><img src="../resources/img/cajero-automatico.svg" width="20%">Cajero automático</a>
    <a href="asociar.jsp" class="w3-bar-item"><img src="../resources/img/020-handshake.svg" width="20%">Solicitar asociación</a>
    <a href="asociaciones.jsp" class="w3-bar-item"><img src="../resources/img/conference_call.svg" width="20%">Solicitudes de asociación</a>
    <a href="cuentas.jsp" class="w3-bar-item"><img src="../resources/img/012-coin.svg" width="20%">Cuentas</a>
    <a href="transacciones.jsp" class="w3-bar-item"><img src="../resources/img/007-checkbook.svg" width="20%">Transacciones</a>
    <a href="#" class="w3-bar-item"><img src="../resources/img/survey.svg" width="20%">Reportes</a>
    <%} else if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("CAJERO")) {%>
    <a href="retiroCajero.jsp" class="w3-bar-item"><img src="../resources/img/013-profit.svg" width="20%">Retirar</a>
    <a href="depositoCajero.jsp" class="w3-bar-item"><img src="../resources/img/033-savings.svg" width="20%">Depositar</a>
    <a href="#" class="w3-bar-item"><img src="../resources/img/survey.svg" width="20%">Reportes</a>
    <%}%>
    <a href="datos.jsp" class="w3-bar-item"><img src="../resources/img/businessman.svg" width="20%">Datos personales</a>
    <a href="/Banco/sesion?tipo=123" class="w3-bar-item"><img src="../resources/img/export.svg" width="20%">Cerrar sesión</a>
</div>

<div class="nav">
    <div class="w3-container">
        <div id="contenedor">
            <div id="izquierda">
                <button class="" id="menu" onclick="w3_open()">MENU<img src="../resources/img/033-savings.svg" width="45em" height="auto" id="imagenHospital"></button>
                <label for="menu" id="nombreHospital">Banco "El Billeton"</label>
            </div>
            <div id="derecha">
                <div id="informacionPerfil">
                    <button class="boton1" id="boton1" onclick="mandarAPerfil()">
                        <img src="../resources/img/home.svg" id="imagenUsuario" width="32em" height="auto">
                        HOME
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function w3_open() {
        $("#menuBar").fadeIn(500);
    }

    function w3_close() {
        $("#menuBar").fadeOut(500);
    }
    function mandarAPerfil() {
        window.location = "home.jsp";
    }
</script>
<%}%>
