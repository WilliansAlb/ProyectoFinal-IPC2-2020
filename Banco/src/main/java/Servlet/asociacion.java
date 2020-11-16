/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AsociacionDAO;
import Base.ClienteDAO;
import Base.Conector;
import Base.CuentaDAO;
import DTO.AsociacionDTO;
import DTO.ClienteDTO;
import DTO.CuentaDTO;
import DTO.UsuarioDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yelbetto
 */
public class asociacion extends HttpServlet {

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
            out.println("<title>Servlet asociacion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet asociacion at " + request.getContextPath() + "</h1>");
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
        HttpSession actual = request.getSession();
        Conector cn = new Conector("encender");
        UsuarioDTO usuario = new UsuarioDTO(actual.getAttribute("id").toString(), Long.parseLong(actual.getAttribute("codigo").toString()), "", actual.getAttribute("tipo").toString());
        if (request.getParameter("busqueda") != null) {
            long cuenta = Long.parseLong(request.getParameter("busqueda"));
            CuentaDAO cuentas = new CuentaDAO(cn);
            CuentaDTO retorno = cuentas.existeCuenta(cuenta);
            if (retorno.getCreacion() != null) {
                ClienteDAO clientes = new ClienteDAO(cn);
                ClienteDTO cliente = clientes.obtenerClienteConCodigo(retorno.getCliente());
                if (cliente.getNombre() != null) {
                    if (retorno.getCliente() == usuario.getCodigo()) {
                        response.getWriter().write("PROPIEDAD");
                    } else {
                        response.getWriter().write(retorno.getCodigo() + "\n" + cliente.getNombre() + "\n" + cliente.getDpi() + "\n" + cliente.getDireccion());
                    }
                } else {
                    response.getWriter().write("ERROR: No se pudieron recuperar los datos del propietario de la cuenta, por favor intenta de nuevo");
                }
            } else {
                response.getWriter().write("NOEXISTE");
            }
        } else {
            if (request.getParameter("cliente") != null) {
                ClienteDAO cliente = new ClienteDAO(cn);
                long codigo = Long.parseLong(request.getParameter("cliente"));
                ClienteDTO nuevo = new ClienteDTO();
                nuevo.setCodigo(codigo);
                ClienteDTO obtenido = cliente.obtenerClienteConCodigo(nuevo);
                if (obtenido.getNombre() != null) {
                    String enviarDatos = obtenido.getCodigo() + "\n" + obtenido.getNombre() + "\n" + obtenido.getDpi() + "\n" + obtenido.getDireccion();
                    response.getWriter().write(enviarDatos);
                } else {
                    response.getWriter().write("NOEXISTE");
                }
            }
            if (request.getParameter("asociacion")!=null){
                int codigoAsociacion = Integer.parseInt(request.getParameter("asociacion"));
                String estado = request.getParameter("estado");
                AsociacionDAO asociacion = new AsociacionDAO(cn);
                if (asociacion.editarEstado(codigoAsociacion, estado)){
                    response.getWriter().write("ACTUALIZADO");
                } else {
                    response.getWriter().write("ERROR");
                }
            }
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
        response.setContentType("text/plain;charset=UTF-8");
        HttpSession actual = request.getSession();
        Conector cn = new Conector("encender");
        UsuarioDTO usuario = new UsuarioDTO(actual.getAttribute("id").toString(), Long.parseLong(actual.getAttribute("codigo").toString()), "", actual.getAttribute("tipo").toString());

        String tipo = request.getParameter("tipo");
        if (tipo.equalsIgnoreCase("ENVIAR")) {
            long cuenta = Long.parseLong(request.getParameter("cuenta"));
            AsociacionDAO asociaciones = new AsociacionDAO(cn);
            AsociacionDTO asociacion = new AsociacionDTO(cuenta, usuario.getCodigo(), "EN ESPERA");
            ArrayList<String> estados = asociaciones.estados(asociacion);
            if (estados.size() > 0) {
                if (estados.size() < 3) {
                    if (estados.contains(asociacion.getEstado())) {
                        response.getWriter().write("ESPERA");
                    } else {
                        if (estados.contains("ACEPTADA")) {
                            response.getWriter().write("ACEPTADA");
                        } else {
                            int codigoGenerado = asociaciones.enviarSolicitud(asociacion);
                            if (codigoGenerado != -1) {
                                response.getWriter().write("SOLICITUD " + codigoGenerado);
                            } else {
                                response.getWriter().write("ERROR");
                            }
                        }
                    }
                } else {
                    response.getWriter().write("LIMITE");
                }
            } else {
                int codigoGenerado = asociaciones.enviarSolicitud(asociacion);
                if (codigoGenerado != -1) {
                    response.getWriter().write("SOLICITUD " + codigoGenerado);
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

}
