/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.ClienteDTO;
import DTO.TransaccionDTO;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class ClienteDAO {
    
    Connection cn;
    
    public ClienteDAO(Conector cn){
        this.cn = cn.getConexion();
    }
    
    public boolean ingresarCliente(ClienteDTO cliente){
        String sql = "INSERT INTO Cliente(codigo,nombre,nacimiento,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cliente WHERE dpi = ?);";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setInt(1, cliente.getCodigo());
            ps.setString(2, cliente.getNombre());
            ps.setString(3, cliente.getFecha());
            ps.setString(4, cliente.getSexo());
            ps.setString(5, cliente.getDpi());
            ps.setString(6, cliente.getDireccion());
            ps.setString(7, cliente.getDpi());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarCliente() de la clase ClienteDAO por: "+sqle);
            System.out.print("Error en método ingresarCliente() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
    
    public boolean existeCliente(ClienteDTO cliente){
        String sql = "SELECT COUNT(*) AS total FROM Cliente WHERE codigo = ?";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setInt(1, cliente.getCodigo());
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                ingresado = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeCliente() de la clase ClienteDAO() por: "+sqle);
            System.out.print("Error en método existeCliente() de la clase ClienteDAO() por: "+sqle);
        }
        return ingresado;
    }
    
    public boolean ingresarArchivo(InputStream archivo, ClienteDTO cliente){
        String sql = "UPDATE Cliente SET pdf = ? WHERE codigo = ?";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setBlob(1, archivo);
            ps.setInt(2, cliente.getCodigo());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarArchivo() de la clase ClienteDAO por: "+sqle);
            System.out.print("Error en método ingresarArchivo() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
}
