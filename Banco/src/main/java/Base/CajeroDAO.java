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
    /**
     * Método que se encarga de ingresar el cajero
     * @param cajero con datos completos
     * @return true si se logró ingresar el cajero
     */
    public boolean ingresarCajero(CajeroDTO cajero){
        String sql = "INSERT INTO Cajero(codigo,nombre,turno,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cajero WHERE dpi = ?);";
        boolean ingresado = false;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, cajero.getCodigo());
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
        }
        return ingresado;
    }
    /**
     * Método que verifica si existe el cajero con el dpi especificado
     * @param cajero con el unico parametro dpi diferente de null
     * @return true si existe el cajero
     */
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
        }
        return ingresado;
    }
    /**
     * Método que crea cajero y devuelve el codigo del mismo
     * @param cajero con todos los datos menos codigo
     * @return codigo del cajero
     */
    public long crearCajero(CajeroDTO cajero){
        String sql = "INSERT INTO Cajero(nombre,turno,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Cajero WHERE dpi = ?);";
        long ingresado = -1;
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
                ingresado = rs.getLong(1);
            }
        } catch (SQLException sqle){
            System.err.print("Error en método crearCajero() de la clase CajeroDAO por: "+sqle);
        }
        return ingresado;
    }
    /**
     * Método para obtener todos los cajeros
     * @return lista de todos los cajeros
     */
    public ArrayList<CajeroDTO> obtenerCajeros(){
        String sql = "SELECT * FROM Cajero";
        ArrayList<CajeroDTO> listado = new ArrayList<>();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                CajeroDTO temporal = new CajeroDTO(rs.getLong("codigo"),rs.getString("nombre"),
                        rs.getString("sexo"),rs.getString("turno"),rs.getString("dpi"),rs.getString("direccion"));
                listado.add(temporal);
            }
        } catch (SQLException sqle){
            System.err.print("Error en método obtenerCajeros() de la clase TransaccionDAO por: "+sqle);
        }
        return listado;
    }
    /**
     * Método que devuelve si fue actualizado el cajero enviandole el codigo y los demás datos
     * @param cajero con todos los datos
     * @return true si se actualiza el cajero
     */
    public boolean actualizarCajero(CajeroDTO cajero){
        String sql = "UPDATE Cajero SET nombre = ?, sexo = ?, turno = ?, direccion = ? WHERE codigo = ?";
        boolean ingresado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, cajero.getNombre());
            ps.setString(2, cajero.getSexo());
            ps.setString(3, cajero.getTurno());
            ps.setString(4, cajero.getDireccion());
            ps.setLong(5, cajero.getCodigo());
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle){
            System.err.print("Error en método actualizarCajero() de la clase CajeroDAO por: "+sqle);
        }
        
        return ingresado;
    }
    /**
     * Método que obtiene los datos personales del cajero especificado con el codigo
     * @param codigo del cajero
     * @return cajero con todos los datos completos
     */
    public CajeroDTO obteniendoDatosPersonales(long codigo){
        String sql = "SELECT * FROM Cajero WHERE codigo = ?";
        CajeroDTO retorno = new CajeroDTO();
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setLong(1, codigo);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                retorno = new CajeroDTO(codigo,rs.getString("nombre"),
                        rs.getString("sexo"),rs.getString("turno"),
                        rs.getString("dpi"),rs.getString("direccion"));
            }
        } catch (SQLException sqle){
            System.err.print("Error en método obteniendoDatosPersonales() de la clase CajeroDAO por: "+sqle);
        }
        return retorno;
    }
    /**
     * Método que verifica si el cajero esta en su turno correcto
     * @param codigo del cajero
     * @return true si se encuentra en el turno correcto
     */
    public boolean turnoCorrecto(long codigo) {
        Date fecha = new Date();
        DateFormat hora = new SimpleDateFormat("HH:mm:ss");
        String sql = "SELECT COUNT(g.codigo) AS total FROM Cajero g, Turno t WHERE g.codigo = ? AND g.turno = t.codigo AND ? BETWEEN t.hora_inicio AND t.hora_final GROUP BY g.codigo";
        boolean correcto = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, codigo);
            ps.setString(2, hora.format(fecha));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                correcto = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método turnoCorrecto() de la clase CajeroDAO por: " + sqle);
        }
        return correcto;
    }
}
