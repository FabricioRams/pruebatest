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
import Entidad.clsEntModelo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegModelo {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    
    public ResultSet MtdListarModelos() {
        String sql = "SELECT m.*, ma.nombre as marca_nombre FROM tbmodelo m " +
                     "INNER JOIN tbmarca ma ON m.idmarca = ma.idmarca " +
                     "ORDER BY ma.nombre, m.nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar modelos: " + e.getMessage());
            return null;
        }
    }
    
    public boolean MtdGuardarModelo(clsEntModelo modelo) {
        String sql = "INSERT INTO tbmodelo (nombre, descripcion, idmarca) VALUES (?, ?, ?)";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setString(1, modelo.getNombre());
            st.setString(2, modelo.getDescripcion());
            st.setInt(3, modelo.getIdmarca());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al guardar modelo: " + e.getMessage());
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
    
    public List<clsEntModelo> MtdListarModelosPorMarca(int idMarca) {
        List<clsEntModelo> lista = new ArrayList<>();
        String sql = "SELECT * FROM tbmodelo WHERE idmarca = ? ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setInt(1, idMarca);
            rs = st.executeQuery();
            
            while (rs.next()) {
                clsEntModelo modelo = new clsEntModelo();
                modelo.setIdmodelo(rs.getInt("idmodelo"));
                modelo.setNombre(rs.getString("nombre"));
                modelo.setIdmarca(rs.getInt("idmarca"));
                lista.add(modelo);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar modelos por marca: " + e.getMessage());
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