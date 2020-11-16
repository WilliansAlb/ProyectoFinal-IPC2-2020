/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.ClienteDAO;
import Base.Conector;
import DTO.ClienteDTO;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.ws.rs.core.HttpHeaders;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 *
 * @author yelbetto
 */
@MultipartConfig(maxFileSize = 16177215)
public class archivo extends HttpServlet {
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
            out.println("<title>Servlet archivo</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet archivo at " + request.getContextPath() + "</h1>");
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
        Conector con = new Conector("encender");
        PreparedStatement ps = null;
        ResultSet rs = null;
        byte[] b = null;
        String codigo = request.getParameter("pdf");
        try {
            ps = con.getConexion().prepareStatement("SELECT pdf FROM Cliente WHERE dpi = ?;");
            ps.setString(1, codigo);
            rs = ps.executeQuery();
            while (rs.next()) {
                b = rs.getBytes(1);
            }
            InputStream bos = new ByteArrayInputStream(b);

            int tamanoInput = bos.available();
            byte[] datosPDF = new byte[tamanoInput];
            bos.read(datosPDF, 0, tamanoInput);

            response.getOutputStream().write(datosPDF);
            bos.close();
            ps.close();
            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage()+"/");
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
        Collection<Part> parts = request.getParts();
        List<Part> xml = new ArrayList<>(parts.size());
        List<Part> dpis = new ArrayList<>(parts.size());
        for (Part part : parts) {
            String headerValue = part.getHeader(HttpHeaders.CONTENT_DISPOSITION);
            if (headerValue.contains("xml")) {
                xml.add(part);
            } else {
                dpis.add(part);
            }
        }
        ClienteDAO cliente = new ClienteDAO(cn);
        String ingresados = "";
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = dbf.newDocumentBuilder();
            Document document = documentBuilder.parse(xml.get(0).getInputStream());
            document.getDocumentElement().normalize();
            System.out.println("Elemento raiz:" + document.getDocumentElement().getNodeName());
            NodeList listaEmpleados = document.getElementsByTagName("CLIENTE");
            for (int temp = 0; temp < listaEmpleados.getLength(); temp++) {
                Node nodo = listaEmpleados.item(temp);
                System.out.println("Elemento:" + nodo.getNodeName());
                if (nodo.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) nodo;
                    String codigo = element.getElementsByTagName("CODIGO").item(0).getTextContent();
                    String ruta = element.getElementsByTagName("DPI-PDF").item(0).getTextContent();
                    InputStream archivo = null;
                    ClienteDTO clienteTemporal = new ClienteDTO();
                    clienteTemporal.setCodigo(Long.parseLong(codigo));
                    for (int i = 0; i < dpis.size(); i++) {
                        if (dpis.get(i).getHeader(HttpHeaders.CONTENT_DISPOSITION).contains(ruta)){
                            archivo = dpis.get(i).getInputStream();
                            break;
                        }
                    }
                    if (cliente.existeCliente(clienteTemporal)){
                        if (cliente.ingresarArchivo(archivo, clienteTemporal)){
                            ingresados += "Archivo DPI de cliente "+codigo+"\n";
                        } else {
                            ingresados += "Archivo DPI de cliente "+codigo+" -ERROR: no se ingreso a la base de datos\n";
                        }
                    } else {
                       ingresados += "Archivo DPI de cliente "+codigo+" -ERROR: no existe el cliente\n";
                    }
                }
            }
            response.getWriter().write(ingresados);
        } catch (Exception e) {
            e.printStackTrace();
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
