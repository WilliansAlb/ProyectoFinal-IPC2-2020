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
    <a href="crearCuenta.jsp" class="w3-bar-item">Crear cuenta</a>
    <a href="crearCajero.jsp" class="w3-bar-item">Crear trabajador</a>
    <a href="modificarCliente.jsp" class="w3-bar-item">Modificar cliente</a>
    <a href="modificarCajero.jsp" class="w3-bar-item">Modificar cajero</a>
    <a href="configuracion.jsp" class="w3-bar-item">Configuracion</a>
    <a href="datosGerente.jsp" class="w3-bar-item">Ver datos</a>
    <a href="" class="w3-bar-item">Reportes</a>
    <%} else if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {%>
    <a href="#" class="w3-bar-item">Transferir dinero</a>
    <a href="#" class="w3-bar-item">Cajero automático</a>
    <a href="#" class="w3-bar-item">Solicitar asociación</a>
    <a href="#" class="w3-bar-item">Listar solicitudes de asociación</a>
    <a href="#" class="w3-bar-item">Historial de transacciones</a>
    <a href="#" class="w3-bar-item">Perfil</a>
    <%} else if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("CAJERO")) {%>
    <a href="AdminConsultas.jsp" class="w3-bar-item">Editar/crear tipos consultas</a>
    <a href="AdminExamenes.jsp" class="w3-bar-item">Editar/crear tipos examen</a>
    <a href="AdminMedicos.jsp" class="w3-bar-item">Editar/crear medico</a>
    <a href="AdminLaboratoristas.jsp" class="w3-bar-item">Editar/crear laboratorista</a>
    <a href="ReporteAdmin.jsp" class="w3-bar-item">Reportes</a>
    <a href="Perfil.jsp" class="w3-bar-item">Ver perfil</a>
    <%}%>
    <a href="/Banco/sesion?tipo=123" class="w3-bar-item">Cerrar sesión</a>
</div>

<div class="nav">
    <div class="w3-container">
        <div id="contenedor">
            <div id="izquierda">
                <button class="" id="menu" onclick="w3_open()">MENU<img src="../resources/img/bank.png" width="45em" height="auto" id="imagenHospital"></button>
                <label for="menu" id="nombreHospital">Banco "El Billeton"</label>
            </div>
            <div id="derecha">
                <div id="informacionPerfil">
                    <button class="boton1" id="boton1" onclick="mandarAPerfil()">
                        <img src="../resources/img/manager.svg" id="imagenUsuario" width="32em" height="auto">
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