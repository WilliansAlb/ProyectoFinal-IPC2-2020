<%-- 
    Document   : login
    Created on : 26/10/2020, 01:40:52 AM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Banco de Guatemala</title>
    <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,700;0,800;1,300&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" href="../resources/css/button2.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/oculto.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/PopUp.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/login.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/input.css" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../resources/js/modificarEstadoBoton.js"></script>
    <script type="text/javascript" src="../resources/js/newLogin.js"></script>
    <script type="text/javascript" src="../resources/js/oculto.js"></script>
</head>

<body>
    <div class="page-bg"></div>
    <div id='login'>
        <center>
            <div>
                <img name="hospital-img" src='../resources/img/bank.png' alt="imagen de un hospital" width="20%" height="auto"
                    id="logo"><br>
                    <label for="hospital-img" style="font-weight: bold; font-size: 1.8em;">Banco de Guatemala</label>
            </div>
            <div id="adentro">
                <div class="group">
                    <span class="popuptext" id="myPopup">Rellena este campo!</span>
                    <input type="text" onkeyup="comprobar()" required id="usuario" style="color: #EBEBEB !important;">
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label for="usuario2">Usuario</label>
                </div>
                <div class="group">
                    <span class="popuptext" id="myPopup1">Rellena este campo!</span>
                    <input type="password" onkeyup="comprobar()" required id="password" style="color: #EBEBEB !important;">
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label for="password">Contraseña</label>
                </div>
            </div>
            <div>
                <button id="ingresarCredenciales" class="selected" disabled onclick="verMensaje('../resources/img/checkmark.svg','articulo de prueba, acá puede ir un mensaje lo suficientemente grande como para ser la envidia de los libros del señor de los anillos','Mensaje de prueba')">INGRESAR
                <img src='../resources/img/cancel.svg' width='15%' style='display: inline-block;vertical-align: middle;'></button></center>
            </div>
        </center>
    </div>
    <center>
        <div id="contenedorMensaje" class="oculto" style="display:none;">
            <div id="contenedorInterior" class="mensaje2">
                <div style="padding: 2em;">
                    <img id="imagen" src="../resources/img/checkmark.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                    <h3 id="tituloMensaje" style="margin:0;">por defecto</h3><article id="articulo" style="display:inline-block;">asdjfaksjdlfkajsdlkfjalsdjflkasjdlkfjaskldjflasdfa</article>
                </div>
            <button class="learn-more" onclick="document.getElementById('contenedorMensaje').style.display = 'none'">Cerrar</button>
            </div>
        </div> 
    </center>
</body>
</html>
