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
            System.err.print("ERROR: en método clientesTransaccionesMayoresALimiteMenor() en clase ReporteDAO por " + sqle);
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
            System.err.print("ERROR: en método clientesTransaccionesMayoresALimiteMayor() en clase ReporteDAO por " + sqle);
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
            System.err.print("ERROR: en método clientesConMásDineroEnCuentas() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    /**
     * Método para obtener las 15 transacciones más grandes de una cuenta
     *
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
                TransaccionDTO temporal = new TransaccionDTO(rs.getLong(1), rs.getLong(2),
                        rs.getLong(3), rs.getDouble(4),
                        rs.getString(5), rs.getString(6));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtener15Transacciones() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    /**
     * Método que devuelve los datos para el reporte de los cliente que no han
     * hecho transacciones en cierto intervalo de tiempo
     *
     * @param fecha1
     * @param fecha2
     * @return
     */
    public ArrayList<ClienteDTO> clientesSinTransaccionesIntervalo(String fecha1, String fecha2) {
        ArrayList<ClienteDTO> retorno = new ArrayList<>();
        String sql = "SELECT c.codigo, c.nombre, c.dpi, c.direccion, c.sexo, c.nacimiento FROM Cliente c WHERE"
                + " (SELECT COUNT(*) FROM Transaccion t, Cuenta cu WHERE"
                + " t.cuenta = cu.codigo AND c.codigo = cu.cliente AND DATE(t.creacion) BETWEEN ? AND ?) = 0;";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fecha1);
            ps.setString(2, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClienteDTO temporal = new ClienteDTO(rs.getLong(1), rs.getString(2), rs.getString(6), rs.getString(3), rs.getString(4), rs.getString(5));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método clientesSinTransaccionesIntervalo() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    /**
     * Método para el reporte de Listado de todas las transacciones realizadas
     * dentro de un intervalo de tiempo mostrando el cambio del dinero de la
     * cuenta por cada transacción
     *
     * @param codigo el codigo del cliente
     * @param fecha1 fecha inicio del intervalo
     * @param fecha2 fecha final del intervalo
     * @return listado de todas las transacciones realizadas
     */
    public ArrayList<TransaccionDTO> obtenerTransaccionesSaldoAnteriorActual(long codigo, String fecha1, String fecha2) {
        String sql = "SELECT t.codigo, t.cuenta, t.cajero,t.creacion, t.tipo, h.anterior,t.monto,h.actual FROM Transaccion t,Cuenta cu, Historial h "
                + "WHERE t.codigo = h.transaccion AND t.cuenta = cu.codigo AND cu.cliente = ? "
                + "AND DATE(t.creacion) BETWEEN ? AND ? ORDER BY t.creacion DESC";
        ArrayList<TransaccionDTO> retorno = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, codigo);
            ps.setString(2, fecha1);
            ps.setString(3, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TransaccionDTO temporal = new TransaccionDTO(rs.getLong(1), rs.getLong(2), rs.getLong(3), rs.getDouble(7), rs.getString(4), rs.getString(5));
                temporal.setAnterior(rs.getDouble(6));
                temporal.setActual(rs.getDouble(8));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerTransaccionesSaldoAnteriorActual() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    /**
     * Método para obtener la cuenta que tiene más dinero de un cliente en
     * especifico
     *
     * @param codigo
     * @return cuenta con todos los datos llenos
     */
    public CuentaDTO obtenerCuentaConMásDinero(long codigo) {
        String sql = "SELECT * FROM Cuenta WHERE cliente = ? ORDER BY credito DESC LIMIT 1";
        CuentaDTO retorno = new CuentaDTO();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                retorno.setCodigo(rs.getLong("codigo"));
                retorno.setCliente(codigo);
                retorno.setCreacion(rs.getString("creacion"));
                retorno.setCredito(rs.getDouble("credito"));
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerCuentaConMásDinero() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }

    /**
     * Método que devuelve las transacciones de una cuenta desde una fecha en
     * especifico hasta la fecha en curso
     *
     * @param cuenta
     * @param fecha
     * @return listado de transacciones
     */
    public ArrayList<TransaccionDTO> obtenerTransaccionesDesdeHastaFechaActual(long cuenta, String fecha) {
        String sql = "SELECT * FROM Transaccion WHERE cuenta = ? AND DATE(creacion) BETWEEN ? AND DATE(CURDATE()) ORDER BY creacion DESC;";
        ArrayList<TransaccionDTO> retorno = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cuenta);
            ps.setString(2, fecha);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TransaccionDTO temporal = new TransaccionDTO(rs.getLong("codigo"), rs.getLong("cuenta"),
                        rs.getLong("cajero"), rs.getDouble("monto"), rs.getString("creacion"), rs.getString("tipo"));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerTransaccionesDesdeHastaFechaActual() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }
    /**
     * Método para rellenar el reporte de Listado de las transacciones realizadas por día en un intervalo de tiempo, mostrando el balance final
     * @param cajero
     * @param fecha1
     * @param fecha2
     * @return listado de balance final
     */
    public ArrayList<BalanceDTO> obtenerBalanceFinal(long cajero, String fecha1, String fecha2) {
        String sql = "SELECT DATE(creacion) AS fecha, cajero AS cCajero,"
                + " (SELECT IFNULL(SUM(ABS(monto)),0) FROM Transaccion"
                + " WHERE tipo = 'DEBITO' AND DATE(creacion) = fecha AND cajero = cCajero) AS retiros,"
                + " (SELECT IFNULL(SUM(ABS(monto)),0) FROM Transaccion"
                + " WHERE tipo = 'CREDITO' AND DATE(creacion) = fecha AND cajero = cCajero) AS depositos,"
                + " (SELECT depositos - retiros FROM dual) AS balance FROM Transaccion"
                + " WHERE DATE(creacion) BETWEEN ? AND ? AND cajero = ? GROUP BY DATE(creacion);";
        ArrayList<BalanceDTO> retorno = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(3, cajero);
            ps.setString(1, fecha1);
            ps.setString(2, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BalanceDTO nuevo = new BalanceDTO();
                nuevo.setFecha(rs.getString(1));
                nuevo.setCajero(cajero);
                nuevo.setRetiro(rs.getDouble(3));
                nuevo.setDeposito(rs.getDouble(4));
                nuevo.setBalance(rs.getDouble(5));
                nuevo.setTransacciones(obtenerTransaccionesSegúnDía(cajero,rs.getString(1)));
                retorno.add(nuevo);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtenerBalanceFinal() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }
    /**
     * Método que devuelve las transacciones según el día 
     * @param codigo
     * @param fecha
     * @return listado de las transacciones
     */
    public ArrayList<TransaccionDTO> obtenerTransaccionesSegúnDía(long codigo, String fecha) {
        String sql = "SELECT codigo, cuenta, monto, creacion, tipo FROM Transaccion WHERE cajero = ? AND DATE(creacion) = ?";
        ArrayList<TransaccionDTO> retorno = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, codigo);
            ps.setString(2, fecha);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TransaccionDTO temporal = new TransaccionDTO();
                temporal.setCodigo(rs.getLong(1));
                temporal.setCuenta(rs.getLong(2));
                temporal.setMonto(rs.getDouble(3));
                temporal.setCreacion(rs.getString(4));
                temporal.setTipo(rs.getString(5));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: en método obtener15Transacciones() en clase ReporteDAO por " + sqle);
        }
        return retorno;
    }
}
