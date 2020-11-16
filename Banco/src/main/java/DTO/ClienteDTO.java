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
public class ClienteDTO {
    
    private long codigo;
    private String nombre;
    private String sexo;
    private String fecha;
    private String dpi;
    private String direccion;
    private int transacciones;
    private Double montoMayor;
    
    public ClienteDTO(){
    
    }
    
    public ClienteDTO(long codigo, String nombre, String fecha, String dpi, String direccion, String sexo){
        this.codigo = codigo;
        this.nombre = nombre;
        this.fecha = fecha;
        this.dpi = dpi;
        this.direccion = direccion;
        this.sexo = sexo;
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

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
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

    public int getTransacciones() {
        return transacciones;
    }

    public void setTransacciones(int transacciones) {
        this.transacciones = transacciones;
    }

    public Double getMontoMayor() {
        return montoMayor;
    }

    public void setMontoMayor(Double montoMayor) {
        this.montoMayor = montoMayor;
    }
    
    
}
