<%-- 
    Document   : generado
    Created on : 16/11/2020, 05:20:10 AM
    Author     : yelbetto
--%>

<%@page import="DTO.ConfiguracionDTO"%>
<%@page import="Base.ConfiguracionDAO"%>
<%@page import="DTO.BalanceDTO"%>
<%@page import="Base.TransaccionDAO"%>
<%@page import="DTO.AsociacionDTO"%>
<%@page import="Base.AsociacionDAO"%>
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
        <title>Reporte generado</title>
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
        <%
            HttpSession s = request.getSession();
            boolean correcto = false;
            if (s.getAttribute("tipo") != null) {
                if (s.getAttribute("reporte") != null) {
                    correcto = true;
                } else {
                    response.sendRedirect("reporte.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
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
                            AsociacionDAO asociaciones = new AsociacionDAO(cn);
                            TransaccionDAO transacciones = new TransaccionDAO(cn);
                            ConfiguracionDAO settings = new ConfiguracionDAO(cn);
                            if (correcto) {
                                String t = s.getAttribute("tipo").toString();
                                String codigo = s.getAttribute("codigo").toString();
                                String rep = s.getAttribute("reporte").toString();
                                s.setAttribute("reporte", null);
                                s.removeAttribute("reporte");
                                if (t.equalsIgnoreCase("GERENTE")) {
                                    if (rep.equalsIgnoreCase("G2")) {
                        %>
                        <div id="reporteG2">
                            <%
                                ConfiguracionDTO sett = settings.obtenerConfiguracion();
                                Double limite_menor = sett.getLimite_menor();
                            %>
                            <h2 style="font-weight: 900; color: white;">Clientes con transacciones monetarias mayores a <%out.print(limite_menor);%></h2>
                            <%
                                ArrayList<ClienteDTO> clientes = reporte.clientesTransaccionesMayoresALimiteMenor();
                                if (clientes.size() > 0) {
                            %>
                            <a href="../reporte?tipo=G2" download="reporteLimiteMenor.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
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
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("G3")) {%>
                        <div id="reporteG3">
                            <%
                                ConfiguracionDTO sett = settings.obtenerConfiguracion();
                                Double limite_mayor = sett.getLimite_mayor();
                            %>
                            <h2 style="font-weight: 900; color: white;">Clientes con transacciones monetarias sumadas mayores a un límite establecido <%out.print(limite_mayor);%></h2>
                            <%
                                ArrayList<ClienteDTO> clientes2 = reporte.clientesTransaccionesMayoresALimiteMayor();
                                if (clientes2.size() > 0) {
                            %>
                            <a href="../reporte?tipo=G3" download="reporteLimiteMayor.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
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
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("G4")) {%>
                        <div id="reporteG4">
                            <h2 style="font-weight: 900; color: grey;">Los 10 clientes con más dinero en sus cuentas</h2>
                            <%
                                ArrayList<ClienteDTO> clientes3 = reporte.clientesConMásDineroEnCuentas();
                                if (clientes3.size() > 0) {
                            %>
                            <a href="../reporte?tipo=G4" download="reporte10cuentas.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
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
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("G5")) {%>
                        <%
                            String fecha1 = s.getAttribute("fecha1").toString();
                            String fecha2 = s.getAttribute("fecha2").toString();
                            s.setAttribute("fecha1", null);
                            s.setAttribute("fecha2", null);
                            s.removeAttribute("fecha1");
                            s.removeAttribute("fecha2");
                        %>
                        <div id="reporteG5">
                            <h2 style="font-weight: 900; color: white;">Clientes sin transacciones entre <%out.print(fecha1);%> y <%out.print(fecha2);%></h2>
                            <%
                                ArrayList<ClienteDTO> clientesG5 = reporte.clientesSinTransaccionesIntervalo(fecha1, fecha2);
                                if (clientesG5.size() > 0) {
                            %>
                            <a href="../reporte?tipo=G5&fecha1=<%out.print(fecha1);%>&fecha2=<%out.print(fecha2);%>" download="reporteClientesSin.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
                            <table class="tablaDatos tablas" style="width:95%;text-align: center;">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Codigo</th>
                                        <th>Nombre</th>
                                        <th>DPI</th>
                                        <th>Sexo</th>
                                        <th>Direccion</th>
                                        <th>Fecha de nacimiento</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < clientesG5.size(); i++) {
                                            ClienteDTO temporal = clientesG5.get(i);
                                    %>
                                    <tr>
                                        <td><%out.print(i + 1);%></td>
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

                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("G7")) {%>
                        <%
                            String fecha1 = s.getAttribute("fecha1").toString();
                            String fecha2 = s.getAttribute("fecha2").toString();
                            s.setAttribute("fecha1", null);
                            s.setAttribute("fecha2", null);
                            s.removeAttribute("fecha1");
                            s.removeAttribute("fecha2");
                        %>
                        <div id="reporteG7">
                            <h2 style="font-weight: 900; color: white;">Cajero que más transacciones ha realizado en un intervalo de tiempo <%out.print(fecha1);%> y <%out.print(fecha2);%></h2>
                            <%
                                ArrayList<CajeroDTO> cajeros = reporte.obtenerCajeroMasTransacciones(fecha1, fecha2);
                                if (cajeros.size() > 0) {
                            %>
                            <a href="../reporte?tipo=G7&fecha1=<%out.print(fecha1);%>&fecha2=<%out.print(fecha2);%>" download="reporteCajerosMas.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
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
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>

                        </div>
                        <%
                            }
                        } else if (t.equalsIgnoreCase("CAJERO")) {
                            if (rep.equalsIgnoreCase("CA2")) {
                        %>
                        <%
                            String fecha1 = s.getAttribute("fecha1").toString();
                            String fecha2 = s.getAttribute("fecha2").toString();
                            s.setAttribute("fecha1", null);
                            s.setAttribute("fecha2", null);
                            s.removeAttribute("fecha1");
                            s.removeAttribute("fecha2");
                        %>
                        <div id="reporteCA2">
                            <h2 style="font-weight: 900; color: white;">Listado de las transacciones realizadas por día en un intervalo de tiempo, mostrando el balance final</h2>
                            <%
                                ArrayList<BalanceDTO> balances = reporte.obtenerBalanceFinal(Long.parseLong(codigo), fecha1, fecha2);
                                if (balances.size() > 0) {
                            %>

                            <a href="../reporte?tipo=CA2&fecha1=<%out.print(fecha1);%>&fecha2=<%out.print(fecha2);%>" download="reporteBalance.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
                            <table class="tablaDatos tablas" style="width:95%;text-align: center;">
                                <thead>
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Balance</th>
                                        <th>Deposito</th>
                                        <th>Retiro</th>
                                        <th>Transacciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < balances.size(); i++) {
                                            BalanceDTO temporal = balances.get(i);
                                    %>
                                    <tr>
                                        <td><%out.print(temporal.getFecha());%></td>
                                        <td><%out.print(temporal.getBalance());%></td>
                                        <td><%out.print(temporal.getDeposito());%></td>
                                        <td><%out.print(temporal.getRetiro());%></td>
                                        <td><table class="tablaDatos tablas" style="width:100%;">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Codigo</th>
                                                        <th>Monto</th>
                                                        <th>Cuenta</th>
                                                        <th>Creacion</th>
                                                        <th>Tipo</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        ArrayList<TransaccionDTO> tra = temporal.getTransacciones();
                                                        for (int x = 0; x < tra.size(); x++) {
                                                            TransaccionDTO temporalTra = tra.get(x);
                                                    %>
                                                    <tr>
                                                        <td><%out.print(x + 1);%></td>
                                                        <td><%out.print(temporalTra.getCodigo());%></td>
                                                        <td><%out.print(temporalTra.getMonto());%></td>
                                                        <td><%out.print(temporalTra.getCuenta());%></td>
                                                        <td><%out.print(temporalTra.getCreacion());%></td>
                                                        <td><%out.print(temporalTra.getTipo());%></td>
                                                    </tr>
                                                    <%}%>
                                                </tbody>
                                            </table></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%}%>
                        <%} else if (t.equalsIgnoreCase("CLIENTE")) {
                            if (rep.equalsIgnoreCase("C1")) {%>
                        <div id="reporteC1">
                            <h2 style="font-weight: 900; color: white;">Las últimas 15 transacciones más grandes realizadas en el último año, por cuenta</h2>
                            <%
                                ArrayList<CuentaDTO> cuentasCliente = cuentas.obtenerCuentas(Long.parseLong(codigo));
                                if (cuentasCliente.size() > 0) {
                            %>
                            <a href="../reporte?tipo=C1" download="reporte15.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
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
                                                        <td><%out.print(x + 1);%></td>
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
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("C2")) {%>
                        <div id="reporteC2">
                            <%
                                String fecha1 = s.getAttribute("fecha1").toString();
                                String fecha2 = s.getAttribute("fecha2").toString();
                                s.setAttribute("fecha1", null);
                                s.setAttribute("fecha2", null);
                                s.removeAttribute("fecha1");
                                s.removeAttribute("fecha2");
                            %>
                            <%
                                ArrayList<TransaccionDTO> tra2 = reporte.obtenerTransaccionesSaldoAnteriorActual(Long.parseLong(codigo), fecha1, fecha2);
                            %>
                            <h4 style="font-weight: 900; color: white;">Listado de todas las transacciones realizadas entre <%out.print(fecha1);%> y <%out.print(fecha2);%> mostrando el cambio del dinero de la cuenta por cada transacción</h4>
                            <%
                                if (tra2.size() > 0) {
                            %>
                            <a href="../reporte?tipo=C2&fecha1=<%out.print(fecha1);%>&fecha2=<%out.print(fecha2);%>" download="reporteCuentaMas.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
                            <table class="tablaDatos tablas" style="width:95%;">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Codigo transaccion</th>
                                        <th>Cuenta</th>
                                        <th>Cajero</th>
                                        <th>Creacion</th>
                                        <th>Tipo</th>
                                        <th>Anterior</th>
                                        <th>Monto</th>
                                        <th>Actual</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int x = 0; x < tra2.size(); x++) {
                                            TransaccionDTO temporalTra = tra2.get(x);
                                    %>
                                    <tr>
                                        <td><%out.print(x + 1);%></td>
                                        <td><%out.print(temporalTra.getCodigo());%></td>
                                        <td><%out.print(temporalTra.getCuenta());%></td>
                                        <td><%out.print(temporalTra.getCajero());%></td>
                                        <td><%out.print(temporalTra.getCreacion());%></td>
                                        <td><%out.print(temporalTra.getTipo());%></td>
                                        <td><%out.print(temporalTra.getAnterior());%></td>
                                        <td><%out.print(temporalTra.getMonto());%></td>
                                        <td><%out.print(temporalTra.getActual());%></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("C3")) {%>
                        <%
                            String fecha1 = s.getAttribute("fecha1").toString();
                            s.setAttribute("fecha1", null);
                            s.removeAttribute("fecha1");
                        %>
                        <div id="reporteC3">
                            <h2 style="font-weight: 900; color: white;">La cuenta con más dinero y sus transacciones desde <%out.print(fecha1);%> hasta hoy</h2>
                            <%
                                CuentaDTO cuentasCliente2 = reporte.obtenerCuentaConMásDinero(Long.parseLong(codigo));
                            %>
                            <a href="../reporte?tipo=C3&fecha1=<%out.print(fecha1);%>" download="reporteCuentaMas.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
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
                                    <tr>
                                        <td><%out.print(cuentasCliente2.getCodigo());%></td>
                                        <td><%out.print(cuentasCliente2.getCredito());%></td>
                                        <td><%out.print(cuentasCliente2.getCreacion());%></td>
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
                                                        ArrayList<TransaccionDTO> tra = reporte.obtenerTransaccionesDesdeHastaFechaActual(cuentasCliente2.getCodigo(), fecha1);
                                                        for (int x = 0; x < tra.size(); x++) {
                                                            TransaccionDTO temporalTra = tra.get(x);
                                                    %>
                                                    <tr>
                                                        <td><%out.print(x + 1);%></td>
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
                                </tbody>
                            </table>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("C4")) {%>
                        <div id="reporteC4">
                            <h4 style="font-weight: 900; color: white;">Reporte listado de solicitudes de asociación de cuenta recibidas con su estado</h4>
                            <%
                                ArrayList<AsociacionDTO> asociacion = asociaciones.obtenerAsociacionesRecibidas(Long.parseLong(codigo));
                                if (asociacion.size() > 0) {
                            %>
                            <a href="../reporte?tipo=C4" download="reporteRecibidas.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
                            <table class="tablaDatos" id="realizadas" width="95%">
                                <thead>
                                    <tr>
                                        <th>CODIGO</th>
                                        <th>NO DE CUENTA</th>
                                        <th>SOLICITANTE</th>
                                        <th>ESTADO</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < asociacion.size(); i++) {
                                            AsociacionDTO temporal = asociacion.get(i);
                                    %>
                                    <%if (temporal.getEstado().equalsIgnoreCase("EN ESPERA")) {%>
                                    <tr class="solicitudEspera">
                                        <%} else if (temporal.getEstado().equalsIgnoreCase("ACEPTADA")) {%>
                                    <tr class="solicitudAceptada">
                                        <%} else {%>
                                    <tr class="solicitudRechazada">
                                        <%}%>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getCuenta());%></td>
                                        <td><%out.print(temporal.getCliente());%></td>
                                        <td><%out.print(temporal.getEstado());%></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%} else if (rep.equalsIgnoreCase("C5")) {%>
                        <div id="reporteC5">
                            <h2 style="font-weight: 900; color: grey;">Reporte listado de solicitudes de asociación de cuenta realizadas con su estado</h2>
                            <%
                                ArrayList<AsociacionDTO> asociacion2 = asociaciones.obtenerAsociacionesRealizadas(Long.parseLong(codigo));
                                if (asociacion2.size() > 0) {
                            %>
                            <a href="../reporte?tipo=C5" download="reporteRealizadas.pdf" style="color:#5264AE;font-size: 1.5em;">EXPORTAR A PDF</a>
                            <table class="tablaDatos" id="realizadas" width="95%">
                                <thead>
                                    <tr>
                                        <th>CODIGO</th>
                                        <th>NO DE CUENTA</th>
                                        <th>ESTADO</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%for (int i = 0; i < asociacion2.size(); i++) {
                                            AsociacionDTO temporal = asociacion2.get(i);
                                    %>
                                    <%if (temporal.getEstado().equalsIgnoreCase("EN ESPERA")) {%>
                                    <tr class="solicitudEspera">
                                        <%} else if (temporal.getEstado().equalsIgnoreCase("ACEPTADA")) {%>
                                    <tr class="solicitudAceptada">
                                        <%} else {%>
                                    <tr class="solicitudRechazada">
                                        <%}%>
                                        <td><%out.print(temporal.getCodigo());%></td>
                                        <td><%out.print(temporal.getCuenta());%></td>
                                        <td><%out.print(temporal.getEstado());%></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                            <%} else {%>
                            <div id="tablaSinResultados">
                                <img src="../resources/img/questions.svg">
                                <h1 style="font-weight: 900; color: white;">SIN RESULTADOS</h1>
                                <p style="color: grey;">Los datos para este reporte no generaron ningun registro para el reporte</p>
                            </div>
                            <%}%>
                        </div>
                        <%}
                            }%>
                </div>
                </center>
                <%}%>
            </div>
        </div>
    </div>
    <%@include file='footer.html' %>
</body>
</html>
