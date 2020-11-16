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
    /**
     * Método para ingresar un cliente en la base de datos
     * @param cliente con todos los parametros correctos
     * @return true si se logró ingresar el cliente
     */
    public boolean ingresarCliente(ClienteDTO cliente){
        String sql = "INSERT INTO Cliente(codigo,nombre,nacimiento,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cliente WHERE dpi = ?);";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, cliente.getCodigo());
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
    /**
     * Método que verifica si existe el cliente con el codigo enviado
     * @param cliente con el parametro codigo diferente de null
     * @return true si existe el cliente
     */
    public boolean existeCliente(ClienteDTO cliente){
        String sql = "SELECT COUNT(*) AS total FROM Cliente WHERE codigo = ?";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, cliente.getCodigo());
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
    /**
     * Método que verifica si existe el cliente con el dpi enviado
     * @param cliente con el parametro dpi diferente de null
     * @return true si existe el cliente
     */
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
        }
        return ingresado;
    }
    /**
     * Método que devuelve el cliente actual
     * @param cliente con el unico parametro dpi diferente de null
     * @return cliente con datos completos
     */
    public ClienteDTO obtenerCliente(ClienteDTO cliente){
        String sql = "SELECT codigo, nombre, direccion, sexo, nacimiento FROM Cliente WHERE dpi = ?";
        ClienteDTO retorno = new ClienteDTO();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cliente.getDpi());
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                retorno.setCodigo(rs.getLong("codigo"));
                retorno.setNombre(rs.getString("nombre"));
                retorno.setDireccion(rs.getString("direccion"));
                retorno.setSexo(rs.getString("sexo"));
                retorno.setFecha(rs.getString("nacimiento"));
                retorno.setDpi(cliente.getDpi());
            }
        } catch (SQLException sqle){
            System.err.print("Error en método obtenerCliente() de la clase ClienteDAO() por: "+sqle);
        }
        return retorno;
    }
    /**
     * Método que obtiene el cliente con el codigo especificado
     * @param cliente entidad cliente con unicamente el codigo diferente de null
     * @return cliente con datos completos
     */
    public ClienteDTO obtenerClienteConCodigo(ClienteDTO cliente){
        String sql = "SELECT codigo, dpi, nombre, direccion, sexo, nacimiento FROM Cliente WHERE codigo = ?";
        ClienteDTO retorno = new ClienteDTO();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, cliente.getCodigo());
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                retorno.setCodigo(rs.getLong("codigo"));
                retorno.setNombre(rs.getString("nombre"));
                retorno.setDireccion(rs.getString("direccion"));
                retorno.setSexo(rs.getString("sexo"));
                retorno.setFecha(rs.getString("nacimiento"));
                retorno.setDpi(rs.getString("dpi"));
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeClienteConCodigo() de la clase ClienteDAO() por: "+sqle);
        }
        return retorno;
    }
    /**
     * Método que obtiene el cliente con el codigo especificado
     * @param codigo del cliente
     * @return cliente
     */
    public ClienteDTO obtenerClienteConCodigo(long codigo){
        String sql = "SELECT codigo, nombre, direccion, sexo, nacimiento, dpi FROM Cliente WHERE codigo = ?";
        ClienteDTO retorno = new ClienteDTO();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                retorno.setCodigo(rs.getLong("codigo"));
                retorno.setNombre(rs.getString("nombre"));
                retorno.setDireccion(rs.getString("direccion"));
                retorno.setSexo(rs.getString("sexo"));
                retorno.setFecha(rs.getString("nacimiento"));
                retorno.setDpi(rs.getString("dpi"));
            }
        } catch (SQLException sqle){
            System.err.print("Error en método obtenerClienteConCodigo() de la clase ClienteDAO() por: "+sqle);
        }
        return retorno;
    }
    /**
     * Método para obtener todos los clientes que se tienen
     * @return listado de todos los clientes que existen
     */
    public ArrayList<ClienteDTO> obtenerClientes(){
        String sql = "SELECT * FROM Cliente";
        ArrayList<ClienteDTO> listaCliente = new ArrayList<>();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                ClienteDTO retorno = new ClienteDTO();
                retorno.setCodigo(rs.getLong("codigo"));
                retorno.setNombre(rs.getString("nombre"));
                retorno.setDireccion(rs.getString("direccion"));
                retorno.setSexo(rs.getString("sexo"));
                retorno.setFecha(rs.getString("nacimiento"));
                retorno.setDpi(rs.getString("dpi"));
                listaCliente.add(retorno);
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeCliente() de la clase ClienteDAO() por: "+sqle);
        }
        return listaCliente;
    }
    /**
     * Método que se encarga de ingresar el archivo pdf del dpi del cliente
     * @param archivo
     * @param cliente
     * @return true si se logró cambiar el archivo pdf
     */
    public boolean ingresarArchivo(InputStream archivo, ClienteDTO cliente){
        String sql = "UPDATE Cliente SET pdf = ? WHERE codigo = ?";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setBlob(1, archivo);
            ps.setLong(2, cliente.getCodigo());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarArchivo() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
    /**
     * Método para crear un nuevo cliente ingresando el cliente y el archivo pdf del mismo
     * @param cliente
     * @param archivo
     * @return codigo del cliente
     */
     public long crearCliente(ClienteDTO cliente, InputStream archivo){
        String sql = "INSERT INTO Cliente(nombre,nacimiento,sexo,dpi,direccion,pdf) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cliente WHERE dpi = ?);";
        long ingresado = -1;
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
                ingresado = rs.getLong(1);
            }
            
        } catch (SQLException sqle){
            System.err.print("Error en método crearCliente() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
     /**
      * Método para actualizar los datos del cliente cuando si se le envia un archivo pdf para el cliente
      * @param cliente
      * @param archivo
      * @return true si se lograron actualizar los datos del cliente junto al pdf
      */
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
            ps.setLong(7, cliente.getCodigo());
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("Error en método actualizarCliente() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
     /**
      * Método para actualizar los datos del cliente cuando no se envia pdf
      * @param cliente
      * @return true si se lograron actualizar los cambios en la entidad cliente
      */
     public boolean actualizarClienteSinPDF(ClienteDTO cliente){
        String sql = "UPDATE Cliente SET nombre = ?,nacimiento = ?,sexo = ?,dpi = ?,direccion = ? WHERE codigo = ?";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getFecha());
            ps.setString(3, cliente.getSexo());
            ps.setString(4, cliente.getDpi());
            ps.setString(5, cliente.getDireccion());
            ps.setLong(6, cliente.getCodigo());
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("Error en método actualizarClienteSinPDF() de la clase ClienteDAO por: "+sqle);
        }
        return ingresado;
    }
}
