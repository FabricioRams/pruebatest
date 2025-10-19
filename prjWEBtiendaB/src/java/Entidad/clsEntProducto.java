/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class clsEntProducto {
    private int idproducto;
    private String nombre;
    private String descripcion;
    private BigDecimal precio;
    private int stock;
    private int idmodelo;
    private int idcolor;
    private int idtalla;
    private String imagen;
    private Timestamp fecha_creacion;
    private boolean activo;
    
    private String nombreModelo;
    private String nombreMarca;
    private String nombreColor;
    private String valorTalla;
    
    public clsEntProducto() {}
    
    public int getIdproducto() { return idproducto; }
    public void setIdproducto(int idproducto) { this.idproducto = idproducto; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    
    public BigDecimal getPrecio() { return precio; }
    public void setPrecio(BigDecimal precio) { this.precio = precio; }
    
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    
    public int getIdmodelo() { return idmodelo; }
    public void setIdmodelo(int idmodelo) { this.idmodelo = idmodelo; }
    
    public int getIdcolor() { return idcolor; }
    public void setIdcolor(int idcolor) { this.idcolor = idcolor; }
    
    public int getIdtalla() { return idtalla; }
    public void setIdtalla(int idtalla) { this.idtalla = idtalla; }
    
    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }
    
    public Timestamp getFecha_creacion() { return fecha_creacion; }
    public void setFecha_creacion(Timestamp fecha_creacion) { this.fecha_creacion = fecha_creacion; }
    
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
    
    public String getNombreModelo() { return nombreModelo; }
    public void setNombreModelo(String nombreModelo) { this.nombreModelo = nombreModelo; }
    
    public String getNombreMarca() { return nombreMarca; }
    public void setNombreMarca(String nombreMarca) { this.nombreMarca = nombreMarca; }
    
    public String getNombreColor() { return nombreColor; }
    public void setNombreColor(String nombreColor) { this.nombreColor = nombreColor; }
    
    public String getValorTalla() { return valorTalla; }
    public void setValorTalla(String valorTalla) { this.valorTalla = valorTalla; }
}