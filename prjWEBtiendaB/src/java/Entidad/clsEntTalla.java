/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

/**
 *
 * @author HP
 */
public class clsEntTalla {
    private int idtalla;
    private String valor;
    private int idtipotalla;
    
    private String nombreTipoTalla;
    private String descripcionTipoTalla;
    
    public clsEntTalla() {}
    
    public clsEntTalla(int idtalla, String valor, int idtipotalla) {
        this.idtalla = idtalla;
        this.valor = valor;
        this.idtipotalla = idtipotalla;
    }
    
    public int getIdtalla() { return idtalla; }
    public void setIdtalla(int idtalla) { this.idtalla = idtalla; }
    
    public String getValor() { return valor; }
    public void setValor(String valor) { this.valor = valor; }
    
    public int getIdtipotalla() { return idtipotalla; }
    public void setIdtipotalla(int idtipotalla) { this.idtipotalla = idtipotalla; }
    
    public String getNombreTipoTalla() { return nombreTipoTalla; }
    public void setNombreTipoTalla(String nombreTipoTalla) { this.nombreTipoTalla = nombreTipoTalla; }
    
    public String getDescripcionTipoTalla() { return descripcionTipoTalla; }
    public void setDescripcionTipoTalla(String descripcionTipoTalla) { this.descripcionTipoTalla = descripcionTipoTalla; }
}