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
public class TransaccionDTO {
    
    private long codigo;
    private long cuenta;
    private long cajero;
    private Double monto;
    private String creacion;
    private String tipo;
    private Double anterior;
    private Double actual;

    /**
     * Constructor de la entidad transaccion
     * @param codigo
     * @param cuenta
     * @param cajero
     * @param monto
     * @param creacion
     * @param tipo 
     */
    public TransaccionDTO(long codigo, long cuenta, long cajero, Double monto, String creacion, String tipo){
        this.codigo = codigo;
        this.cuenta = cuenta;
        this.cajero = cajero;
        this.monto = monto;
        this.creacion = creacion;
        this.tipo = tipo;
    }
    /**
     * Constructor de la entidad transaccion sin el codigo
     * @param cuenta
     * @param cajero
     * @param monto
     * @param creacion
     * @param tipo 
     */
    public TransaccionDTO(long cuenta, long cajero, Double monto, String creacion, String tipo){
        this.cuenta = cuenta;
        this.cajero = cajero;
        this.monto = monto;
        this.creacion = creacion;
        this.tipo = tipo;
    }

    public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
        this.codigo = codigo;
    }

    public long getCuenta() {
        return cuenta;
    }

    public void setCuenta(long cuenta) {
        this.cuenta = cuenta;
    }

    public long getCajero() {
        return cajero;
    }

    public void setCajero(long cajero) {
        this.cajero = cajero;
    }

    public Double getMonto() {
        return monto;
    }

    public void setMonto(Double monto) {
        this.monto = monto;
    }

    public String getCreacion() {
        return creacion;
    }

    public void setCreacion(String creacion) {
        this.creacion = creacion;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
    
    public Double getAnterior() {
        return anterior;
    }

    public void setAnterior(Double anterior) {
        this.anterior = anterior;
    }

    public Double getActual() {
        return actual;
    }

    public void setActual(Double actual) {
        this.actual = actual;
    }
    
}
