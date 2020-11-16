/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class HistorialDAO {
    Connection cn;
    
    public HistorialDAO(Conector cn){
        this.cn = cn.getConexion();
    }
    
    public boolean ingresarHistorialTransaccion(long transaccion, Double anterior, Double actual){
        String sql = "INSERT INTO Historial(transaccion,anterior,actual) VALUES(?,?,?)";
        boolean ingresado = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, transaccion);
            ps.setDouble(2, anterior);
            ps.setDouble(3, actual);
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("ERROR: metodo ingresarHistorialTransaccion() en clase HistorialDAO por "+sqle);
        }
        return ingresado;
    }
}
