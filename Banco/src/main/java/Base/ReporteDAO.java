/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class ReporteDAO {

    Connection cn;

    public ReporteDAO(Conector cn) {
        this.cn = cn.getConexion();
    }

    /**
     * Método que devuelve los datos para el reporte del cajero que más
     * transacciones ha realizado en un intervalo de tiempo
     *
     * @param fechaD fecha inicio intervalo
     * @param fechaH fecha final intervalo
     * @return listado de cajeros y las transacciones que ha realizado
     */
    public ArrayList<CajeroDTO> obtenerCajeroMasTransacciones(String fechaD, String fechaH) {
        ArrayList<CajeroDTO> retorno = new ArrayList<>();
        String sql = "SELECT COUNT(t.cajero) AS total, c.codigo, c.nombre, c.turno, c.sexo, c.direccion, c.dpi "
                + "FROM Transaccion t INNER JOIN Cajero c ON (t.cajero = c.codigo) WHERE DATE(t.creacion) BETWEEN ? AND ? "
                + "GROUP BY t.cajero ORDER BY total DESC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fechaD);
            ps.setString(2, fechaH);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CajeroDTO temporal = new CajeroDTO(rs.getLong(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7));
                temporal.setTotal(rs.getInt(1));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerCajeroMasTransacciones() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    /**
     * Método que devuelve los valores para el reporte de los clientes con
     * transacciones mayores a limite menor
     *
     * @return listado de clientes
     */
    public ArrayList<ClienteDTO> clientesTransaccionesMayoresALimiteMenor() {
        ArrayList<ClienteDTO> retorno = new ArrayList<>();
        String sql = "SELECT cl.codigo, cl.nombre, cl.dpi, cl.sexo, cl.direccion, cl.nacimiento, COUNT(cl.codigo) AS numero "
                + "FROM Cuenta cu inner join Cliente cl inner join Transaccion t inner join Configuracion con "
                + "ON (cu.codigo = t.cuenta AND ABS(t.monto) > con.limite_menor AND cl.codigo = cu.cliente) GROUP BY cl.codigo ORDER BY numero DESC;";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClienteDTO temporal = new ClienteDTO(rs.getLong(1), rs.getString(2), rs.getString(6), rs.getString(3), rs.getString(5), rs.getString(4));
                temporal.setTransacciones(rs.getInt(7));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerCajeroMasTransacciones() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    /**
     * Método que devuelve la sumatoria de las transacciones de sus cuentas y
     * esa sumatoria es mayor al limite
     *
     * @return listado de clientes
     */
    public ArrayList<ClienteDTO> clientesTransaccionesMayoresALimiteMayor() {
        ArrayList<ClienteDTO> retorno = new ArrayList<>();
        String sql = "SELECT cl.codigo as cc, cl.nombre, cl.dpi, cl.sexo, cl.direccion, cl.nacimiento, "
                + "(SELECT SUM(ABS(t2.monto)) FROM Transaccion t2, Cuenta c WHERE t2.cuenta = c.codigo AND c.cliente = cc) AS ddd"
                + " FROM Cuenta cu inner join Cliente cl inner join Transaccion t inner join Configuracion con "
                + "ON (cu.codigo = t.cuenta AND (SELECT SUM(ABS(monto)) FROM Transaccion WHERE cuenta = cu.codigo) > con.limite_mayor AND cl.codigo = cu.cliente) GROUP BY cl.codigo ORDER BY ddd DESC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClienteDTO temporal = new ClienteDTO(rs.getLong(1), rs.getString(2), rs.getString(6), rs.getString(3), rs.getString(5), rs.getString(4));
                temporal.setMontoMayor(rs.getDouble(7));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerCajeroMasTransacciones() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    public ArrayList<ClienteDTO> clientesConMásDineroEnCuentas() {
        ArrayList<ClienteDTO> retorno = new ArrayList<>();
        String sql = "SELECT SUM(c.credito) AS suma, cl.nombre , cl.codigo, cl.sexo, cl.nacimiento, cl.dpi, cl.direccion "
                + "FROM Cuenta c, Cliente cl "
                + "WHERE cl.codigo = c.cliente "
                + "GROUP BY cl.codigo "
                + "ORDER BY suma "
                + "DESC LIMIT 10";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClienteDTO temporal = new ClienteDTO(rs.getLong(3), rs.getString(2), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(4));
                temporal.setMontoMayor(rs.getDouble(1));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerCajeroMasTransacciones() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }
    /**
     * Método para obtener las 15 transacciones más grandes de una cuenta
     * @param codigo de la cuenta
     * @return listado de las 15 transacciones más grandes
     */
    public ArrayList<TransaccionDTO> obtener15Transacciones(long codigo) {
        String sql = "SELECT codigo, cuenta, cajero, ABS(monto), creacion, tipo FROM Transaccion "
                + "WHERE YEAR(DATE(creacion)) = YEAR(CURDATE()) AND cuenta = ? "
                + "ORDER BY ABS(monto) DESC LIMIT 15";
        ArrayList<TransaccionDTO> retorno = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TransaccionDTO temporal = new TransaccionDTO(rs.getLong(1),rs.getLong(2),
                        rs.getLong(3),rs.getDouble(4),
                        rs.getString(5),rs.getString(6));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerCajeroMasTransacciones() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }
}
