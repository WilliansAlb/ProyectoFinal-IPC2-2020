/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.Conector;
import Base.CuentaDAO;
import Base.TransaccionDAO;
import DTO.TransaccionDTO;
import DTO.UsuarioDTO;
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
public class transaccion extends HttpServlet {

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
            out.println("<title>Servlet transaccion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet transaccion at " + request.getContextPath() + "</h1>");
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
        String retiro = request.getParameter("retiro");
        response.setContentType("text/plain;charset=UTF-8");
        HttpSession actual = request.getSession();
        Conector cn = new Conector("encender");
        UsuarioDTO usuario = new UsuarioDTO(actual.getAttribute("id").toString(), Integer.parseInt(actual.getAttribute("codigo").toString()), "", actual.getAttribute("tipo").toString());
        if (retiro != null) {
            if (retiro.equalsIgnoreCase("CLIENTE")) {
                long cuenta = Long.parseLong(request.getParameter("cuenta"));
                Double monto = Double.parseDouble(request.getParameter("monto"));
                Date fecha = new Date();
                DateFormat hourdateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                TransaccionDTO transaccion = new TransaccionDTO(cuenta, 101, monto,hourdateFormat.format(fecha),"D");
                TransaccionDAO transacciones = new TransaccionDAO(cn);
                CuentaDAO cuentas = new CuentaDAO(cn);
                int codigoTransaccion = transacciones.ingresarTransaccionRetorno(transaccion);
                if (codigoTransaccion!=-1){
                    if (cuentas.actualizarSaldo(cuenta, monto*-1)){
                        response.getWriter().write(codigoTransaccion+"\n"+hourdateFormat.format(fecha));
                    } else {
                        response.getWriter().write("ERROR: se creo la transaccion, pero no se logro actualizar el saldo de la cuenta");
                    }
                } else {
                    response.getWriter().write("ERROR: no se pudo ingresar la transaccion a la base");
                }
            }
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
