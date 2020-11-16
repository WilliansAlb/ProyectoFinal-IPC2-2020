/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

/**
 *
 * @author yelbetto
 */
public class CajeroDTO {
    
    private long codigo;
    private String nombre;
    private String sexo;
    private String turno;
    private String dpi;
    private String direccion;
    
    public CajeroDTO(){
        
    }
    /**
     * Constructor de la entidad Cajero con datos completos
     * @param codigo 
     * @param nombre
     * @param sexo
     * @param turno
     * @param dpi
     * @param direccion 
     */
    public CajeroDTO(long codigo,String nombre,String sexo,String turno,String dpi,String direccion){
        this.codigo = codigo;
        this.nombre = nombre;
        this.sexo = sexo;
        this.turno = turno;
        this.dpi = dpi;
        this.direccion = direccion;
    }
    /**
     * Constructor que crea entidad con los siguientes parametros
     * @param codigo
     * @param nombre
     * @param sexo
     * @param turno
     * @param direccion 
     */
    public CajeroDTO(long codigo,String nombre,String sexo,String turno,String direccion){
        this.codigo = codigo;
        this.nombre = nombre;
        this.sexo = sexo;
        this.turno = turno;
        this.direccion = direccion;
    }

    public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
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
