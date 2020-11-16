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
public class AccionDTO {
    private int codigo;
    private String descripcion;
    private long gerente;
    private String realizacion;
    private String entidad;
    
    public AccionDTO(){
    
    }
    
    public AccionDTO(int codigo, String descripcion, long gerente, String realizacion, String entidad){
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.gerente = gerente;
        this.realizacion = realizacion;
        this.entidad = entidad;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public long getGerente() {
        return gerente;
    }

    public void setGerente(long gerente) {
        this.gerente = gerente;
    }

    public String getRealizacion() {
        return realizacion;
    }

    public void setRealizacion(String realizacion) {
        this.realizacion = realizacion;
    }

    public String getEntidad() {
        return entidad;
    }

    public void setEntidad(String entidad) {
        this.entidad = entidad;
    }
    
    
    
}
