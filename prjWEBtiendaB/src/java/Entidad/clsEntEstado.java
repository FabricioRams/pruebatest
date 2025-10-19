/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

/**
 *
 * @author HP
 */
public class clsEntEstado {
    private int idestado;
    private String nombre;
    
    public clsEntEstado() {}
    
    public clsEntEstado(int idestado, String nombre) {
        this.idestado = idestado;
        this.nombre = nombre;
    }
    
    public int getIdestado() { return idestado; }
    public void setIdestado(int idestado) { this.idestado = idestado; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
}