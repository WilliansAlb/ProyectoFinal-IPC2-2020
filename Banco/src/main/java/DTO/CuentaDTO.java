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
    
    private int codigo;
    private Double credito;
    private int cliente;
    private String creacion;
    
    public CuentaDTO(){
        
    }
    
    public CuentaDTO(int codigo,Double credito,int cliente,String creacion){
        this.codigo = codigo;
        this.credito = credito;
        this.cliente = cliente;
        this.creacion = creacion;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public Double getCredito() {
        return credito;
    }

    public void setCredito(Double credito) {
        this.credito = credito;
    }

    public int getCliente() {
        return cliente;
    }

    public void setCliente(int cliente) {
        this.cliente = cliente;
    }

    public String getCreacion() {
        return creacion;
    }

    public void setCreacion(String creacion) {
        this.creacion = creacion;
    }
        
    
}
