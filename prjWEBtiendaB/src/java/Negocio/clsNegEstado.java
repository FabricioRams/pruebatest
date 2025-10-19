/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Negocio;

/**
 *
 * @author kira1
 */
import Config.ClsConexion;
import Entidad.clsEntEstado;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Config.ClsConexion;
import Entidad.clsEntEstado;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegEstado {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    
    public ResultSet MtdListarEstados() {
        String sql = "SELECT * FROM tbestado ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar estados: " + e.getMessage());
            return null;
        }
    }
    
    public List<clsEntEstado> MtdListarEstadosCombo() {
        List<clsEntEstado> lista = new ArrayList<>();
        String sql = "SELECT * FROM tbestado ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            
            while (rs.next()) {
                clsEntEstado estado = new clsEntEstado();
                estado.setIdestado(rs.getInt("idestado"));
                estado.setNombre(rs.getString("nombre"));
                lista.add(estado);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar estados combo: " + e.getMessage());
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