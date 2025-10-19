package Negocio;

import Config.ClsConexion;
import java.sql.*;
import Entidad.clsEntCargo;

import java.util.ArrayList;
import java.util.List;

public class clsNegCargo {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    clsEntCargo c = new clsEntCargo();

    public ResultSet MtdListarCargo() {
        ResultSet rs = null;
        String sql = "SELECT * FROM tbcargo";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery(); 
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar cargos: " + e.getMessage());
        }
        return null;
    }
    
    public List<clsEntCargo> MtdListarCargosCombo() {
        List<clsEntCargo> lista = new ArrayList<>();
        String sql = "SELECT * FROM tbcargo ORDER BY nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            
            while (rs.next()) {
                clsEntCargo cargo = new clsEntCargo();
                cargo.setIdcargo(rs.getInt("idcargo"));
                cargo.setNombre(rs.getString("nombre"));
                lista.add(cargo);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar cargos combo: " + e.getMessage());
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

    public boolean MtdGuardarCargo(clsEntCargo ObjEC) {
        String sql = "INSERT INTO tbcargo(idcargo, nombre) VALUES ('" + ObjEC.getIdcargo() + "', '" + ObjEC.getNombre() + "')";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al guardar cargo: " + e.getMessage());
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

    public boolean MtdEliminarCargo(clsEntCargo ObjEC) {
        String sql = "DELETE FROM tbcargo WHERE idcargo = ?";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setInt(1, ObjEC.getIdcargo());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar cargo: " + e.getMessage());
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
    
    public boolean MtdActualizarCargo(clsEntCargo ObjEC) {
        String sql = "UPDATE tbcargo SET nombre = ? WHERE idcargo = ?";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setString(1, ObjEC.getNombre());
            st.setInt(2, ObjEC.getIdcargo());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar cargo: " + e.getMessage());
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