/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DTO;

import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class BalanceDTO {
    
    private Double deposito;
    private Double retiro;
    private String fecha;
    private long cajero;
    private Double balance;
    private ArrayList<TransaccionDTO> transacciones;
    
    public BalanceDTO(){
    
    }

    public Double getDeposito() {
        return deposito;
    }

    public void setDeposito(Double deposito) {
        this.deposito = deposito;
    }

    public Double getRetiro() {
        return retiro;
    }

    public void setRetiro(Double retiro) {
        this.retiro = retiro;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public long getCajero() {
        return cajero;
    }

    public void setCajero(long cajero) {
        this.cajero = cajero;
    }

    public Double getBalance() {
        return balance;
    }

    public void setBalance(Double balance) {
        this.balance = balance;
    }

    public ArrayList<TransaccionDTO> getTransacciones() {
        return transacciones;
    }

    public void setTransacciones(ArrayList<TransaccionDTO> transacciones) {
        this.transacciones = transacciones;
    }
    
    
}
