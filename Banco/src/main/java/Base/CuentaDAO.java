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

    public boolean ingresarCuenta(CuentaDTO cuenta) {
        String sql = "INSERT INTO Cuenta(codigo,credito,cliente,creacion) "
                + " SELECT ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cuenta WHERE codigo = ?);";
        boolean ingresado = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cuenta.getCodigo());
            ps.setDouble(2, cuenta.getCredito());
            ps.setInt(3, cuenta.getCliente());
            ps.setString(4, cuenta.getCreacion());
            ps.setLong(5, cuenta.getCodigo());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("Error en método ingresarCuenta() de la clase CuentaDAO por: " + sqle);
            System.out.print("Error en método ingresarCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return ingresado;
    }

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
            System.out.print("Error en método actualizarSaldo() de la clase CuentaDAO por: " + sqle);
        }
        return ingresado;
    }

    public long crearCuenta(CuentaDTO cuenta) {
        String sql = "INSERT INTO Cuenta(credito,cliente,creacion) VALUES(?,?,?)";
        long ingresado = -1;
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setDouble(1, cuenta.getCredito());
            ps.setInt(2, cuenta.getCliente());
            ps.setString(3, cuenta.getCreacion());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while (rs.next()) {
                ingresado = rs.getLong(1);
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método crearCuenta() de la clase CuentaDAO por: " + sqle);
            System.out.print("Error en método crearCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return ingresado;
    }

    public CuentaDTO existeCuenta(long cuenta) {
        String sql = "SELECT * FROM Cuenta WHERE codigo = ?";
        CuentaDTO existe = new CuentaDTO();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cuenta);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                existe = new CuentaDTO(cuenta,rs.getDouble("credito"),rs.getInt("cliente"),rs.getString("creacion"));
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método existeCuenta() de la clase CuentaDAO por: " + sqle);
            System.out.print("Error en método existeCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return existe;
    }
    
    public CuentaDTO existeCuenta(long cuenta, int codigo) {
        String sql = "SELECT * FROM Cuenta WHERE codigo = ? AND cliente = ?";
        CuentaDTO existe = new CuentaDTO();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cuenta);
            ps.setInt(2, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                existe = new CuentaDTO(cuenta,rs.getDouble("credito"),rs.getInt("cliente"),rs.getString("creacion"));
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método existeCuenta() de la clase CuentaDAO por: " + sqle);
            System.out.print("Error en método existeCuenta() de la clase CuentaDAO por: " + sqle);
        }
        return existe;
    }

    public ArrayList<CuentaDTO> obtenerCuentas(int codigo) {
        String sql = "SELECT * FROM Cuenta WHERE cliente = ?";
        ArrayList<CuentaDTO> cuentas = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CuentaDTO temporal = new CuentaDTO(rs.getLong("codigo"), rs.getDouble("credito"), codigo, rs.getString("creacion"));
                cuentas.add(temporal);
            }

        } catch (SQLException sqle) {
            System.err.print("Error en método obtenerCuentas() de la clase CuentaDAO por: " + sqle);
            System.out.print("Error en método obtenerCuentas() de la clase CuentaDAO por: " + sqle);
        }
        return cuentas;
    }
    public ArrayList<CuentaDTO> obtenerCuentasAsociadas(int codigo) {
        String sql = "SELECT c.codigo, c.credito, c.cliente, c.creacion FROM Asociacion a, Cuenta c WHERE a.cliente = ? AND a.cuenta = c.codigo AND a.estado = ?;";
        ArrayList<CuentaDTO> cuentas = new ArrayList<>();
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            ps.setString(2, "ACEPTADA");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CuentaDTO temporal = new CuentaDTO(rs.getLong(1), rs.getDouble(2), rs.getInt(3), rs.getString(4));
                cuentas.add(temporal);
            }

        } catch (SQLException sqle) {
            System.err.print("Error en método obtenerCuentasAsociadas() de la clase CuentaDAO por: " + sqle);
            System.out.print("Error en método obtenerCuentasAsociadas() de la clase CuentaDAO por: " + sqle);
        }
        return cuentas;
    }

}
