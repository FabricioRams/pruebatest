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
import Entidad.clsEntTalla;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegTalla {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    
    public ResultSet MtdListarTallas() {
        String sql = "SELECT t.*, tt.nombre as tipo_talla, tt.descripcion " +
                     "FROM tbtalla t " +
                     "INNER JOIN tbtipotalla tt ON t.idtipotalla = tt.idtipotalla " +
                     "ORDER BY tt.nombre, t.valor";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar tallas: " + e.getMessage());
            return null;
        }
    }
    
    public List<clsEntTalla> MtdListarTallasCombo() {
        List<clsEntTalla> lista = new ArrayList<>();
        String sql = "SELECT t.*, tt.nombre as tipo_talla FROM tbtalla t " +
                     "INNER JOIN tbtipotalla tt ON t.idtipotalla = tt.idtipotalla " +
                     "ORDER BY tt.nombre, t.valor";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            
            while (rs.next()) {
                clsEntTalla talla = new clsEntTalla();
                talla.setIdtalla(rs.getInt("idtalla"));
                talla.setValor(rs.getString("valor"));
                talla.setIdtipotalla(rs.getInt("idtipotalla"));
                talla.setNombreTipoTalla(rs.getString("tipo_talla"));
                lista.add(talla);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar tallas combo: " + e.getMessage());
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
    
    public List<clsEntTalla> MtdListarTallasPorTipo(int idTipoTalla) {
        List<clsEntTalla> lista = new ArrayList<>();
        String sql = "SELECT * FROM tbtalla WHERE idtipotalla = ? ORDER BY valor";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setInt(1, idTipoTalla);
            rs = st.executeQuery();
            
            while (rs.next()) {
                clsEntTalla talla = new clsEntTalla();
                talla.setIdtalla(rs.getInt("idtalla"));
                talla.setValor(rs.getString("valor"));
                lista.add(talla);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar tallas por tipo: " + e.getMessage());
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