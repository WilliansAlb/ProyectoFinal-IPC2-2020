/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.AccionDTO;
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
public class AccionDAO {
    
    Connection cn;
    
    public AccionDAO(Conector cn){
        this.cn = cn.getConexion();
    }
    
    public int ingresarAccion(String descripcion, long gerente, String realizacion, String entidad){
        String sql = "INSERT INTO Accion(descripcion,gerente,realizacion, entidad) VALUES(?,?,?,?)";
        int ingreso = -1;
        try (PreparedStatement ps = cn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            ps.setString(1, descripcion);
            ps.setLong(2,gerente);
            ps.setString(3, realizacion);
            ps.setString(4, entidad);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while (rs.next()){
                ingreso = rs.getInt(1);
            }
        } catch (SQLException sqle){
            System.err.print("ERROR: en metodo ingresarAccion() de clase AccionDAO por "+sqle);
        }
        return ingreso;
    }
    
    public ArrayList<AccionDTO> listadoAcciones(long gerente){
        String sql = "SELECT * FROM Accion WHERE gerente = ? ORDER BY realizacion DESC";
        ArrayList<AccionDTO> acciones = new ArrayList<>();
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, gerente);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                System.out.println(rs.getInt("codigo"));
                AccionDTO temporal = new AccionDTO(rs.getInt("codigo"),rs.getString("descripcion"),rs.getLong("gerente"),rs.getString("realizacion"),rs.getString("entidad"));
                acciones.add(temporal);
            }
        } catch (SQLException sqle){
            System.err.print("ERROR: en metodo listadoAccines() de clase AccionDAO por "+sqle);
        }
        
        return acciones;
    }
    
    public ArrayList<AccionDTO> listadoAcciones(long gerente,String entidad){
        String sql = "SELECT * FROM Accion WHERE gerente = ? AND entidad = ? ORDER BY codigo DESC";
        ArrayList<AccionDTO> acciones = new ArrayList<>();
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, gerente);
            ps.setString(2, entidad);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                AccionDTO temporal = new AccionDTO(rs.getInt("codigo"),rs.getString("descripcion"),rs.getLong("gerente"),rs.getString("realizacion"),rs.getString("entidad"));
                acciones.add(temporal);
            }
        } catch (SQLException sqle){
            System.err.print("ERROR: en metodo listadoAccines() de clase AccionDAO por "+sqle);
        }
        
        return acciones;
    }
    
}
