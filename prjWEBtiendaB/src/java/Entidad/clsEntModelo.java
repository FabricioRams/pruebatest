/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

/**
 *
 * @author HP
 */
public class clsEntModelo {
    private int idmodelo;
    private String nombre;
    private String descripcion;
    private int idmarca;
    
    private String nombreMarca;
    
    public clsEntModelo() {}
    
    public clsEntModelo(int idmodelo, String nombre, String descripcion, int idmarca) {
        this.idmodelo = idmodelo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.idmarca = idmarca;
    }
    
    public int getIdmodelo() { return idmodelo; }
    public void setIdmodelo(int idmodelo) { this.idmodelo = idmodelo; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public int getIdmarca() { return idmarca; }
    public void setIdmarca(int idmarca) { this.idmarca = idmarca; }
    
    public String getNombreMarca() { return nombreMarca; }
    public void setNombreMarca(String nombreMarca) { this.nombreMarca = nombreMarca; }
}