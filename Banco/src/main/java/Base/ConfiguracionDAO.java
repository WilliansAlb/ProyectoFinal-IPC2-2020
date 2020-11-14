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
import java.sql.Statement;
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
    
    public boolean existeConfiguracion(){
        boolean existe = false;
        String sql = "SELECT COUNT(*) AS total FROM Configuracion";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                existe = rs.getInt("total") == 1;
            }
        } catch (SQLException sqle){
            System.err.print("ERROR en metodo obtenerConfiguracion() de clase ConfiguracionDAO() por "+sqle);
        }
        return existe;
    }
    
    public int ingresarConfiguracion(ConfiguracionDTO con){
        int existe = -1;
        String sql = "INSERT INTO Configuracion(limite_menor,limite_mayor) VALUES(?,?)";
        try(PreparedStatement ps = cn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            ps.setDouble(1, con.getLimite_menor());
            ps.setDouble(2, con.getLimite_mayor());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while(rs.next()){
                existe = rs.getInt(1);
            }
        } catch (SQLException sqle){
            System.err.print("ERROR en metodo ingresarConfiguracion() de clase ConfiguracionDAO() por "+sqle);
        }
        return existe;
    }
    
    public boolean actualizarConfiguracion(Double limite_menor, Double limite_mayor){
        boolean actualizado = false;
        String sql = "UPDATE Configuracion SET limite_menor = ?, limite_mayor = ? WHERE codigo = 1";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setDouble(1, limite_menor);
            ps.setDouble(2, limite_mayor);
            actualizado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("ERROR en metodo actualizarConfiguracion() de clase ConfiguracionDAO() por "+sqle);
        }
        return actualizado;
    }
    
    public boolean actualizarTurnoMatutino(String desde, String hasta){
        boolean actualizado = false;
        String sql = "UPDATE Turno SET hora_inicio = ?, hora_final = ? WHERE codigo = 'M'";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, desde);
            ps.setString(2, hasta);
            actualizado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("ERROR en metodo actualizarTurnoMatutino() de clase ConfiguracionDAO() por "+sqle);
        }
        return actualizado;
    }
    
    public boolean actualizarTurnoVespertino(String desde, String hasta){
        boolean actualizado = false;
        String sql = "UPDATE Turno SET hora_inicio = ?, hora_final = ? WHERE codigo = 'V'";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, desde);
            ps.setString(2, hasta);
            actualizado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("ERROR en metodo actualizarTurnoVespertino() de clase ConfiguracionDAO() por "+sqle);
        }
        return actualizado;
    }
}
