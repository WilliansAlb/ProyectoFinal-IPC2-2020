/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AccionDAO;
import Base.Conector;
import Base.ConfiguracionDAO;
import DTO.ConfiguracionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yelbetto
 */
public class configuracion extends HttpServlet {

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
            out.println("<title>Servlet configuracion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet configuracion at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        response.setContentType("text/plain;charset=UTF-8");
        Conector cn = new Conector("encender");
        HttpSession s = request.getSession();
        long codigo = Long.parseLong(s.getAttribute("codigo").toString());
        Date fecha = new Date();
        DateFormat fecha2 = new SimpleDateFormat("yyyy-MM-dd");
        ConfiguracionDAO configuracion = new ConfiguracionDAO(cn);
        AccionDAO accion = new AccionDAO(cn);
        String limiteMenor = request.getParameter("limiteMenor");
        String limiteMayor = request.getParameter("limiteMayor");
        String desdeMatutino = request.getParameter("dmatutino");
        String hastaMatutino = request.getParameter("hmatutino");
        String desdeVespertino = request.getParameter("dvespertino");
        String hastaVespertino = request.getParameter("hvespertino");
        ConfiguracionDTO confi = new ConfiguracionDTO(Double.parseDouble(limiteMenor), Double.parseDouble(limiteMayor), desdeMatutino, hastaMatutino, desdeVespertino, hastaVespertino);
        if (configuracion.existeConfiguracion()) {
            if (configuracion.actualizarConfiguracion(confi.getLimite_menor(), confi.getLimite_mayor())) {
                if (configuracion.actualizarTurnoMatutino(desdeMatutino, hastaMatutino)) {
                    if (configuracion.actualizarTurnoVespertino(desdeVespertino, hastaVespertino)) {
                        int accionCreada = accion.ingresarAccion("Actualizar la configuracion", codigo,fecha2.format(fecha),"CONFIGURACION");
                        response.getWriter().write("CONFIGURACION ACTUALIZADA "+accionCreada);
                    } else {
                        response.getWriter().write("ERROR: no se pudo actualizar el turno vespertino");
                    }
                } else {
                    response.getWriter().write("ERROR: no se pudo actualizar el turno matutino");
                }
            } else {
                response.getWriter().write("ERROR: no se pudo actualizar la configuracion");
            }
        } else {
            int retorno = configuracion.ingresarConfiguracion(confi);
            response.getWriter().write("CONFIGURACION CREADA " + retorno);
        }
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
