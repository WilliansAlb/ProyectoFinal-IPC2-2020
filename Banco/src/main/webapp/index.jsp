<%-- 
    Document   : index
    Created on : 26/10/2020, 01:19:46 AM
    Author     : yelbetto
--%>

<%@page import="Base.GerenteDAO"%>
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
            HttpSession s = request.getSession();
            Conector cn = new Conector("encender");
            GerenteDAO existe = new GerenteDAO(cn);
            if (existe.entrar()) {
        %>
        <%if (s.getAttribute("usuario") == null) {%>
        <% response.sendRedirect("views/login.jsp"); %>
        <%} else {%>
        <% response.sendRedirect("views/home.jsp");%>
        <%}%>
        <%} else {
                response.sendRedirect("views/carga.jsp");
            }%>
    </body>
</html>
