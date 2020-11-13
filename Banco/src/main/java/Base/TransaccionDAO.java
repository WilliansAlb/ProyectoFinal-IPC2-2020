/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.TransaccionDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author yelbetto
 */
public class TransaccionDAO {

    Connection cn;

    public TransaccionDAO(Conector cn) {
        this.cn = cn.getConexion();
    }

    public boolean ingresarTransaccion(TransaccionDTO transaccion) {
        String sql = "INSERT INTO Transaccion(codigo,cuenta,cajero,monto,creacion,tipo) "
                + "SELECT ?, ?, ?, ?, ?, ? FROM dual WHERE "
                + "(SELECT COUNT(*) AS total FROM Cuenta WHERE codigo = ? && credito > ?) > 0 OR ? ='C';";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setInt(1, transaccion.getCodigo());
            ps.setLong(2, transaccion.getCuenta());
            ps.setInt(3, transaccion.getCajero());
            ps.setDouble(4, transaccion.getMonto());
            ps.setString(5, transaccion.getCreacion());
            ps.setString(6, transaccion.getTipo());
            ps.setLong(7, transaccion.getCuenta());
            ps.setDouble(8, transaccion.getMonto());
            ps.setString(9, transaccion.getTipo());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarTransaccion() de la clase TransaccionDAO por: "+sqle);
            System.out.print("Error en método ingresarTransaccion() de la clase TransaccionDAO por: "+sqle);
        }
        return ingresado;
    }
    /**
     * Método para ingresar nuevas transacciones y recuperar codigo de la transaccion nueva
     * @param transaccion
     * @return el codigo de la transaccion
     */
    public int ingresarTransaccionRetorno(TransaccionDTO transaccion) {
        String sql = "INSERT INTO Transaccion(cuenta,cajero,monto,creacion,tipo) "
                + "SELECT ?, ?, ?, ?, ? FROM dual WHERE "
                + "(SELECT COUNT(*) AS total FROM Cuenta WHERE codigo = ? && credito > ?) > 0 OR ? ='C';";
        int ingresado = -1;
        
        try(PreparedStatement ps = cn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            ps.setLong(1, transaccion.getCuenta());
            ps.setInt(2, transaccion.getCajero());
            ps.setDouble(3, transaccion.getMonto());
            ps.setString(4, transaccion.getCreacion());
            ps.setString(5, transaccion.getTipo());
            ps.setLong(6, transaccion.getCuenta());
            ps.setDouble(7, transaccion.getMonto());
            ps.setString(8, transaccion.getTipo());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while(rs.next()){
                ingresado = rs.getInt(1);
            }
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarTransaccionRetorno() de la clase TransaccionDAO por: "+sqle);
            System.out.print("Error en método ingresarTransaccionRetorno() de la clase TransaccionDAO por: "+sqle);
        }
        return ingresado;
    }
    
    public boolean existeTransaccion(TransaccionDTO transaccion){
        String sql = "SELECT COUNT(*) AS total FROM Transaccion WHERE codigo = ?";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setInt(1, transaccion.getCodigo());
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                ingresado = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeTransaccion() de la clase TransaccionDAO por: "+sqle);
            System.out.print("Error en método existeTransaccion() de la clase TransaccionDAO por: "+sqle);
        }
        return ingresado;
    }
}
