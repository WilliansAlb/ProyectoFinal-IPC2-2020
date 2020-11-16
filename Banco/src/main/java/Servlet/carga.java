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
import Base.TransaccionDAO;
import Base.UsuarioDAO;
import DTO.CajeroDTO;
import DTO.ClienteDTO;
import DTO.CuentaDTO;
import DTO.GerenteDTO;
import DTO.TransaccionDTO;
import DTO.UsuarioDTO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yelbetto
 */
public class carga extends HttpServlet {

    public Conector cn = new Conector("encender");

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
            out.println("<title>Servlet carga</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet carga at " + request.getContextPath() + "</h1>");
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
        if (request.getParameter("tipo") != null) {
            String tipo = request.getParameter("tipo");
            String s = request.getParameter("test");
            Gson gson = new Gson();
            JsonArray elements = gson.fromJson(s, JsonArray.class);
            String ingresados = "";
            if (tipo.equalsIgnoreCase("1")) {
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    long codigo = gsonObj.get("codigo").getAsLong();
                    String nombre = encoding(gsonObj.get("nombre").getAsString());
                    String dpi = gsonObj.get("dpi").getAsString();
                    String turno = gsonObj.get("turno").getAsString().toUpperCase();
                    String sexo = gsonObj.get("sexo").getAsString().toUpperCase();
                    String password = gsonObj.get("password").getAsString();
                    String direccion = gsonObj.get("direccion").getAsString();
                    GerenteDAO gerencia = new GerenteDAO(cn);
                    GerenteDTO gerente = new GerenteDTO();

                    gerente.setCodigo(gsonObj.get("codigo").getAsLong());
                    gerente.setNombre(encoding(gsonObj.get("nombre").getAsString()));
                    gerente.setDpi(gsonObj.get("dpi").getAsString());
                    gerente.setTurno(gsonObj.get("turno").getAsString().toUpperCase().charAt(0) + "");
                    gerente.setSexo(gsonObj.get("sexo").getAsString().toUpperCase().charAt(0) + "");
                    gerente.setDireccion(encoding(gsonObj.get("direccion").getAsString()));

                    if (gerencia.ingresarGerente(gerente)) {
                        UsuarioDTO usuario = new UsuarioDTO("GE" + codigo, codigo, password, "GERENTE");
                        UsuarioDAO user = new UsuarioDAO(cn);
                        if (user.ingresarUsuario(usuario)) {
                            ingresados += "Gerente " + codigo + " ID: GE" + codigo + " \n";
                        } else {
                            ingresados += "Gerente " + codigo + " -No pudo crearse el usuario\n";
                        }
                    } else {
                        ingresados += "Gerente " + codigo + " -No se ingreso a la base de datos\n";
                    }
                }
            } else if (tipo.equalsIgnoreCase("2")) {
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    long codigo = gsonObj.get("codigo").getAsLong();
                    String nombre = encoding(gsonObj.get("nombre").getAsString());
                    String dpi = gsonObj.get("dpi").getAsString();
                    String turno = gsonObj.get("turno").getAsString();
                    String sexo = gsonObj.get("sexo").getAsString();
                    String password = gsonObj.get("password").getAsString();
                    String direccion = gsonObj.get("direccion").getAsString();
                    CajeroDAO cajeros = new CajeroDAO(cn);
                    CajeroDTO cajero = new CajeroDTO();

                    cajero.setCodigo(gsonObj.get("codigo").getAsLong());
                    cajero.setNombre(encoding(gsonObj.get("nombre").getAsString()));
                    cajero.setDpi(gsonObj.get("dpi").getAsString());
                    cajero.setTurno(gsonObj.get("turno").getAsString().toUpperCase().charAt(0) + "");
                    cajero.setSexo(gsonObj.get("sexo").getAsString().toUpperCase().charAt(0) + "");
                    cajero.setDireccion(gsonObj.get("direccion").getAsString());

                    if (cajeros.ingresarCajero(cajero)) {
                        UsuarioDTO usuario = new UsuarioDTO("CA" + codigo, codigo, password, "CAJERO");
                        UsuarioDAO user = new UsuarioDAO(cn);
                        if (user.ingresarUsuario(usuario)) {
                            ingresados += "Cajero " + codigo + " ID: CA" + codigo + " \n";
                        } else {
                            ingresados += "Cajero " + codigo + " -No pudo crearse el usuario\n";
                        }
                    } else {
                        ingresados += "Cajero " + codigo + " -No se ingreso a la base de datos\n";
                    }
                }
            } else if (tipo.equalsIgnoreCase("3")) {
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    long codigo = gsonObj.get("codigo1").getAsLong();
                    String nombre = encoding(gsonObj.get("nombre").getAsString());
                    String dpi = gsonObj.get("dpi").getAsString();
                    String fecha = gsonObj.get("fecha").getAsString();
                    String sexo = gsonObj.get("sexo").getAsString();
                    String password = gsonObj.get("password").getAsString();
                    String direccion = encoding(gsonObj.get("direccion").getAsString());

                    ClienteDTO cliente = new ClienteDTO(codigo, nombre, fecha, dpi, direccion, sexo.toUpperCase().charAt(0) + "");
                    ClienteDAO clientes = new ClienteDAO(cn);

                    if (clientes.ingresarCliente(cliente)) {
                        UsuarioDTO usuario = new UsuarioDTO("CL" + codigo, codigo, password, "CLIENTE");
                        UsuarioDAO user = new UsuarioDAO(cn);
                        if (user.ingresarUsuario(usuario)) {
                            ingresados += "Cliente " + codigo + " ID: CL" + codigo + " \n";
                        } else {
                            ingresados += "Cliente " + codigo + " -No pudo crearse el usuario\n";
                        }
                    } else {
                        ingresados += "Cliente " + codigo + " -No se ingreso a la base de datos\n";
                    }
                }
            } else if (tipo.equalsIgnoreCase("4")) {
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    long cliente = gsonObj.get("cliente").getAsLong();
                    long codigo = gsonObj.get("codigo").getAsLong();
                    String fecha = gsonObj.get("fecha").getAsString();
                    Double monto = gsonObj.get("monto").getAsDouble();
                    CuentaDTO cuenta = new CuentaDTO(codigo, monto, cliente, fecha);
                    CuentaDAO cuentas = new CuentaDAO(cn);
                    if (cuentas.ingresarCuenta(cuenta)) {
                        ingresados += "Cuenta " + codigo + "\n";
                    } else {
                        ingresados += "Cuenta " + codigo + " -No se ingreso a la base de datos\n";
                    }
                }
            } else if (tipo.equalsIgnoreCase("5")) {
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    long codigo = gsonObj.get("codigo").getAsLong();
                    long cuenta = gsonObj.get("cuenta").getAsLong();
                    String fecha = gsonObj.get("fecha").getAsString();
                    String hora = gsonObj.get("hora").getAsString();
                    String creacion = fecha + " " + hora;
                    String tipo2 = gsonObj.get("tipo").getAsString();
                    Double monto = gsonObj.get("monto").getAsDouble();
                    long cajero = gsonObj.get("cajero").getAsLong();
                    TransaccionDAO transaccion = new TransaccionDAO(cn);
                    CuentaDAO cuentas = new CuentaDAO(cn);
                    TransaccionDTO tra = new TransaccionDTO(codigo, cuenta, cajero, monto, creacion, tipo2.toUpperCase());

                    if (!transaccion.existeTransaccion(tra)) {
                        if (transaccion.ingresarTransaccion(tra)) {
                            if (tra.getTipo().contains("DEBITO")) {
                                if (transaccion.existeTransaccion(tra)) {
                                    if (cuentas.actualizarSaldo(tra.getCuenta(), tra.getMonto() * (-1))) {
                                        ingresados += "Transaccion " + codigo + "\n";
                                    } else {
                                        ingresados += "Transaccion " + codigo + " -No fue actualizado el saldo de la cuenta\n";
                                    }
                                } else {
                                    ingresados += "Transaccion " + codigo + " -Saldo insuficiente\n";
                                }
                            } else {
                                if (cuentas.actualizarSaldo(tra.getCuenta(), tra.getMonto())) {
                                    ingresados += "Transaccion " + codigo + "\n";
                                } else {
                                    ingresados += "Transaccion " + codigo + " -No fue actualizado el saldo de la cuenta\n";
                                }
                            }
                        } else {
                            ingresados += "Transaccion " + codigo + " -No fue ingresada a la base de datos\n";
                        }
                    } else {
                        ingresados += "Transaccion " + codigo + " -Ya existe en la base de datos\n";
                    }
                }
            }
            response.getWriter().write(ingresados);
        } else {
            response.getWriter().write("");
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
