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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
    
     public boolean existeCajero(CajeroDTO cajero){
        String sql = "SELECT COUNT(*) AS total FROM Cajero WHERE dpi = ?";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cajero.getDpi());
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                ingresado = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeTransaccion() de la clase TransaccionDAO por: "+sqle);
            System.out.print("Error en método existeTransaccion() de la clase TransaccionDAO por: "+sqle);
        }
        return ingresado;
    }
    
      public int crearCajero(CajeroDTO cajero){
        String sql = "INSERT INTO Cajero(nombre,turno,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cajero WHERE dpi = ?);";
        int ingresado = -1;
        try(PreparedStatement ps = cn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS)){
            ps.setString(1, cajero.getNombre());
            ps.setString(2, cajero.getTurno());
            ps.setString(3, cajero.getSexo());
            ps.setString(4, cajero.getDpi());
            ps.setString(5, cajero.getDireccion());
            ps.setString(6, cajero.getDpi());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while(rs.next()){
                ingresado = rs.getInt(1);
            }
        } catch (SQLException sqle){
            System.err.print("Error en método crearCajero() de la clase CajeroDAO por: "+sqle);
            System.out.print("Error en método crearCajero() de la clase CajeroDAO por: "+sqle);
        }
        return ingresado;
    }
    public ArrayList<CajeroDTO> obtenerCajeros(){
        String sql = "SELECT * FROM Cajero";
        ArrayList<CajeroDTO> listado = new ArrayList<>();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                CajeroDTO temporal = new CajeroDTO(rs.getInt("codigo"),rs.getString("nombre"),
                        rs.getString("sexo"),rs.getString("turno"),rs.getString("dpi"),rs.getString("direccion"));
                listado.add(temporal);
            }
        } catch (SQLException sqle){
            System.err.print("Error en método existeTransaccion() de la clase TransaccionDAO por: "+sqle);
            System.out.print("Error en método existeTransaccion() de la clase TransaccionDAO por: "+sqle);
        }
        return listado;
    }
    
    public boolean actualizarCajero(CajeroDTO cajero){
        String sql = "UPDATE Cajero SET nombre = ?, sexo = ?, turno = ?, direccion = ? WHERE codigo = ?";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cajero.getNombre());
            ps.setString(2, cajero.getSexo());
            ps.setString(3, cajero.getTurno());
            ps.setString(4, cajero.getDireccion());
            ps.setInt(5, cajero.getCodigo());
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("Error en método actualizarCajero() de la clase CajeroDAO por: "+sqle);
            System.out.print("Error en método actualizarCajero() de la clase CajeroDAO por: "+sqle);
        }
        
        return ingresado;
    }
    
    public CajeroDTO obteniendoDatosPersonales(int codigo){
        String sql = "SELECT * FROM Cajero WHERE codigo = ?";
        CajeroDTO retorno = new CajeroDTO();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setInt(1, codigo);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                retorno = new CajeroDTO(codigo,rs.getString("nombre"),rs.getString("sexo"),rs.getString("turno"),rs.getString("dpi"),rs.getString("direccion"));
            }
        } catch (SQLException sqle){
            System.err.print("Error en método obteniendoDatosPersonales() de la clase CajeroDAO por: "+sqle);
            System.out.print("Error en método obteniendoDatosPersonales() de la clase CajeroDAO por: "+sqle);
        }
        return retorno;
        
    }
    
    public boolean turnoCorrecto(int codigo) {
        Date fecha = new Date();
        DateFormat hora = new SimpleDateFormat("HH:mm:ss");
        String sql = "SELECT COUNT(g.codigo) AS total FROM Cajero g, Turno t WHERE g.codigo = ? AND g.turno = t.codigo AND ? BETWEEN t.hora_inicio AND t.hora_final GROUP BY g.codigo";
        boolean correcto = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            ps.setString(2, hora.format(fecha));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                correcto = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método turnoCorrecto() de la clase CajeroDAO por: " + sqle);
            System.out.print("Error en método turnoCorrecto() de la clase CajeroDAO por: " + sqle);
        }
        return correcto;
    }
}
