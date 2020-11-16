<%-- 
    Document   : generado
    Created on : 16/11/2020, 05:20:10 AM
    Author     : yelbetto
--%>

<%@page import="DTO.ClienteDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ReporteDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            Conector cn = new Conector("encender");
            ReporteDAO reporte = new ReporteDAO(cn);
        %>
        <%
            ArrayList<ClienteDTO> clientes = reporte.clientesTransaccionesMayoresALimiteMenor();
        %>
        <table>
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
            <%
            ArrayList<ClienteDTO> clientes2 = reporte.clientesTransaccionesMayoresALimiteMayor();
        %>
        <table>
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
    </body>
</html>
