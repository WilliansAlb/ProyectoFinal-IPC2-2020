<%-- 
    Document   : retiroCliente
    Created on : 12/11/2020, 03:53:52 AM
    Author     : yelbetto
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="DTO.CuentaDTO"%>
<%@page import="Base.Conector"%>
<%@page import="Base.CuentaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/bank.png" />
        <title>Crear Cuenta</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../resources/css/sidebar.css">
        <link rel="stylesheet" href="../resources/css/button2.css">
        <link rel="stylesheet" href="../resources/css/input.css"/>
        <link rel="stylesheet" href="../resources/css/creacion.css"/>
        <link rel="stylesheet" href="../resources/css/ocultoGeneral.css"/>
        <link rel="stylesheet" href="../resources/css/inputArchivo.css"/>
        <link rel="stylesheet" href="../resources/css/fondo.css"/>
        <script src="../resources/js/oculto.js" type="text/javascript"></script>
        <script src="../resources/js/creacion.js" type="text/javascript"></script>
    </head>
    <body>
        <%@include file='sidebar.jsp'%>
        <%
            HttpSession sesionRetiroCliente = request.getSession();
            Conector cn = new Conector("encender");
            CuentaDAO cuentas = new CuentaDAO(cn);
            ArrayList<CuentaDTO> listado = cuentas.obtenerCuentas(Integer.parseInt(sesionRetiroCliente.getAttribute("codigo").toString()));
        %>
        <div class="bienvenida"></div>
        <div id="contenedorCuenta" class="crear">
            <div class="contenedorFlex" id="buscarCliente">
                <div class="ingreso" id="ingresoDpiCuenta">
                    <center>
                        <img src="../resources/img/cajero-automatico.svg" max-width="67px">
                        <h1 style="font-weight: 900;color:white;">Cajero Automático</h1>
                        <p style="color:grey;">Se muestran tus cuentas, selecciona una para continuar con la transacción</p>
                        <table class="tablaDatos" width="95%">
                            <thead>
                                <tr>
                                    <th>CODIGO</th>
                                    <th>SALDO</th>
                                    <th>ASOCIADO</th>
                                    <th>FECHA DE CREACION</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%for (int i = 0; i < listado.size(); i++) {
                                        CuentaDTO temporal = listado.get(i);
                                %>
                                <tr>
                                    <td><%out.print(temporal.getCodigo());%></td>
                                    <td><%out.print(temporal.getCredito());%></td>
                                    <td>NO</td>
                                    <td><%out.print(temporal.getCreacion());%></td>
                                    <td><button class="learn-more buttonEspecial">ELEGIR CUENTA</button></td>
                                </tr>
                                <%}
                                %>

                            </tbody>
                        </table>
                    </center>
                </div>
            </div>
        </div>
    </body>
</html>
