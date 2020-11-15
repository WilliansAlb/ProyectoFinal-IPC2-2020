/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AccionDAO;
import Base.Conector;
import Base.CuentaDAO;
import DTO.AccionDTO;
import DTO.CuentaDTO;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

/**
 *
 * @author yelbetto
 */
public class reporte extends HttpServlet {

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
        HttpSession s = request.getSession();
        if (request.getParameter("tipo") != null) {
            String tipo2 = request.getParameter("tipo");
            if (tipo2.equalsIgnoreCase("1")) {
                try {
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        CuentaDAO cuentas = new CuentaDAO(cn);
                        List<CuentaDTO> notasUsuario = cuentas.obtenerCuentas(75416);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporte10.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(notasUsuario);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "REPORTE 10 CUENTAS CON MÁS DINERO");
                        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReports, parameters, cn.getConexion());
                        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

                        response.getOutputStream().flush();
                        response.getOutputStream().close();
                    }
                } catch (IOException | NumberFormatException e) {
                    System.out.println("Error: " + e.getMessage());
                    e.printStackTrace();
                } catch (JRException ex) {
                    ex.printStackTrace();
                }
            } else if (tipo2.equalsIgnoreCase("2")) {
                try {
                    String entidad = request.getParameter("filtro");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        AccionDAO acciones = new AccionDAO(cn);
                        List<AccionDTO> notasUsuario = acciones.listadoAcciones(Integer.parseInt(s.getAttribute("codigo").toString()), entidad);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/HistorialAcciones.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(notasUsuario);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "HISTORIAL DE CAMBIOS REALIZADOS A ENTIDAD");
                        parameters.put("gerente", Integer.parseInt(s.getAttribute("codigo").toString()));
                        parameters.put("entidad", entidad);
                        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReports, parameters, dataSource);
                        JasperExportManager.exportReportToPdfStream(jasperPrint, response.getOutputStream());

                        response.getOutputStream().flush();
                        response.getOutputStream().close();
                    }
                } catch (IOException | NumberFormatException e) {
                    System.out.println("Error: " + e.getMessage());
                    e.printStackTrace();
                } catch (JRException ex) {
                    ex.printStackTrace();
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
