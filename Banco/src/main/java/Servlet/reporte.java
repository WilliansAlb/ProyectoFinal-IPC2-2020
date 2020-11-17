/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AccionDAO;
import Base.AsociacionDAO;
import Base.Conector;
import Base.ConfiguracionDAO;
import Base.CuentaDAO;
import Base.ReporteDAO;
import DTO.AccionDTO;
import DTO.AsociacionDTO;
import DTO.CajeroDTO;
import DTO.ClienteDTO;
import DTO.ConfiguracionDTO;
import DTO.CuentaDTO;
import DTO.TransaccionDTO;
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
            if (tipo2.equalsIgnoreCase("G4")) {
                try {
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        CuentaDAO cuentas = new CuentaDAO(cn);
                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporte10.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
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
            } else if (tipo2.equalsIgnoreCase("G1")) {
                try {
                    String entidad = request.getParameter("filtro");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        AccionDAO acciones = new AccionDAO(cn);
                        List<AccionDTO> notasUsuario = acciones.listadoAcciones(Long.parseLong(s.getAttribute("codigo").toString()), entidad);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/HistorialAcciones.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(notasUsuario);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "HISTORIAL DE CAMBIOS REALIZADOS A ENTIDAD");
                        parameters.put("gerente", Long.parseLong(s.getAttribute("codigo").toString()));
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
            } else if (tipo2.equalsIgnoreCase("G2")) {
                try {
                    String entidad = request.getParameter("filtro");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AccionDAO acciones = new AccionDAO(cn);
                        ConfiguracionDAO confi = new ConfiguracionDAO(cn);
                        ConfiguracionDTO con = confi.obtenerConfiguracion();
                        List<ClienteDTO> notasUsuario = reporte.clientesTransaccionesMayoresALimiteMenor();

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteLimiteMe.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(notasUsuario);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "CLIENTES CON TRANSACCIONES MAYORES A LIMITE");
                        parameters.put("limiteMenor", con.getLimite_menor());
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
            } else if (tipo2.equalsIgnoreCase("G3")) {
                try {
                    String entidad = request.getParameter("filtro");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AccionDAO acciones = new AccionDAO(cn);
                        ConfiguracionDAO confi = new ConfiguracionDAO(cn);
                        ConfiguracionDTO con = confi.obtenerConfiguracion();
                        List<ClienteDTO> notasUsuario = reporte.clientesTransaccionesMayoresALimiteMayor();

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteLimiteMayor.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(notasUsuario);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "CLIENTES CON SUMA DE TRANSACCIONES MAYOR A LIMITE");
                        parameters.put("limiteMayor", con.getLimite_mayor());
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
            } else if (tipo2.equalsIgnoreCase("G5")) {
                try {
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AccionDAO acciones = new AccionDAO(cn);
                        ConfiguracionDAO confi = new ConfiguracionDAO(cn);
                        ConfiguracionDTO con = confi.obtenerConfiguracion();
                        List<ClienteDTO> notasUsuario = reporte.clientesSinTransaccionesIntervalo(fecha1, fecha2);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteClienteSin.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(notasUsuario);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "CLIENTES SIN TRANSACCIONES EN UN INTERVALO DE TIEMPO");
                        parameters.put("fechaD", fecha1);
                        parameters.put("fechaH", fecha2);
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
            } else if (tipo2.equalsIgnoreCase("G7")) {
                try {
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AccionDAO acciones = new AccionDAO(cn);
                        ConfiguracionDAO confi = new ConfiguracionDAO(cn);
                        ConfiguracionDTO con = confi.obtenerConfiguracion();
                        List<CajeroDTO> notasUsuario = reporte.obtenerCajeroMasTransacciones(fecha1, fecha2);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteCajeroMas.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(notasUsuario);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "CAJERO QUE MÁS TRANSACCIONES HA REALIZADO ENTRE UN INTERVALO DE TIEMPO");
                        parameters.put("fechaD", fecha1);
                        parameters.put("fechaH", fecha2);
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
            } else if (tipo2.equalsIgnoreCase("C3")) {
                try {
                    String fecha1 = request.getParameter("fecha1");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        long codigo = Long.parseLong(s.getAttribute("codigo").toString());
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AccionDAO acciones = new AccionDAO(cn);
                        ConfiguracionDAO confi = new ConfiguracionDAO(cn);
                        ConfiguracionDTO con = confi.obtenerConfiguracion();
                        CuentaDTO cuenta = reporte.obtenerCuentaConMásDinero(codigo);
                        List<TransaccionDTO> transacciones = reporte.obtenerTransaccionesDesdeHastaFechaActual(cuenta.getCodigo(), fecha1);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteCuentaMasDinero.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(transacciones);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "CUENTA CON MÁS DINERO Y SUS TRANSACCIONES DESDE UNA FECHA HASTA HOY");
                        parameters.put("fechaD", fecha1);
                        parameters.put("noCuenta", cuenta.getCodigo());
                        parameters.put("coCliente", cuenta.getCliente());
                        parameters.put("moCredito", cuenta.getCredito());
                        parameters.put("creada", cuenta.getCreacion());
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
            } else if (tipo2.equalsIgnoreCase("C2")) {
                try {
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        long codigo = Long.parseLong(s.getAttribute("codigo").toString());
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AccionDAO acciones = new AccionDAO(cn);
                        ConfiguracionDAO confi = new ConfiguracionDAO(cn);
                        ConfiguracionDTO con = confi.obtenerConfiguracion();
                        CuentaDTO cuenta = reporte.obtenerCuentaConMásDinero(codigo);
                        List<TransaccionDTO> transacciones = reporte.obtenerTransaccionesSaldoAnteriorActual(codigo, fecha1, fecha2);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteTransaccionesCambio.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(transacciones);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "TRANSACCIONES REALIZADAS ENTRE UN INTERVALO DE TIEMPO, MOSTRANDO EL CAMBIO EN EL SALDO DE LA CUENTA");
                        parameters.put("fechaD", fecha1);
                        parameters.put("fechaH", fecha2);
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
            } else if (tipo2.equalsIgnoreCase("C4")) {
                try {
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        long codigo = Long.parseLong(s.getAttribute("codigo").toString());
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AsociacionDAO asociaciones = new AsociacionDAO(cn);
                        List<AsociacionDTO> asos = asociaciones.obtenerAsociacionesRecibidas(codigo);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteAsociacionRecibida.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(asos);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "LISTADO DE SOLICITUDES DE ASOCIACION DE CUENTA RECIBIDAS CON SUS ESTADOS");
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
            } else if (tipo2.equalsIgnoreCase("C5")) {
                try {
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        long codigo = Long.parseLong(s.getAttribute("codigo").toString());
                        ReporteDAO reporte = new ReporteDAO(cn);
                        AsociacionDAO asociaciones = new AsociacionDAO(cn);
                        List<AsociacionDTO> asos = asociaciones.obtenerAsociacionesRealizadas(codigo);

                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteAsociacionRealizada.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(asos);

                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "LISTADO DE SOLICITUDES DE ASOCIACION DE CUENTA REALIZADAS CON SUS ESTADOS");
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
            } else if (tipo2.equalsIgnoreCase("C1")) {
                try {
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        long codigo = Long.parseLong(s.getAttribute("codigo").toString());
                        CuentaDAO cuentas = new CuentaDAO(cn);
                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporte15.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "LAS ULTIMAS 15 TRANSACCIONES MAS GRANDES REALIZADAS EN EL ULTIMO AÑO POR CUENTA");
                        parameters.put("coCliente", codigo);
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
            } else if (tipo2.equalsIgnoreCase("CA2")) {
                String fecha1 = request.getParameter("fecha1");
                String fecha2 = request.getParameter("fecha2");
                try {
                    response.setContentType("application/pdf");
                    Conector cn = new Conector();
                    if (cn.conectar()) {
                        long codigo = Long.parseLong(s.getAttribute("codigo").toString());
                        CuentaDAO cuentas = new CuentaDAO(cn);
                        File file = new File(request.getServletContext().getRealPath("/resources/reportes/reporteBalance.jrxml"));
                        JasperReport jasperReports = JasperCompileManager.compileReport(file.getAbsolutePath());
                        Map<String, Object> parameters = new HashMap<>();
                        parameters.put("reporte", "LISTADO DE LAS TRANSACCIONES REALIZADAS POR DÍA EN UN INTERVALO DE TIEMPO MOSTRANDO EL BALANCE FINAL");
                        parameters.put("coCajero", Long.parseLong(s.getAttribute("codigo").toString()));
                        parameters.put("fechaD", fecha1);
                        parameters.put("fechaH", fecha2);
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
