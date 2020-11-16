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
public class CuentaDTO {
    
    private long codigo;
    private Double credito;
    private long cliente;
    private String creacion;
    
    public CuentaDTO(){
        
    }
    /**
     * Constructor de entidad cuenta 
     * @param codigo
     * @param credito
     * @param cliente
     * @param creacion 
     */
    public CuentaDTO(long codigo,Double credito,long cliente,String creacion){
        this.codigo = codigo;
        this.credito = credito;
        this.cliente = cliente;
        this.creacion = creacion;
    }
    
    public CuentaDTO(Double credito,long cliente,String creacion){
        this.credito = credito;
        this.cliente = cliente;
        this.creacion = creacion;
    }

    public long getCodigo() {
        return codigo;
    }

    public void setCodigo(long codigo) {
        this.codigo = codigo;
    }


    public Double getCredito() {
        return credito;
    }

    public void setCredito(Double credito) {
        this.credito = credito;
    }

    public long getCliente() {
        return cliente;
    }

    public void setCliente(long cliente) {
        this.cliente = cliente;
    }

    public String getCreacion() {
        return creacion;
    }

    public void setCreacion(String creacion) {
        this.creacion = creacion;
    }
        
    
}
