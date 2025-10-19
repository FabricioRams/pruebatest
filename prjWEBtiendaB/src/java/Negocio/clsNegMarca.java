/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Negocio;

/**
 *
 * @author HP
 */
import Config.ClsConexion;
import Entidad.clsEntMarca;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegMarca {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    
    public ResultSet MtdListarMarcas() {
        String sql = "SELECT * FROM tbmarca ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar marcas: " + e.getMessage());
            return null;
        }
    }
    
    public boolean MtdGuardarMarca(clsEntMarca marca) {
        String sql = "INSERT INTO tbmarca (nombre, descripcion) VALUES (?, ?)";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setString(1, marca.getNombre());
            st.setString(2, marca.getDescripcion());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al guardar marca: " + e.getMessage());
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
    
    public List<clsEntMarca> MtdListarMarcasCombo() {
        List<clsEntMarca> lista = new ArrayList<>();
        String sql = "SELECT * FROM tbmarca ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            
            while (rs.next()) {
                clsEntMarca marca = new clsEntMarca();
                marca.setIdmarca(rs.getInt("idmarca"));
                marca.setNombre(rs.getString("nombre"));
                lista.add(marca);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar marcas combo: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return lista;
    }
}