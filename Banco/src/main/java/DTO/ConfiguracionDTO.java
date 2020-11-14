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
public class ConfiguracionDTO {
    private Double limite_menor;
    private Double limite_mayor;
    private String d_matutino;
    private String d_vespertino;
    private String h_matutino;
    private String h_vespertino;
    
    public ConfiguracionDTO(){
    
    }
    
    public ConfiguracionDTO(Double limiteMe,Double limiteMa, String dMatutino, String hMatutino, String dVespertino, String hVespertino){
        this.limite_mayor = limiteMa;
        this.limite_menor = limiteMe;
        this.d_matutino = dMatutino;
        this.h_matutino = hMatutino;
        this.d_vespertino = dVespertino;
        this.h_vespertino = hVespertino;
    }
    

    public Double getLimite_menor() {
        return limite_menor;
    }

    public void setLimite_menor(Double limite_menor) {
        this.limite_menor = limite_menor;
    }

    public Double getLimite_mayor() {
        return limite_mayor;
    }

    public void setLimite_mayor(Double limite_mayor) {
        this.limite_mayor = limite_mayor;
    }

    public String getD_matutino() {
        return d_matutino;
    }

    public void setD_matutino(String d_matutino) {
        this.d_matutino = d_matutino;
    }

    public String getD_vespertino() {
        return d_vespertino;
    }

    public void setD_vespertino(String d_vespertino) {
        this.d_vespertino = d_vespertino;
    }

    public String getH_matutino() {
        return h_matutino;
    }

    public void setH_matutino(String h_matutino) {
        this.h_matutino = h_matutino;
    }

    public String getH_vespertino() {
        return h_vespertino;
    }

    public void setH_vespertino(String h_vespertino) {
        this.h_vespertino = h_vespertino;
    }
    
}
