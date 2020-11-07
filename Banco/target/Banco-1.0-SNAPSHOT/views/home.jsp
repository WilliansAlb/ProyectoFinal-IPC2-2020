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
                <div class="card">
                    <div class="face face1">
                        <div class="content">
                            <img src="../resources/img/manager.svg">
                            <h3>Tus datos</h3>
                        </div>
                    </div>
                    <div class="face face2">
                        <div class="content">
                            <p>Verifica tus datos</p>
                            <a href="#">Ir</a>
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
                            <a href="#">Cuenta</a>
                            <a href="#">Cliente</a>
                            <a href="#">Cajero</a>
                            <a href="#">Gerente</a>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="face face1">
                        <div class="content">
                            <img src="../resources/img/editar_base.svg">
                            <h3>Modificar</h3>
                        </div>
                    </div>
                    <div class="face face2">
                        <div class="content">
                            <p>¿Que deseas modificar?</p>
                            <a href="#">Cliente</a>
                            <a href="#">Cajero</a>
                            <a href="#">Datos Personales</a>
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
                            <a href="#">Ir</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <footer>
        <center>
        <hr width="50%" style="border-top: 1px dotted red;">
        <p>Autor: Willians López</p>
        <p>Año 2020</p>
        </center>
    </footer> 
</html>
