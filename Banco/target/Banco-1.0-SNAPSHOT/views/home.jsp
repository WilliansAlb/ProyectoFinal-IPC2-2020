<%-- 
    Document   : home.jsp
    Created on : 7/11/2020, 12:51:51 AM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>El Billeton</title>
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
        <title>Perfil</title><link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../resources/css/sidebar.css">
        <link rel="stylesheet" href="../resources/css/button2.css">
        <link rel="stylesheet" href="../resources/css/card.css">
        <link rel="stylesheet" href="../resources/css/home.css">
    </head>
    <body>
        <%HttpSession sesionHome = request.getSession();
        boolean correcto = false;
        if (sesionHome.getAttribute("tipo")!=null){
            correcto = true;
        } else {
            response.sendRedirect("login.jsp");
        }
        %>
        <%if (correcto){%>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida">
        </div>
    <center>
        <div class="bienvenida2">
            <h1>Bienvenido al portal del Banco El Billeton</h1>
            <h5>¿Qué deseas hacer?</h5>
        </div>
    </center>
    <div class="contenido">
        <div class="container">
            <%if (sesionHome.getAttribute("tipo").toString().equalsIgnoreCase("GERENTE")) {%>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/manager.svg">
                        <h3>Tu Perfil</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Ver tus datos o el historial de lo que has hecho</p>
                        <a href="datos.jsp">Ver datos</a>
                        <a href="acciones.jsp">Historial</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/add_database.svg">
                        <h3>Ingresar</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>¿Que deseas ingresar?</p>
                        <a href="crearCuenta.jsp">Nueva cuenta</a>
                        <a href="crearCajero.jsp">Nuevo trabajador</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/editar.svg">
                        <h3>Modificar</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>¿Que deseas modificar?</p>
                        <a href="modificarCliente.jsp">Cliente</a>
                        <a href="modificarCajero.jsp">Cajero</a>
                        <a href="datosGerente.jsp">Datos Personales</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/survey.svg">
                        <h3>Reportes</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Ver y exportar tus reportes</p>
                        <a href="reporte.jsp">Ir</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/settings.svg">
                        <h3>Ajustes</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Ajusta los limites y los horarios de los turnos</p>
                        <a href="configuracion.jsp">Ir</a>
                    </div>
                </div>
            </div>
            <%} else if (sesionHome.getAttribute("tipo").toString().equalsIgnoreCase("CLIENTE")) {%>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/manager.svg">
                        <h3>Tu Perfil</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Ver tus datos o el historial de las transacciones</p>
                        <a href="datos.jsp">Ver datos</a>
                        <a href="#.jsp">Ver cuentas</a>
                        <a href="#">Historial</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <center>
                            <img src="../resources/img/020-handshake.svg">
                            <h3>Asociaciones</h3>
                        </center>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>¿Que deseas hacer?</p>
                        <a href="asociar.jsp">Solicitar asociacion</a>
                        <a href="asociaciones.jsp">Ver solicitudes</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <center>
                            <img src="../resources/img/money_transfer.svg">
                            <h3>Transaccion</h3>
                        </center>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Realiza transacciones en banca virtual o cajero automatico</p>
                        <a href="configuracion.jsp">Transferir dinero</a>
                        <a href="retiroCliente.jsp">Cajero automatico</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/survey.svg">
                        <h3>Reportes</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Ver y exportar tus reportes</p>
                        <a href="#">Ir</a>
                    </div>
                </div>
            </div>
            <%} else if (sesionHome.getAttribute("tipo").toString().equalsIgnoreCase("CAJERO")) {%>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/manager.svg">
                        <h3>Tu Perfil</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Ver tus datos</p>
                        <a href="datos.jsp">Ver datos</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <center>
                            <img src="../resources/img/money_transfer.svg">
                            <h3>Transaccion</h3>
                        </center>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>¿Qué tipo de transacción harás?</p>
                        <a href="depositoCajero.jsp">Deposito</a>
                        <a href="retiroCajero.jsp">Retiro</a>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="face face1">
                    <div class="content">
                        <img src="../resources/img/survey.svg">
                        <h3>Reportes</h3>
                    </div>
                </div>
                <div class="face face2">
                    <div class="content">
                        <p>Ver y exportar tus reportes</p>
                        <a href="#">Ir</a>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
        <%}%>
</body>
</html>
