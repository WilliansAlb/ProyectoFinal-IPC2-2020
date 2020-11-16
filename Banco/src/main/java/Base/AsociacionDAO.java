/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import DTO.AsociacionDTO;
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
public class AsociacionDAO {

    Connection cn;

    public AsociacionDAO(Conector cn) {
        this.cn = cn.getConexion();
    }
    /**
     * Método que envia la solicitud de asociacion
     * @param asociacion con todos sus datos, menos el codigo
     * @return codigo de la solicitud
     */
    public int enviarSolicitud(AsociacionDTO asociacion) {
        int enviada = -1;
        String sql = "INSERT INTO Asociacion(cuenta,cliente,estado) VALUES (?,?,?)";

        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(2, asociacion.getCliente());
            ps.setLong(1, asociacion.getCuenta());
            ps.setString(3, asociacion.getEstado());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while (rs.next()) {
                enviada = rs.getInt(1);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: método enviarSolicitud() clase AsociacionDAO() por " + sqle);
        }
        return enviada;
    }
    /**
     * Método que regresa los estados de las solicitudes que tiene en curso
     * @param asociacion segun cliente y numero de la cuenta
     * @return listado de estados de las solicitudes
     */
    public ArrayList<String> estados(AsociacionDTO asociacion) {
        ArrayList<String> retorno = new ArrayList<>();
        String sql = "SELECT estado FROM Asociacion WHERE cliente = ? AND cuenta = ?";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, asociacion.getCliente());
            ps.setLong(2, asociacion.getCuenta());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                retorno.add(rs.getString(1));
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: método estados() clase AsociacionDAO() por " + sqle);
        }
        return retorno;
    }
    /**
     * Método que devuelve todas las solicitudes de asociacion recibidas según sea el codigo del cliente
     * @param cliente codigo del cliente
     * @return listado de las solicitudes recibidas
     */
    public ArrayList<AsociacionDTO> obtenerAsociacionesRecibidas(long cliente) {
        ArrayList<AsociacionDTO> retorno = new ArrayList<>();
        String sql = "SELECT a.codigo,a.cuenta,a.cliente,a.estado FROM Asociacion a, Cuenta c WHERE c.codigo = a.cuenta AND c.cliente = ? ORDER BY a.codigo DESC";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cliente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AsociacionDTO temporal = new AsociacionDTO(rs.getInt(1), rs.getLong(2), rs.getLong(3), rs.getString(4));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: método estados() clase AsociacionDAO() por " + sqle);
        }
        return retorno;
    }
    /**
     * Método que obtiene las solicitudes realizadas
     * @param cliente codigo del cliente
     * @return listado de las asociaciones realizadas
     */
    public ArrayList<AsociacionDTO> obtenerAsociacionesRealizadas(long cliente) {
        ArrayList<AsociacionDTO> retorno = new ArrayList<>();
        String sql = "SELECT a.codigo,a.cuenta,a.cliente,a.estado FROM Asociacion a, Cuenta c WHERE c.codigo = a.cuenta AND a.cliente = ? ORDER BY a.codigo DESC";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setLong(1, cliente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AsociacionDTO temporal = new AsociacionDTO(rs.getInt(1), rs.getLong(2), rs.getLong(3), rs.getString(4));
                retorno.add(temporal);
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: método obtenerAsociacionesRealizadas() clase AsociacionDAO() por " + sqle);
        }
        return retorno;
    }
    /**
     * Método que edita el estado de una solicitud de asociacion
     * @param asociacion entidad que cambiará
     * @param estado puede ser EN ESPERA, ACEPTADA, RECHAZADA
     * @return true si se logro editar el estado de la solicitud
     */
    public boolean editarEstado(int asociacion, String estado){
        String sql = "UPDATE Asociacion SET estado = ? WHERE codigo = ?";
        boolean editado = false;
        
        try(PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
            ps.setString(1, estado);
            ps.setInt(2, asociacion);
            editado = ps.executeUpdate() > 0;
        } catch ( SQLException sqle ){
            System.err.print("ERROR: método editarEstado() clase AsociacionDAO() por"+ sqle);
        }
        return editado;
    }
}
