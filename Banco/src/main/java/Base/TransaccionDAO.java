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
            ps.setInt(2, transaccion.getCuenta());
            ps.setInt(3, transaccion.getCajero());
            ps.setDouble(4, transaccion.getMonto());
            ps.setString(5, transaccion.getCreacion());
            ps.setString(6, transaccion.getTipo());
            ps.setInt(7, transaccion.getCuenta());
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
