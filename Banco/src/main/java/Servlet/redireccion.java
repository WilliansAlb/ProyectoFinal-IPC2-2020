/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yelbetto
 */
public class redireccion extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet redireccion</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet redireccion at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        HttpSession s = request.getSession();
        if (tipo.equalsIgnoreCase("G2")){
            s.setAttribute("reporte", "G2");
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("G3")) {
            s.setAttribute("reporte", tipo);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("G4")) {
            s.setAttribute("reporte", tipo);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("G5")) {
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            s.setAttribute("reporte", tipo);
            s.setAttribute("fecha1", fecha1);
            s.setAttribute("fecha2", fecha2);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("G7")) {
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            s.setAttribute("reporte", tipo);
            s.setAttribute("fecha1", fecha1);
            s.setAttribute("fecha2", fecha2);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("C2")) {
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            s.setAttribute("reporte", tipo);
            s.setAttribute("fecha1", fecha1);
            s.setAttribute("fecha2", fecha2);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("C3")) {
            String fecha1 = request.getParameter("fecha1");
            s.setAttribute("reporte", tipo);
            s.setAttribute("fecha1", fecha1);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("C1")) {
            s.setAttribute("reporte", tipo);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("C4")) {
            s.setAttribute("reporte", tipo);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if(tipo.equalsIgnoreCase("C5")) {
            s.setAttribute("reporte", tipo);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        } else if (tipo.equalsIgnoreCase("CA2")){
            String fecha1 = request.getParameter("fecha1");
            String fecha2 = request.getParameter("fecha2");
            s.setAttribute("reporte", tipo);
            s.setAttribute("fecha1", fecha1);
            s.setAttribute("fecha2", fecha2);
            response.sendRedirect(request.getContextPath()+"/views/generado.jsp");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
