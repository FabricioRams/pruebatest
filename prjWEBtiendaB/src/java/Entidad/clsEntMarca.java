/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

/**
 *
 * @author HP
 */
public class clsEntMarca {
    private int idmarca;
    private String nombre;
    private String descripcion;
    
    public clsEntMarca() {}
    
    public clsEntMarca(int idmarca, String nombre, String descripcion) {
        this.idmarca = idmarca;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }
    
    public int getIdmarca() { return idmarca; }
    public void setIdmarca(int idmarca) { this.idmarca = idmarca; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
}