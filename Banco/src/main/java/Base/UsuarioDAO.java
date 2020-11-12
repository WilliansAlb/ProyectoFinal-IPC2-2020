/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.UsuarioDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author yelbetto
 */
public class UsuarioDAO {
    
    Connection cn;
    
    public UsuarioDAO(Conector cn){
        this.cn = cn.getConexion();
    }
    
    public boolean ingresarUsuario(UsuarioDTO usuario){
        boolean ingresado = false;
        String sql = "INSERT INTO Usuario(id,codigo,contra,tipo) "
                + " SELECT ?, ?, md5(?), ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Usuario WHERE codigo = ? && tipo = ?);";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, usuario.getId());
            ps.setInt(2, usuario.getCodigo());
            ps.setString(3, usuario.getContra());
            ps.setString(4, usuario.getTipo());
            ps.setInt(5, usuario.getCodigo());
            ps.setString(6, usuario.getTipo());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle){
            System.err.print("Error en método ingresarUsuario() de la clase UsuarioDAO por: "+sqle);
            System.out.print("Error en método ingresarUsuario() de la clase UsuarioDAO por: "+sqle);
        }
        return ingresado;
    }
    
    public UsuarioDTO obtenerUsuario(String id, String password){
        UsuarioDTO usuario = new UsuarioDTO();
        String sql = "SELECT id, codigo, tipo FROM Usuario WHERE id = ? AND contra = md5(?)";
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, id);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                usuario.setCodigo(rs.getInt("codigo"));
                usuario.setId(id);
                usuario.setContra(password);
                usuario.setTipo(rs.getString("tipo"));
            }
        } catch (SQLException ex) {
            System.err.print("ERROR en metodo obtenerUsuario() de clase UsuarioDAO por "+ex);
            System.out.print("ERROR en metodo obtenerUsuario() de clase UsuarioDAO por "+ex);
        }
        return usuario;
    }
}
