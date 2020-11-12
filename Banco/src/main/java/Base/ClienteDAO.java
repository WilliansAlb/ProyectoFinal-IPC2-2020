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
import java.sql.Statement;
import java.util.ArrayList;

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
    
    public boolean existeClienteDPI(ClienteDTO cliente){
        String sql = "SELECT COUNT(*) AS total FROM Cliente WHERE dpi = ?";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cliente.getDpi());
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
    
    public ClienteDTO obtenerCliente(ClienteDTO cliente){
        String sql = "SELECT codigo, nombre, direccion, sexo, nacimiento FROM Cliente WHERE dpi = ?";
        ClienteDTO retorno = new ClienteDTO();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cliente.getDpi());
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                retorno.setCodigo(rs.getInt("codigo"));
                retorno.setNombre(rs.getString("nombre"));
                retorno.setDireccion(rs.getString("direccion"));
                retorno.setSexo(rs.getString("sexo"));
                retorno.setFecha(rs.getString("nacimiento"));
                retorno.setDpi(cliente.getDpi());
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeCliente() de la clase ClienteDAO() por: "+sqle);
            System.out.print("Error en método existeCliente() de la clase ClienteDAO() por: "+sqle);
        }
        return retorno;
    }
    
    public ArrayList<ClienteDTO> obtenerClientes(){
        String sql = "SELECT * FROM Cliente";
        ArrayList<ClienteDTO> listaCliente = new ArrayList<>();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                ClienteDTO retorno = new ClienteDTO();
                retorno.setCodigo(rs.getInt("codigo"));
                retorno.setNombre(rs.getString("nombre"));
                retorno.setDireccion(rs.getString("direccion"));
                retorno.setSexo(rs.getString("sexo"));
                retorno.setFecha(rs.getString("nacimiento"));
                retorno.setDpi(rs.getString("dpi"));
                listaCliente.add(retorno);
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeCliente() de la clase ClienteDAO() por: "+sqle);
            System.out.print("Error en método existeCliente() de la clase ClienteDAO() por: "+sqle);
        }
        return listaCliente;
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
     public int crearCliente(ClienteDTO cliente, InputStream archivo){
        String sql = "INSERT INTO Cliente(nombre,nacimiento,sexo,dpi,direccion,pdf) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cliente WHERE dpi = ?);";
        int ingresado = -1;
        try(PreparedStatement ps = cn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getFecha());
            ps.setString(3, cliente.getSexo());
            ps.setString(4, cliente.getDpi());
            ps.setString(5, cliente.getDireccion());
            ps.setBlob(6, archivo);
            ps.setString(7, cliente.getDpi());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while(rs.next()){
                ingresado = rs.getInt(1);
            }
            
        } catch (SQLException sqle){
            System.err.print("Error en método crearCliente() de la clase ClienteDAO por: "+sqle);
            System.out.print("Error en método crearCliente() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
     
     public boolean actualizarCliente(ClienteDTO cliente, InputStream archivo){
        String sql = "UPDATE Cliente SET nombre = ?,nacimiento = ?,sexo = ?,dpi = ?,direccion = ?,pdf = ? WHERE codigo = ?";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getFecha());
            ps.setString(3, cliente.getSexo());
            ps.setString(4, cliente.getDpi());
            ps.setString(5, cliente.getDireccion());
            ps.setBlob(6, archivo);
            ps.setInt(7, cliente.getCodigo());
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("Error en método actualizarCliente() de la clase ClienteDAO por: "+sqle);
            System.out.print("Error en método actualizarCliente() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
     
     public boolean actualizarClienteSinPDF(ClienteDTO cliente){
        String sql = "UPDATE Cliente SET nombre = ?,nacimiento = ?,sexo = ?,dpi = ?,direccion = ? WHERE codigo = ?";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getFecha());
            ps.setString(3, cliente.getSexo());
            ps.setString(4, cliente.getDpi());
            ps.setString(5, cliente.getDireccion());
            ps.setInt(6, cliente.getCodigo());
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("Error en método actualizarClienteSinPDF() de la clase ClienteDAO por: "+sqle);
            System.out.print("Error en método actualizarClienteSinPDF() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
}
