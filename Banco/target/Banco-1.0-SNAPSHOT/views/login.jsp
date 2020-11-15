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
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" href="../resources/css/button2.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/ocultoGeneral.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/PopUp.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/login.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/input.css" type="text/css">
    <link rel="stylesheet" href="../resources/css/fondo.css" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="../resources/js/modificarEstadoBoton.js"></script>
    <script type="text/javascript" src="../resources/js/newLogin.js"></script>
    <script type="text/javascript" src="../resources/js/oculto.js"></script>
</head>
<body style="overflow: hidden; margin: 0; padding:0;">
    <%
        HttpSession sesionLogin = request.getSession();
        if (sesionLogin.getAttribute("tipo")==null){
    %>
    <div class="page-bg"></div>
    <div class="bienvenida"></div>
<center>
    <div id='login'>
        <center>
            <div>
                <img name="hospital-img" src='../resources/img/bank.png' alt="imagen de un hospital" width="20%" height="auto"
                    id="logo"><br>
                    <label for="hospital-img" style="font-weight: bold; font-size: 1.3em;">Banco El Billeton</label>
                    <p style="width: 55%;font-size: 0.7em;color:grey;">Ingresa tus credenciales para poder acceder al sistema</p>
            </div>
            <div id="adentro">
                <div class="group" style="width: 55% !important;">
                    <span class="popuptext" id="myPopup">Rellena este campo!</span>
                    <input type="text" onchange="comprobar()" required id="usuario" style="color: #EBEBEB !important;">
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label for="usuario2">Usuario</label>
                </div>
                <div class="group" style="width: 55% !important;">
                    <span class="popuptext" id="myPopup1">Rellena este campo!</span>
                    <input type="password" onchange="comprobar()" required id="password" style="color: #EBEBEB !important;">
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label for="password">Contraseña</label>
                </div>
            </div>
            <div>
                <button id="ingresarCredenciales" class="selected buttonEspecial" disabled onclick="metodo($('#usuario').val(),$('#password').val())">INGRESAR
                <img src='../resources/img/cancel.svg' width='15%' style='display: inline-block;vertical-align: middle;'></button>
            </div>
        </center>
    </div>
</center>
    
    <center>
        <div id="contenedorMensaje" class="oculto" style="display:none;">
            <div id="contenedorInterior" class="mensaje2">
                <div style="padding: 2em;">
                    <img id="imagen" src="../resources/img/checkmark.svg" width="10%" style="display: inline-block;vertical-align: middle;">
                    <h3 id="tituloMensaje" style="margin:0;">por defecto</h3><article id="articulo" style="display:inline-block;">asdjfaksjdlfkajsdlkfjalsdjflkasjdlkfjaskldjflasdfa</article>
                </div>
            <button class="learn-more buttonEspecial" onclick="document.getElementById('contenedorMensaje').style.display = 'none'">Cerrar</button>
            </div>
        </div> 
    </center>
<%} else {
    response.sendRedirect("home.jsp");
}%>
</body>
</html>
