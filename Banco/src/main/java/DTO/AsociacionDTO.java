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
public class AsociacionDTO {
    private int codigo;
    private long cuenta;
    private long cliente;
    private String estado;
    
    public AsociacionDTO(){
    
    }
    public AsociacionDTO(int codigo, long cuenta, long cliente, String estado){
        this.codigo = codigo;
        this.cuenta = cuenta;
        this.cliente = cliente;
        this.estado = estado;
    }

    public AsociacionDTO(long cuenta, long cliente, String estado){
        this.cuenta = cuenta;
        this.cliente = cliente;
        this.estado = estado;
    }
    
    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public long getCuenta() {
        return cuenta;
    }

    public void setCuenta(long cuenta) {
        this.cuenta = cuenta;
    }

    public long getCliente() {
        return cliente;
    }

    public void setCliente(long cliente) {
        this.cliente = cliente;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    
}
