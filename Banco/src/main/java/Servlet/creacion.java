/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.CajeroDAO;
import Base.ClienteDAO;
import Base.Conector;
import Base.CuentaDAO;
import Base.GerenteDAO;
import Base.UsuarioDAO;
import DTO.CajeroDTO;
import DTO.ClienteDTO;
import DTO.CuentaDTO;
import DTO.GerenteDTO;
import DTO.UsuarioDTO;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author yelbetto
 */
@MultipartConfig(maxFileSize = 16177215)
public class creacion extends HttpServlet {
    
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
            out.println("<title>Servlet creacion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet creacion at " + request.getContextPath() + "</h1>");
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
        if (request.getParameter("dpi") != null) {
            ClienteDAO cliente = new ClienteDAO(cn);
            String dpi = request.getParameter("dpi");
            ClienteDTO nuevo = new ClienteDTO();
            nuevo.setDpi(dpi);
            
            ClienteDTO obtenido = cliente.obtenerCliente(nuevo);
            
            if (obtenido.getNombre() != null) {
                String enviarDatos = obtenido.getCodigo() + "\n" + obtenido.getNombre() + "\n" + obtenido.getDireccion() + "\n" + obtenido.getDpi() + "\n" + obtenido.getFecha() + "\n" + obtenido.getSexo();
                response.getWriter().write(enviarDatos);
            } else {
                response.getWriter().write("NOEXISTE");
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
        String turno = request.getParameter("turno");
        String fecha = request.getParameter("fecha");
        String monto = request.getParameter("monto");
        response.setContentType("text/plain;charset=UTF-8");
        if (turno != null) {
            String tipo = request.getParameter("tipo");
            if (tipo.equalsIgnoreCase("C")) {
                CajeroDTO cajero = new CajeroDTO();
                CajeroDAO cajeros = new CajeroDAO(cn);
                UsuarioDAO usuario = new UsuarioDAO(cn);
                cajero.setDpi(request.getParameter("dpi"));
                cajero.setNombre(encoding(request.getParameter("nombre")));
                cajero.setDireccion(encoding(request.getParameter("direccion")));
                cajero.setSexo(request.getParameter("sexo"));
                cajero.setTurno(turno);
                String generar = request.getParameter("generar");
                String contra;
                if (generar.equalsIgnoreCase("N")) {
                    contra = encoding(request.getParameter("password"));
                } else {
                    contra = generarContra();
                }
                if (!cajeros.existeCajero(cajero)) {
                    int codigo = cajeros.crearCajero(cajero);
                    if (codigo != (-1)) {
                        UsuarioDTO user = new UsuarioDTO("CA" + codigo, codigo, contra, "CAJERO");
                        if (usuario.ingresarUsuario(user)) {
                            response.getWriter().write("Cajero con DPI " + cajero.getDpi() + " creado correctamente. Las credenciales del cajero son ID: CA" + codigo + " y PASSWORD: " + contra);
                        } else {
                            response.getWriter().write("Cajero con DPI " + cajero.getDpi() + " creado correctamente. No fue posible crearle el usuario. ");
                        }
                    } else {
                        response.getWriter().write("ERROR: no fue posible crear el cajero");
                    }
                } else {
                    response.getWriter().write("EXISTE");
                }
            } else {
                GerenteDTO gerente = new GerenteDTO();
                GerenteDAO gerentes = new GerenteDAO(cn);
                UsuarioDAO usuario = new UsuarioDAO(cn);
                gerente.setDpi(request.getParameter("dpi"));
                gerente.setNombre(encoding(request.getParameter("nombre")));
                gerente.setDireccion(encoding(request.getParameter("direccion")));
                gerente.setSexo(request.getParameter("sexo"));
                gerente.setTurno(turno);
                String generar = request.getParameter("generar");
                String contra;
                if (generar.equalsIgnoreCase("N")) {
                    contra = encoding(request.getParameter("password"));
                } else {
                    contra = generarContra();
                }
                if (!gerentes.existeGerente(gerente)) {
                    int codigo = gerentes.crearGerente(gerente);
                    if (codigo != (-1)) {
                        UsuarioDTO user = new UsuarioDTO("CA" + codigo, codigo, contra, "CAJERO");
                        if (usuario.ingresarUsuario(user)) {
                            response.getWriter().write("Gerente con DPI " + gerente.getDpi() + " creado correctamente. Las credenciales del gerente son ID: CA" + codigo + " y PASSWORD: " + contra);
                        } else {
                            response.getWriter().write("Gerente con DPI " + gerente.getDpi() + " creado correctamente. No fue posible crearle el usuario. ");
                        }
                    } else {
                        response.getWriter().write("ERROR: no fue posible crear el gerente");
                    }
                } else {
                    response.getWriter().write("EXISTE");
                }
            }
        } else if (fecha != null) {
            ClienteDAO clientes = new ClienteDAO(cn);
            ClienteDTO cliente = new ClienteDTO();
            UsuarioDAO usuario = new UsuarioDAO(cn);
            cliente.setDpi(request.getParameter("dpi"));
            cliente.setNombre(encoding(request.getParameter("nombre")));
            cliente.setDireccion(encoding(request.getParameter("direccion")));
            cliente.setSexo(request.getParameter("sexo"));
            cliente.setFecha(fecha);
            String generar = request.getParameter("generar");
            String contra;
            if (generar.equalsIgnoreCase("N")) {
                contra = encoding(request.getParameter("password"));
            } else {
                contra = generarContra();
            }
            InputStream archivo = null;
            try {
                Part filePart = request.getPart("archivo");
                if (filePart.getSize() > 0) {
                    archivo = filePart.getInputStream();
                }
            } catch (Exception ex) {
                System.err.print(ex);
            }
            if (!clientes.existeClienteDPI(cliente)) {
                int codigo = clientes.crearCliente(cliente, archivo);
                if (codigo != (-1)) {
                    UsuarioDTO user = new UsuarioDTO("CL" + codigo, codigo, contra, "CLIENTE");
                    if (usuario.ingresarUsuario(user)) {
                        response.getWriter().write(codigo+"|"+"CL"+codigo+"|"+contra);
                    } else {
                        response.getWriter().write("Cliente con DPI " + cliente.getDpi() + " creado correctamente. No fue posible crearle el usuario. ");
                    }
                } else {
                    response.getWriter().write("ERROR: no fue posible crear el cliente");
                }
            } else {
                response.getWriter().write("EXISTE");
            }
        } else if (monto != null) {
            Double montoCantidad = Double.parseDouble(monto);
            CuentaDTO cuenta = new CuentaDTO(montoCantidad, Integer.parseInt(request.getParameter("cliente")), request.getParameter("creacion"));
            CuentaDAO cuentas = new CuentaDAO(cn);
            
            long retorno = cuentas.crearCuenta(cuenta);
            
            if (retorno != -1) {
                response.getWriter().write(retorno+" ");
            } else {
                response.getWriter().write("ERROR: no se pudo ingresa la cuenta");
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

    public String generarContra() {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0987654321";
        String contra = "";
        for (int i = 0; i < 8; i++) {
            Random aleatorio = new Random(System.nanoTime());
            int elegido = aleatorio.nextInt(caracteres.length());
            contra += caracteres.charAt(elegido);
        }
        return contra;
    }
    
    public String encoding(String palabra) throws UnsupportedEncodingException {
        return new String(palabra.getBytes("ISO-8859-1"), "UTF-8");
    }
}
