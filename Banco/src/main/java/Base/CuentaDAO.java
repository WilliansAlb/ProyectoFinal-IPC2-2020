/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.CuentaDTO;
import DTO.TransaccionDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class CuentaDAO {

    Connection cn;

    public CuentaDAO(Conector cn) {
        this.cn = cn.getConexion();
    }
    /**
     * Método que ingresa la cuenta del cliente
     * @param cuenta con todos los datos
     * @return true si se ingresó la cuenta
     */
    public boolean ingresarCuenta(CuentaDTO cuenta) {
        String sql = "INSERT INTO Cuenta(codigo,credito,cliente,creacion) "
                + " SELECT ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cuenta WHERE codigo = ?);";
        boolean ingresado = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cuenta.getCodigo());
            ps.setDouble(2, cuenta.getCredito());
            ps.setLong(3, cuenta.getCliente());
            ps.setString(4, cuenta.getCreacion());
            ps.setLong(5, cuenta.getCodigo());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("Error en método ingresarCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return ingresado;
    }
    /**
     * Método que actualiza el saldo de la cuenta según sea el monto que se envia
     * @param cuenta el codigo de la cuenta
     * @param monto la cantidad que se le quitará a la cuenta
     * @return true si se logró actualizar el saldo
     */
    public boolean actualizarSaldo(long cuenta, Double monto) {
        String sql = "UPDATE Cuenta SET credito = credito + ? WHERE codigo = ?";
        boolean ingresado = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setDouble(1, monto);
            ps.setLong(2, cuenta);
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("Error en método actualizarSaldo() de la clase CuentaDAO por: " + sqle);
        }
        return ingresado;
    }
    /**
     * Método que ingresa una cuenta nueva según los datos enviados
     * @param cuenta con todos los datos completos
     * @return codigo de la cuenta
     */
    public long crearCuenta(CuentaDTO cuenta) {
        String sql = "INSERT INTO Cuenta(credito,cliente,creacion) VALUES(?,?,?)";
        long ingresado = -1;
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setDouble(1, cuenta.getCredito());
            ps.setLong(2, cuenta.getCliente());
            ps.setString(3, cuenta.getCreacion());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while (rs.next()) {
                ingresado = rs.getLong(1);
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método crearCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return ingresado;
    }
    /**
     * Método que verifica la existencia de la cuenta y devuelve todos los datos
     * @param cuenta el codigo de la cuenta
     * @return la cuenta que se busca
     */
    public CuentaDTO existeCuenta(long cuenta) {
        String sql = "SELECT * FROM Cuenta WHERE codigo = ?";
        CuentaDTO existe = new CuentaDTO();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cuenta);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                existe = new CuentaDTO(cuenta,rs.getDouble("credito"),rs.getLong("cliente"),rs.getString("creacion"));
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método existeCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return existe;
    }
    /**
     * Método que devuelve la cuenta que se busca según el codigo y el número de cuenta
     * @param cuenta número de cuenta
     * @param codigo codigo del cliente
     * @return cuenta completa
     */
    public CuentaDTO existeCuenta(long cuenta, long codigo) {
        String sql = "SELECT * FROM Cuenta WHERE codigo = ? AND cliente = ?";
        CuentaDTO existe = new CuentaDTO();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cuenta);
            ps.setLong(2, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                existe = new CuentaDTO(cuenta,rs.getDouble("credito"),rs.getLong("cliente"),rs.getString("creacion"));
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método existeCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return existe;
    }
    /**
     * Método que devuelve todas las cuentas que el cliente tiene
     * @param codigo del cliente
     * @return lista de las cuentas del cliente
     */
    public ArrayList<CuentaDTO> obtenerCuentas(long codigo) {
        String sql = "SELECT * FROM Cuenta WHERE cliente = ?";
        ArrayList<CuentaDTO> cuentas = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CuentaDTO temporal = new CuentaDTO(rs.getLong("codigo"), rs.getDouble("credito"), codigo, rs.getString("creacion"));
                cuentas.add(temporal);
            }

        } catch (SQLException sqle) {
            System.err.print("Error en método obtenerCuentas() de la clase CuentaDAO por: " + sqle);
        }
        return cuentas;
    }
    /**
     * Método que devuelve todas las cuentas de las que está asociado el cliente
     * @param codigo del cliente
     * @return listado de cuentas asociadas
     */
    public ArrayList<CuentaDTO> obtenerCuentasAsociadas(long codigo) {
        String sql = "SELECT c.codigo, c.credito, c.cliente, c.creacion FROM Asociacion a, Cuenta c WHERE a.cliente = ? AND a.cuenta = c.codigo AND a.estado = ?;";
        ArrayList<CuentaDTO> cuentas = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, codigo);
            ps.setString(2, "ACEPTADA");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CuentaDTO temporal = new CuentaDTO(rs.getLong(1), rs.getDouble(2), rs.getLong(3), rs.getString(4));
                cuentas.add(temporal);
            }

        } catch (SQLException sqle) {
            System.err.print("Error en método obtenerCuentasAsociadas() de la clase CuentaDAO por: " + sqle);
        }
        return cuentas;
    }

}
