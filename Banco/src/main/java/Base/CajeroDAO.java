/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.CajeroDTO;
import DTO.GerenteDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class CajeroDAO {
    
    Connection cn;
    
    public CajeroDAO(Conector cn){
        this.cn = cn.getConexion();
    }
    
    public boolean ingresarCajero(CajeroDTO cajero){
        String sql = "INSERT INTO Cajero(codigo,nombre,turno,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cajero WHERE dpi = ?);";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setInt(1, cajero.getCodigo());
            ps.setString(2, cajero.getNombre());
            ps.setString(3, cajero.getTurno());
            ps.setString(4, cajero.getSexo());
            ps.setString(5, cajero.getDpi());
            ps.setString(6, cajero.getDireccion());
            ps.setString(7, cajero.getDpi());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarCajero() de la clase CajeroDAO por: "+sqle);
            System.out.print("Error en método ingresarCajero() de la clase CajeroDAO por: "+sqle);
        }
        return ingresado;
    }
    
}
