/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ModeloDao;
import Config.ConnectionConfig;
import Interfaces.CrudCliente;
import Modelo.Cargo;
import Modelo.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
/**
 *
 * @author HP
 */
public class ClienteDAO implements CrudCliente{
    ConnectionConfig cn = new ConnectionConfig();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    Cliente c =new Cliente();
    @Override
    public List listar() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Cliente list(String dni) {
        String sql = "SELECT dni, nombre, direccion, email, clave FROM tbcliente WHERE dni = '"+dni+"'";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()){
                Cargo car = new Cargo();
                c.setDni(rs.getString("dni"));
                c.setNombre(rs.getString("nombres"));
                c.setDireccion(rs.getString("direccion"));
                c.setEmail(rs.getString("email"));
                c.setClave(rs.getString("clave"));
            }
        }catch(SQLException e){
            System.out.println("error " + e.getMessage());
        }
        return c;
    }

    @Override
    public boolean add(Cliente cli) {
        String sql = "INSERT INTO tbcliente (dni, nombres, dreiccion, email, clave) \n" + "VALUES ('"+cli.getDni()+"','"+cli.getNombre()+"','"+cli.getDireccion()+"','"+cli.getEmail()+"','"+cli.getClave()+"')";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeQuery();
        }
        catch (SQLException e){
            System.out.println("error");
        }
        return false;
    }

    @Override
    public boolean edit(Cliente cli) {
        String sql = "UPDATE tbcliente SET nombre'"+cli.getNombre()+"', direccion ='"+cli.getDireccion()+"', email = '"+cli.getEmail()+"', clave ='"+cli.getClave()+"' WHERE dni = '"+cli.getDni()+"'";
        try{
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.executeQuery();
        }
        catch (SQLException e){
            System.out.println("error");
        }
        return false;
    }

    @Override
    public boolean eliminar(String dni) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
