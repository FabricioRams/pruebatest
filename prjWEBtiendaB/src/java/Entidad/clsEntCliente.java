/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entidad;

import java.sql.Timestamp;

public class clsEntCliente {
    private int idcliente;
    private String dni;
    private String email;
    private String clave;
    private String nombres;
    private String apellidos;
    private String telefono;
    private String direccion;
    private int idcargo;
    private int idestado;
    private Timestamp fecha_registro;
    
    public clsEntCliente() {}
    
    public clsEntCliente(int idcliente, String dni, String email, String clave, 
                        String nombres, String apellidos, String telefono, 
                        String direccion, int idcargo, int idestado) {
        this.idcliente = idcliente;
        this.dni = dni;
        this.email = email;
        this.clave = clave;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.direccion = direccion;
        this.idcargo = idcargo;
        this.idestado = idestado;
    }
    
    public int getIdcliente() { return idcliente; }
    public void setIdcliente(int idcliente) { this.idcliente = idcliente; }
    
    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }
    
    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }
    
    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }
    
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    
    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }
    
    public int getIdcargo() { return idcargo; }
    public void setIdcargo(int idcargo) { this.idcargo = idcargo; }
    
    public int getIdestado() { return idestado; }
    public void setIdestado(int idestado) { this.idestado = idestado; }
    
    public Timestamp getFecha_registro() { return fecha_registro; }
    public void setFecha_registro(Timestamp fecha_registro) { this.fecha_registro = fecha_registro; }
}
