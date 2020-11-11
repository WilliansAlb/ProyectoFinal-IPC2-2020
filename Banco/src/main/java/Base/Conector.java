/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author yelbetto
 */
public class Conector {

    private Connection conexion;
    private Statement sentencia;

    //Datos conexion con la Base de Datos
    private final String servidor = "localhost";
    private final String puerto = "3306";
    private final String BD = "Banco";
    private final String usuario = "root";
    private final String clave = "Cristeptesico_65";
    private final String URL = "jdbc:mysql://" + servidor + ":" + puerto + "/" + BD;

    public Conector() {
        this.conexion = null;
        this.sentencia = null;
    }
    
    public Conector(String encender){
        this.conexion = null;
        this.sentencia = null;
        conectar();
    }

    public boolean conectar() {
        boolean estado = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try {
                //Establecer la conexion con la BD
                conexion = DriverManager.getConnection(URL, usuario, clave);
                estado = true;
            } catch (SQLException ex) {
                System.err.print("ERROR: ConectorBD.conectar()");
                System.err.print("Al intentar conectar con la Base de Datos");
                System.err.print(ex.getMessage());
            }
        } catch (ClassNotFoundException cex) {
            System.err.print("ERROR: ConectorBD.conectar()");
            System.err.print("No se encontró el Driver de Conexion con MYSQL");
            System.err.print(cex.getMessage());
        }
        return estado;
    }

    public void desconectar() {
        try {
            if (conexion != null) {
                conexion.close();
                conexion = null;
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: ConectorBD.desconectar()");
            System.err.print(sqle.getMessage());
        }
    }

    public Connection getConexion() {
        return conexion;
    }
}
