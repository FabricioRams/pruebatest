/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

/**
 *
 * @author HP
 */
public class clsEntColor {
    private int idcolor;
    private String nombre;
    private String codigo_hex;
    
    public clsEntColor() {}
    
    public clsEntColor(int idcolor, String nombre, String codigo_hex) {
        this.idcolor = idcolor;
        this.nombre = nombre;
        this.codigo_hex = codigo_hex;
    }
    
    public int getIdcolor() { return idcolor; }
    public void setIdcolor(int idcolor) { this.idcolor = idcolor; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getCodigo_hex() { return codigo_hex; }
    public void setCodigo_hex(String codigo_hex) { this.codigo_hex = codigo_hex; }
}