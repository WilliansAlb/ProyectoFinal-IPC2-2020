/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.ConfiguracionDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class ConfiguracionDAO {
    Connection cn;
    
    public ConfiguracionDAO(Conector cn){
        this.cn = cn.getConexion();
    }
    
    public ConfiguracionDTO obtenerConfiguracion(){
        ConfiguracionDTO configuracion = new ConfiguracionDTO();
        String sql = "SELECT * FROM Configuracion";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                configuracion.setLimite_menor(rs.getDouble(2));
                configuracion.setLimite_mayor(rs.getDouble(3));
            }
        } catch (SQLException sqle){
            System.err.print("ERROR en metodo obtenerConfiguracion() de clase ConfiguracionDAO() por "+sqle);
        }
        String sql2 = "SELECT * FROM Turno WHERE codigo = 'M' OR codigo = 'V' ORDER BY codigo ASC";
        
        try(PreparedStatement ps = cn.prepareStatement(sql2)){
            ResultSet rs2 = ps.executeQuery();
            while (rs2.next()){
                if (rs2.getString("codigo").equalsIgnoreCase("M")){
                    configuracion.setD_matutino(rs2.getString("hora_inicio"));
                    configuracion.setH_matutino(rs2.getString("hora_final"));
                } else {
                    configuracion.setD_vespertino(rs2.getString("hora_inicio"));
                    configuracion.setH_vespertino(rs2.getString("hora_final"));
                }
            }
        } catch (SQLException sqle){
            System.err.print("ERROR en metodo obtenerConfiguracion() de clase ConfiguracionDAO() por "+sqle);
        }
        return configuracion;
    }
}
