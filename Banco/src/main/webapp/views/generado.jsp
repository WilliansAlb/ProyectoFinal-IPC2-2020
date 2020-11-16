<%-- 
    Document   : generado
    Created on : 16/11/2020, 05:20:10 AM
    Author     : yelbetto
--%>

<%@page import="DTO.TransaccionDTO"%>
<%@page import="DTO.CuentaDTO"%>
<%@page import="Base.CuentaDAO"%>
<%@page import="DTO.CajeroDTO"%>
<%@page import="DTO.ClienteDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ReporteDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte</title>
        <link rel="shortcut icon" type="image/x-icon" href="../resources/img/033-savings.svg" />
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@200;300;400;700&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../resources/css/sidebar.css">
        <link rel="stylesheet" href="../resources/css/button2.css">
        <link rel="stylesheet" href="../resources/css/input.css"/>
        <link rel="stylesheet" href="../resources/css/cargar.css"/>
        <link rel="stylesheet" href="../resources/css/creacion.css"/>
        <link rel="stylesheet" href="../resources/css/ocultoGeneral.css"/>
        <link rel="stylesheet" href="../resources/css/inputArchivo.css"/>
        <link rel="stylesheet" href="../resources/css/fondo.css"/>
        <script src="../resources/js/oculto.js" type="text/javascript"></script>
        <script src="../resources/js/configuracion.js" type="text/javascript"></script>
    </head>
    <body>
        <%@include file='sidebar.jsp'%>
        <div class="bienvenida"></div>
        <div class="crear">
            <div class="contenedorFlex">
                <div class="ingreso" style="width: 95%;">
                    <center>
                        <img src="../resources/img/survey.svg">
                        <h1 style="font-weight: 900; color: white;">Reporte generado</h1>
                        <%
                            Conector cn = new Conector("encender");
                            ReporteDAO reporte = new ReporteDAO(cn);
                            CuentaDAO cuentas = new CuentaDAO(cn);
                        %>
                        <div id="reporteG2">
                            <h2 style="font-weight: 900; color: white;">Clientes con transacciones monetarias mayores a un limite establecido</h2>
                            <%
                                ArrayList<ClienteDTO> clientes = reporte.clientesTransaccionesMayoresALimiteMenor();
                            %>
                            <table class="tablaDatos tablas" style="width:95%;text-align: center;">
                                <thead>
                                    <tr>
                                        <th>No. de transacciones</th>
                                        <th>Codigo</th>
                                        <th>Nombre</th>
                                        <th>DPI</th>
                                        <th>Sexo</th>
                                        <th>Direccion</th>
                                        <th>Fecha de nacimiento</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < clientes.size(); i++) {
                                            ClienteDTO temporal = clientes.get(i);
                                    %>
                                    <tr>
                                        <td><%out.print(temporal.getTransacciones());%></td>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getNombre());%></td>
                                        <td><%out.print(temporal.getDpi());%></td>
                                        <td><%out.print(temporal.getSexo());%></td>
                                        <td><%out.print(temporal.getDireccion());%></td>
                                        <td><%out.print(temporal.getFecha());%></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                        <div id="reporteG3">
                            <h2 style="font-weight: 900; color: white;">Clientes con transacciones monetarias sumadas mayores a un límite establecido</h2>
                            <%
                                ArrayList<ClienteDTO> clientes2 = reporte.clientesTransaccionesMayoresALimiteMayor();
                            %>
                            <table class="tablaDatos tablas" style="width:95%;text-align: center;">
                                <thead>
                                    <tr>
                                        <th>Sumatoria transacciones</th>
                                        <th>Codigo</th>
                                        <th>Nombre</th>
                                        <th>DPI</th>
                                        <th>Sexo</th>
                                        <th>Direccion</th>
                                        <th>Fecha de nacimiento</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < clientes2.size(); i++) {
                                            ClienteDTO temporal = clientes2.get(i);
                                    %>
                                    <tr>
                                        <td><%out.print(temporal.getMontoMayor());%></td>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getNombre());%></td>
                                        <td><%out.print(temporal.getDpi());%></td>
                                        <td><%out.print(temporal.getSexo());%></td>
                                        <td><%out.print(temporal.getDireccion());%></td>
                                        <td><%out.print(temporal.getFecha());%></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                        <div id="reporteG4">
                            <h2 style="font-weight: 900; color: white;">Los 10 clientes con más dinero en sus cuentas</h2>
                            <%
                                ArrayList<ClienteDTO> clientes3 = reporte.clientesConMásDineroEnCuentas();
                            %>

                            <table class="tablaDatos tablas" style="width:95%;text-align: center;">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Sumatoria dinero cuentas</th>
                                        <th>Codigo</th>
                                        <th>Nombre</th>
                                        <th>DPI</th>
                                        <th>Sexo</th>
                                        <th>Direccion</th>
                                        <th>Fecha de nacimiento</th>
                                        <th>Transacciones</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        for (int i = 0; i < clientes3.size(); i++) {
                                            ClienteDTO temporal = clientes3.get(i);
                                    %>
                                    <tr>
                                        <td><%out.print(i + 1);%></td>
                                        <td><%out.print(temporal.getMontoMayor());%></td>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getNombre());%></td>
                                        <td><%out.print(temporal.getDpi());%></td>
                                        <td><%out.print(temporal.getSexo());%></td>
                                        <td><%out.print(temporal.getDireccion());%></td>
                                        <td><%out.print(temporal.getFecha());%></td>
                                        <td><center>
                                    <table class="tablaDatos tablas" style="width:100%;">
                                        <thead>
                                            <tr>
                                                <th>Codigo</th>
                                                <th>Creacion</th>
                                                <th>Credito</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                ArrayList<CuentaDTO> cuenta = cuentas.obtenerCuentas(temporal.getCodigo());
                                                for (int x = 0; x < cuenta.size(); x++) {
                                                    CuentaDTO temporalCuenta = cuenta.get(x);
                                            %>
                                            <tr>
                                                <td><%out.print(temporalCuenta.getCodigo());%></td>
                                                <td><%out.print(temporalCuenta.getCreacion());%></td>
                                                <td><%out.print(temporalCuenta.getCredito());%></td>
                                            </tr>
                                            <%}%>
                                        </tbody>
                                    </table>
                                </center>
                                </td>
                                </tr>
                                <%}%>
                                </tbody>
                            </table>
                        </div>
                        <div id="reporteG7">
                            <h2 style="font-weight: 900; color: white;">Cajero que más transacciones ha realizado en un intervalo de tiempo</h2>
                            <%
                                ArrayList<CajeroDTO> cajeros = reporte.obtenerCajeroMasTransacciones("1998-11-11", "2020-11-16");
                            %>
                            <table class="tablaDatos tablas" style="width:95%;text-align: center;">
                                <thead>
                                    <tr>
                                        <th>No. de transacciones</th>
                                        <th>Codigo</th>
                                        <th>Nombre</th>
                                        <th>DPI</th>
                                        <th>Sexo</th>
                                        <th>Direccion</th>
                                        <th>Turno</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < cajeros.size(); i++) {
                                            CajeroDTO temporal = cajeros.get(i);
                                    %>
                                    <tr>
                                        <td><%out.print(temporal.getTotal());%></td>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getNombre());%></td>
                                        <td><%out.print(temporal.getDpi());%></td>
                                        <td><%out.print(temporal.getSexo());%></td>
                                        <td><%out.print(temporal.getDireccion());%></td>
                                        <td><%out.print(temporal.getTurno());%></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                        <div id="reporteC1">
                            <h2 style="font-weight: 900; color: white;">Cajero que más transacciones ha realizado en un intervalo de tiempo</h2>
                            <%
                                ArrayList<CuentaDTO> cuentasCliente = cuentas.obtenerCuentas(Long.parseLong("7874552312345"));
                            %>
                            <table class="tablaDatos tablas" style="width:95%;text-align: center;">
                                <thead>
                                    <tr>
                                        <th>No. de cuenta</th>
                                        <th>Credito</th>
                                        <th>Creada</th>
                                        <th>Transacciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < cuentasCliente.size(); i++) {
                                            CuentaDTO temporal = cuentasCliente.get(i);
                                    %>
                                    <tr>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getCredito());%></td>
                                        <td><%out.print(temporal.getCreacion());%></td>
                                        <td>
                                            <table class="tablaDatos tablas" style="width:100%;">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Codigo</th>
                                                        <th>Cajero</th>
                                                        <th>Monto</th>
                                                        <th>Creacion</th>
                                                        <th>Tipo</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        ArrayList<TransaccionDTO> tra = reporte.obtener15Transacciones(temporal.getCodigo());
                                                        for (int x = 0; x < tra.size(); x++) {
                                                            TransaccionDTO temporalTra = tra.get(x);
                                                    %>
                                                    <tr>
                                                        <td><%out.print(x);%></td>
                                                        <td><%out.print(temporalTra.getCodigo());%></td>
                                                        <td><%out.print(temporalTra.getCajero());%></td>
                                                        <td><%out.print(temporalTra.getMonto());%></td>
                                                        <td><%out.print(temporalTra.getCreacion());%></td>
                                                        <td><%out.print(temporalTra.getTipo());%></td>
                                                    </tr>
                                                    <%}%>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </center>
                </div>
            </div>
        </div>
    </body>
</html>
