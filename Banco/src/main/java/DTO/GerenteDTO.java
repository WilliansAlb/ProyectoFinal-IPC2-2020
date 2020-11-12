/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.io.Serializable;

/**
 *
 * @author yelbetto
 */
public class GerenteDTO implements Serializable{
    
    public static final String CODIGO_DB = "codigo";
    public static final String NOMBRE_DB = "nombre";
    public static final String SEXO_DB = "sexo";
    public static final String TURNO_DB = "turno";
    public static final String DPI_DB = "dpi";
    public static final String DIRECCION_DB = "direccion";
    
    private int codigo;
    private String nombre;
    private String sexo;
    private String turno;
    private String dpi;
    private String direccion;
    
    public GerenteDTO(){
    
    } 
    /**
     * Constructor de la entidad Gerente
     * @param codigo
     * @param nombre
     * @param sexo
     * @param turno
     * @param dpi
     * @param direccion 
     */
    public GerenteDTO(int codigo, String nombre, String sexo, String turno, String dpi, String direccion){
        this.codigo = codigo;
        this.nombre = nombre;
        this.sexo = sexo;
        this.turno = turno;
        this.dpi = dpi;
        this.direccion = direccion;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getTurno() {
        return turno;
    }

    public void setTurno(String turno) {
        this.turno = turno;
    }

    public String getDpi() {
        return dpi;
    }

    public void setDpi(String dpi) {
        this.dpi = dpi;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    
}
