package Entidad;

import java.util.Date;

public class clsEntCarrito {
    private int idCarrito;
    private int idCliente;
    private int idProducto;
    private int cantidad;
    private double precioUnitario;
    private Date fechaAgregado;
    
    // Constructores
    public clsEntCarrito() {}
    
    public clsEntCarrito(int idCliente, int idProducto, int cantidad, double precioUnitario) {
        this.idCliente = idCliente;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.fechaAgregado = new Date();
    }
    
    // Getters y Setters
    public int getIdCarrito() { return idCarrito; }
    public void setIdCarrito(int idCarrito) { this.idCarrito = idCarrito; }
    
    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }
    
    public int getIdProducto() { return idProducto; }
    public void setIdProducto(int idProducto) { this.idProducto = idProducto; }
    
    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    
    public double getPrecioUnitario() { return precioUnitario; }
    public void setPrecioUnitario(double precioUnitario) { this.precioUnitario = precioUnitario; }
    
    public Date getFechaAgregado() { return fechaAgregado; }
    public void setFechaAgregado(Date fechaAgregado) { this.fechaAgregado = fechaAgregado; }
    
    public double getSubtotal() {
        return cantidad * precioUnitario;
    }
}