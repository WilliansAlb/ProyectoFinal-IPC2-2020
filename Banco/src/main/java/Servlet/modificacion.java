/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AccionDAO;
import Base.CajeroDAO;
import Base.ClienteDAO;
import Base.Conector;
import Base.GerenteDAO;
import Base.UsuarioDAO;
import DTO.CajeroDTO;
import DTO.ClienteDTO;
import DTO.GerenteDTO;
import DTO.UsuarioDTO;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author yelbetto
 */
@MultipartConfig(maxFileSize = 16177215)
public class modificacion extends HttpServlet {

    Conector cn = new Conector("encender");

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
            out.println("<title>Servlet modificacion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet modificacion at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/plain;charset=UTF-8");

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
        HttpSession s = request.getSession();
        AccionDAO accion = new AccionDAO(cn);
        Date fecha2 = new Date();
        DateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        UsuarioDTO usuario = new UsuarioDTO(s.getAttribute("id").toString(),
                Integer.parseInt(s.getAttribute("codigo").toString()), "", "GERENTE");
        if (request.getParameter("modificado") != null) {
            String modificado = request.getParameter("modificado");
            if (modificado.equalsIgnoreCase("CAJERO")) {
                CajeroDAO cajeros = new CajeroDAO(cn);
                int codigo = Integer.parseInt(request.getParameter("codigo"));
                String nombre = encoding(request.getParameter("nombre"));
                String direccion = encoding(request.getParameter("direccion"));
                String turno = encoding(request.getParameter("turno"));
                String sexo = encoding(request.getParameter("sexo"));
                CajeroDTO cajero = new CajeroDTO(codigo, nombre, sexo, turno, direccion);
                if (cajeros.actualizarCajero(cajero)) {
                    accion.ingresarAccion("Actualizar datos de cajero con codigo " + codigo, usuario.getCodigo(), formato.format(fecha2), "CAJERO");
                    response.getWriter().write("ACTUALIZADO");
                } else {
                    response.getWriter().write("ERROR");
                }
            } else if (modificado.equalsIgnoreCase("GERENTE")) {
                GerenteDAO gerentes = new GerenteDAO(cn);
                int codigo = Integer.parseInt(request.getParameter("codigo"));
                String nombre = encoding(request.getParameter("nombre"));
                String direccion = encoding(request.getParameter("direccion"));
                String turno = encoding(request.getParameter("turno"));
                String sexo = encoding(request.getParameter("sexo"));
                System.out.println(sexo);
                String dpi = request.getParameter("dpi");
                GerenteDTO gerente = new GerenteDTO(codigo, nombre, sexo, turno, dpi, direccion);
                if (gerentes.actualizarGerente(gerente)) {
                    accion.ingresarAccion("Actualizar datos personales", usuario.getCodigo(), formato.format(fecha2), "GERENTE");
                    response.getWriter().write("ACTUALIZADO");
                } else {
                    response.getWriter().write("ERROR");
                }
            }
        } else {
            ClienteDAO clientes = new ClienteDAO(cn);
            ClienteDTO cliente = new ClienteDTO();
            cliente.setCodigo(Integer.parseInt(request.getParameter("codigo")));
            String fecha = request.getParameter("fecha");
            cliente.setDpi(request.getParameter("dpi"));
            cliente.setNombre(encoding(request.getParameter("nombre")));
            cliente.setDireccion(encoding(request.getParameter("direccion")));
            cliente.setSexo(request.getParameter("sexo"));
            cliente.setFecha(fecha);
            InputStream archivo = null;
            try {
                Part filePart = request.getPart("archivo");
                if (filePart.getSize() > 0) {
                    archivo = filePart.getInputStream();
                }
            } catch (Exception ex) {
                System.err.print(ex);
            }
            if (archivo != null) {
                if (clientes.actualizarCliente(cliente, archivo)) {
                    accion.ingresarAccion("Actualizar datos de cliente con codigo "+cliente.getCodigo(), usuario.getCodigo(), formato.format(fecha2), "CLIENTE");
                    response.getWriter().write("ACTUALIZADO");
                } else {
                    response.getWriter().write("ERROR");
                }
            } else {
                if (clientes.actualizarClienteSinPDF(cliente)) {
                    accion.ingresarAccion("Actualizar datos de cliente con codigo "+cliente.getCodigo(), usuario.getCodigo(), formato.format(fecha2), "CLIENTE");
                    response.getWriter().write("ACTUALIZADO");
                } else {
                    response.getWriter().write("ERROR");
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

    public String encoding(String palabra) throws UnsupportedEncodingException {
        return new String(palabra.getBytes("ISO-8859-1"), "UTF-8");
    }

}
