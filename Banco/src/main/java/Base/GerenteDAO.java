/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.GerenteDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author yelbetto
 */
public class GerenteDAO {
    
    Connection cn;
    
    public GerenteDAO(Conector cn){
        this.cn = cn.getConexion();
    }
    
    public boolean ingresarGerente(GerenteDTO gerente){
        String sql = "INSERT INTO Gerente(codigo,nombre,turno,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Gerente WHERE dpi = ?);";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setInt(1, gerente.getCodigo());
            ps.setString(2, gerente.getNombre());
            ps.setString(3, gerente.getTurno());
            ps.setString(4, gerente.getSexo());
            ps.setString(5, gerente.getDpi());
            ps.setString(6, gerente.getDireccion());
            ps.setString(7, gerente.getDpi());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarGerente() de la clase GerenteDAO por: "+sqle);
            System.out.print("Error en método ingresarGerente() de la clase GerenteDAO por: "+sqle);
        }
        return ingresado;
    }
}
