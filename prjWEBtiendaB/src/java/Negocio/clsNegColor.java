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
import Entidad.clsEntColor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegColor {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    
    public ResultSet MtdListarColores() {
        String sql = "SELECT * FROM tbcolor ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar colores: " + e.getMessage());
            return null;
        }
    }
    
    public List<clsEntColor> MtdListarColoresCombo() {
        List<clsEntColor> lista = new ArrayList<>();
        String sql = "SELECT * FROM tbcolor ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            
            while (rs.next()) {
                clsEntColor color = new clsEntColor();
                color.setIdcolor(rs.getInt("idcolor"));
                color.setNombre(rs.getString("nombre"));
                color.setCodigo_hex(rs.getString("codigo_hex"));
                lista.add(color);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar colores combo: " + e.getMessage());
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