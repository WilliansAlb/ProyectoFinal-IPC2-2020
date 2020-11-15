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
import java.util.Date;

/**
 *
 * @author yelbetto
 */
public class GerenteDAO {

    Connection cn;

    public GerenteDAO(Conector cn) {
        this.cn = cn.getConexion();
    }

    public boolean ingresarGerente(GerenteDTO gerente) {
        String sql = "INSERT INTO Gerente(codigo,nombre,turno,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Gerente WHERE dpi = ?);";
        boolean ingresado = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, gerente.getCodigo());
            ps.setString(2, gerente.getNombre());
            ps.setString(3, gerente.getTurno());
            ps.setString(4, gerente.getSexo());
            ps.setString(5, gerente.getDpi());
            ps.setString(6, gerente.getDireccion());
            ps.setString(7, gerente.getDpi());
            ps.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("Error en método ingresarGerente() de la clase GerenteDAO por: " + sqle);
            System.out.print("Error en método ingresarGerente() de la clase GerenteDAO por: " + sqle);
        }
        return ingresado;
    }

    public boolean existeGerente(GerenteDTO gerente) {
        String sql = "SELECT COUNT(*) AS total FROM Gerente WHERE dpi = ?";
        boolean ingresado = false;

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, gerente.getDpi());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ingresado = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método existeGerente() de la clase GerenteDAO por: " + sqle);
            System.out.print("Error en método existeGerente() de la clase GerenteDAO por: " + sqle);
        }
        return ingresado;
    }

    public int crearGerente(GerenteDTO gerente) {
        String sql = "INSERT INTO Gerente(nombre,turno,sexo,dpi,direccion) "
                + " SELECT ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Gerente WHERE dpi = ?);";
        int ingresado = -1;
        try (PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, gerente.getNombre());
            ps.setString(2, gerente.getTurno());
            ps.setString(3, gerente.getSexo());
            ps.setString(4, gerente.getDpi());
            ps.setString(5, gerente.getDireccion());
            ps.setString(6, gerente.getDpi());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while (rs.next()) {
                ingresado = rs.getInt(1);
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método crearGerente() de la clase GerenteDAO por: " + sqle);
            System.out.print("Error en método crearGerente() de la clase GerenteDAO por: " + sqle);
        }
        return ingresado;
    }

    public GerenteDTO obteniendoDatosPersonales(int codigo) {
        String sql = "SELECT * FROM Gerente WHERE codigo = ?";
        GerenteDTO retorno = new GerenteDTO();

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                retorno = new GerenteDTO(codigo, rs.getString("nombre"), rs.getString("sexo"), rs.getString("turno"), rs.getString("dpi"), rs.getString("direccion"));
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método obteniendoDatosPersonales() de la clase GerenteDAO por: " + sqle);
            System.out.print("Error en método obteniendoDatosPersonales() de la clase GerenteDAO por: " + sqle);
        }
        return retorno;

    }

    public boolean actualizarGerente(GerenteDTO gerente) {
        String sql = "UPDATE Gerente SET nombre = ?, sexo = ?, turno = ?, direccion = ?, dpi = ? WHERE codigo = ?";
        boolean ingresado = false;

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, gerente.getNombre());
            ps.setString(2, gerente.getSexo());
            ps.setString(3, gerente.getTurno());
            ps.setString(4, gerente.getDireccion());
            ps.setString(5, gerente.getDpi());
            ps.setInt(6, gerente.getCodigo());
            ingresado = ps.executeUpdate() > 0;
        } catch (SQLException sqle) {
            System.err.print("Error en método actualizarGerente() de la clase GerenteDAO por: " + sqle);
            System.out.print("Error en método actualizarGerente() de la clase GerenteDAO por: " + sqle);
        }

        return ingresado;
    }

    public boolean turnoCorrecto(int codigo) {
        Date fecha = new Date();
        DateFormat hora = new SimpleDateFormat("HH:mm:ss");
        String sql = "SELECT COUNT(g.codigo) AS total FROM Gerente g, Turno t WHERE g.codigo = ? AND g.turno = t.codigo AND ? BETWEEN t.hora_inicio AND t.hora_final GROUP BY g.codigo";
        boolean correcto = false;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, codigo);
            ps.setString(2, hora.format(fecha));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                correcto = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle) {
            System.err.print("Error en método turnoCorrecto() de la clase GerenteDAO por: " + sqle);
            System.out.print("Error en método turnoCorrecto() de la clase GerenteDAO por: " + sqle);
        }
        return correcto;
    }
}
