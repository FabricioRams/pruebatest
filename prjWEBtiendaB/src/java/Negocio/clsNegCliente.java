/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Negocio;

import Config.ClsConexion;
import Entidad.clsEntCliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegCliente {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    
    public clsEntCliente MtdLogin(String usuario, String clave) {
        clsEntCliente cliente = null;
        String sql = "SELECT c.*, car.nombre as nombreCargo, e.nombre as nombreEstado " +
                     "FROM tbcliente c " +
                     "INNER JOIN tbcargo car ON c.idcargo = car.idcargo " +
                     "INNER JOIN tbestado e ON c.idestado = e.idestado " +
                     "WHERE (c.dni = ? OR c.email = ?) AND c.clave = ? AND e.nombre = 'Activo'";
        
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setString(1, usuario);
            st.setString(2, usuario);
            st.setString(3, clave);
            rs = st.executeQuery();
            
            if (rs.next()) {
                cliente = new clsEntCliente();
                cliente.setIdcliente(rs.getInt("idcliente"));
                cliente.setDni(rs.getString("dni"));
                cliente.setEmail(rs.getString("email"));
                cliente.setNombres(rs.getString("nombres"));
                cliente.setApellidos(rs.getString("apellidos"));
                cliente.setIdcargo(rs.getInt("idcargo"));
                cliente.setIdestado(rs.getInt("idestado"));
            }
        } catch (SQLException e) {
            System.out.println("Error en login: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return cliente;
    }
    
    public boolean MtdActualizarCliente(clsEntCliente cliente) {
    String sql = "UPDATE tbcliente SET email=?, nombres=?, apellidos=?, telefono=?, direccion=?, idcargo=?, idestado=? WHERE idcliente=?";
    try {
        con = cn.getConnection();
        st = con.prepareStatement(sql);
        st.setString(1, cliente.getEmail());
        st.setString(2, cliente.getNombres());
        st.setString(3, cliente.getApellidos());
        st.setString(4, cliente.getTelefono());
        st.setString(5, cliente.getDireccion());
        st.setInt(6, cliente.getIdcargo());
        st.setInt(7, cliente.getIdestado());
        st.setInt(8, cliente.getIdcliente());

        int rowsAffected = st.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("Error al actualizar cliente: " + e.getMessage());
        return false;
    } finally {
        try {
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}

public boolean MtdEliminarCliente(clsEntCliente cliente) {
    String sql = "DELETE FROM tbcliente WHERE idcliente = ?";
    try {
        con = cn.getConnection();
        st = con.prepareStatement(sql);
        st.setInt(1, cliente.getIdcliente());

        int rowsAffected = st.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("Error al eliminar cliente: " + e.getMessage());
        return false;
    } finally {
        try {
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}

public boolean MtdActualizarPerfil(clsEntCliente cliente) {
    String sql = "UPDATE tbcliente SET email=?, nombres=?, apellidos=?, telefono=?, direccion=? WHERE idcliente=?";
    try {
        con = cn.getConnection();
        st = con.prepareStatement(sql);
        st.setString(1, cliente.getEmail());
        st.setString(2, cliente.getNombres());
        st.setString(3, cliente.getApellidos());
        st.setString(4, cliente.getTelefono());
        st.setString(5, cliente.getDireccion());
        st.setInt(6, cliente.getIdcliente());

        int rowsAffected = st.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        System.out.println("Error al actualizar perfil: " + e.getMessage());
        return false;
    } finally {
        try {
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
}

public clsEntCliente MtdObtenerClientePorId(int idCliente) {
    clsEntCliente cliente = null;
    String sql = "SELECT * FROM tbcliente WHERE idcliente = ?";
    try {
        con = cn.getConnection();
        st = con.prepareStatement(sql);
        st.setInt(1, idCliente);
        rs = st.executeQuery();
        
        if (rs.next()) {
            cliente = new clsEntCliente();
            cliente.setIdcliente(rs.getInt("idcliente"));
            cliente.setDni(rs.getString("dni"));
            cliente.setEmail(rs.getString("email"));
            cliente.setNombres(rs.getString("nombres"));
            cliente.setApellidos(rs.getString("apellidos"));
            cliente.setTelefono(rs.getString("telefono"));
            cliente.setDireccion(rs.getString("direccion"));
            cliente.setIdcargo(rs.getInt("idcargo"));
            cliente.setIdestado(rs.getInt("idestado"));
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener cliente: " + e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            System.out.println("Error al cerrar recursos: " + e.getMessage());
        }
    }
    return cliente;
}
    public ResultSet MtdListarClientes() {
        String sql = "SELECT c.*, car.nombre as cargo, e.nombre as estado " +
                     "FROM tbcliente c " +
                     "INNER JOIN tbcargo car ON c.idcargo = car.idcargo " +
                     "INNER JOIN tbestado e ON c.idestado = e.idestado " +
                     "ORDER BY c.idcliente";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar clientes: " + e.getMessage());
            return null;
        }
    }
    
    public boolean MtdGuardarCliente(clsEntCliente cliente) {
        String sql = "INSERT INTO tbcliente (dni, email, clave, nombres, apellidos, telefono, direccion, idcargo, idestado) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setString(1, cliente.getDni());
            st.setString(2, cliente.getEmail());
            st.setString(3, cliente.getClave());
            st.setString(4, cliente.getNombres());
            st.setString(5, cliente.getApellidos());
            st.setString(6, cliente.getTelefono());
            st.setString(7, cliente.getDireccion());
            st.setInt(8, cliente.getIdcargo());
            st.setInt(9, cliente.getIdestado());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al guardar cliente: " + e.getMessage());
            return false;
        } finally {
            try {
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
    }
}