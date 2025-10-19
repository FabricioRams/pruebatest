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
import Entidad.clsEntProducto;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegProducto {
    ClsConexion cn = new ClsConexion();
    Connection con;
    PreparedStatement st;
    ResultSet rs;
    
    public ResultSet MtdListarProductos() {
        String sql = "SELECT p.*, m.nombre as modelo_nombre, ma.nombre as marca_nombre, " +
                     "c.nombre as color_nombre, t.valor as talla_valor, tt.nombre as tipo_talla " +
                     "FROM tbproducto p " +
                     "INNER JOIN tbmodelo m ON p.idmodelo = m.idmodelo " +
                     "INNER JOIN tbmarca ma ON m.idmarca = ma.idmarca " +
                     "INNER JOIN tbcolor c ON p.idcolor = c.idcolor " +
                     "INNER JOIN tbtalla t ON p.idtalla = t.idtalla " +
                     "INNER JOIN tbtipotalla tt ON t.idtipotalla = tt.idtipotalla " +
                     "WHERE p.activo = true " +
                     "ORDER BY ma.nombre, m.nombre, p.nombre";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            rs = st.executeQuery();
            return rs;
        } catch (SQLException e) {
            System.out.println("Error al listar productos: " + e.getMessage());
            return null;
        }
    }
    
    public boolean MtdGuardarProducto(clsEntProducto producto) {
        String sql = "INSERT INTO tbproducto (nombre, descripcion, precio, stock, idmodelo, idcolor, idtalla, imagen) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setString(1, producto.getNombre());
            st.setString(2, producto.getDescripcion());
            st.setBigDecimal(3, producto.getPrecio());
            st.setInt(4, producto.getStock());
            st.setInt(5, producto.getIdmodelo());
            st.setInt(6, producto.getIdcolor());
            st.setInt(7, producto.getIdtalla());
            st.setString(8, producto.getImagen());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al guardar producto: " + e.getMessage());
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
    
    public boolean MtdActualizarProducto(clsEntProducto producto) {
        String sql = "UPDATE tbproducto SET nombre=?, descripcion=?, precio=?, stock=?, " +
                     "idmodelo=?, idcolor=?, idtalla=?, imagen=? WHERE idproducto=?";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setString(1, producto.getNombre());
            st.setString(2, producto.getDescripcion());
            st.setBigDecimal(3, producto.getPrecio());
            st.setInt(4, producto.getStock());
            st.setInt(5, producto.getIdmodelo());
            st.setInt(6, producto.getIdcolor());
            st.setInt(7, producto.getIdtalla());
            st.setString(8, producto.getImagen());
            st.setInt(9, producto.getIdproducto());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al actualizar producto: " + e.getMessage());
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
    
    public boolean MtdEliminarProducto(int idProducto) {
        String sql = "UPDATE tbproducto SET activo = false WHERE idproducto = ?";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setInt(1, idProducto);
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar producto: " + e.getMessage());
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
    
    public clsEntProducto MtdObtenerProductoPorId(int idProducto) {
        clsEntProducto producto = null;
        String sql = "SELECT p.*, m.nombre as modelo_nombre, ma.nombre as marca_nombre, " +
                     "c.nombre as color_nombre, t.valor as talla_valor " +
                     "FROM tbproducto p " +
                     "INNER JOIN tbmodelo m ON p.idmodelo = m.idmodelo " +
                     "INNER JOIN tbmarca ma ON m.idmarca = ma.idmarca " +
                     "INNER JOIN tbcolor c ON p.idcolor = c.idcolor " +
                     "INNER JOIN tbtalla t ON p.idtalla = t.idtalla " +
                     "WHERE p.idproducto = ?";
        try {
            con = cn.getConnection();
            st = con.prepareStatement(sql);
            st.setInt(1, idProducto);
            rs = st.executeQuery();
            
            if (rs.next()) {
                producto = new clsEntProducto();
                producto.setIdproducto(rs.getInt("idproducto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPrecio(rs.getBigDecimal("precio"));
                producto.setStock(rs.getInt("stock"));
                producto.setIdmodelo(rs.getInt("idmodelo"));
                producto.setIdcolor(rs.getInt("idcolor"));
                producto.setIdtalla(rs.getInt("idtalla"));
                producto.setImagen(rs.getString("imagen"));
                producto.setNombreModelo(rs.getString("modelo_nombre"));
                producto.setNombreMarca(rs.getString("marca_nombre"));
                producto.setNombreColor(rs.getString("color_nombre"));
                producto.setValorTalla(rs.getString("talla_valor"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener producto: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                System.out.println("Error al cerrar recursos: " + e.getMessage());
            }
        }
        return producto;
    }
    
    public String procesarCompra(int idCliente) {
        Connection con = new ClsConexion().getConnection();
        try {
            con.setAutoCommit(false); // Iniciar transacción

            // 1. Obtener productos del carrito del cliente
            String sqlCarrito = "SELECT * FROM carrito WHERE idCliente = ?";
            PreparedStatement psCarrito = con.prepareStatement(sqlCarrito);
            psCarrito.setInt(1, idCliente);
            ResultSet rs = psCarrito.executeQuery();

            // 2. Actualizar stock para cada producto en el carrito
            while (rs.next()) {
                int idProducto = rs.getInt("idProducto");
                int cantidadComprada = rs.getInt("cantidad");

                // Verificar stock disponible
                String sqlStock = "SELECT stock FROM tbproducto WHERE idproducto = ?";
                PreparedStatement psStock = con.prepareStatement(sqlStock);
                psStock.setInt(1, idProducto);
                ResultSet rsStock = psStock.executeQuery();

                if (rsStock.next()) {
                    int stockActual = rsStock.getInt("stock");
                    if (stockActual < cantidadComprada) {
                        con.rollback();
                        return "Error: Stock insuficiente para el producto ID " + idProducto + 
                               ". Stock disponible: " + stockActual;
                    }

                    // Actualizar stock
                    String sqlUpdate = "UPDATE tbproducto SET stock = stock - ? WHERE idproducto = ?";
                    PreparedStatement psUpdate = con.prepareStatement(sqlUpdate);
                    psUpdate.setInt(1, cantidadComprada);
                    psUpdate.setInt(2, idProducto);
                    psUpdate.executeUpdate();
                }
            }

            // 3. Vaciar el carrito del cliente
            String sqlVaciar = "DELETE FROM carrito WHERE idCliente = ?";
            PreparedStatement psVaciar = con.prepareStatement(sqlVaciar);
            psVaciar.setInt(1, idCliente);
            psVaciar.executeUpdate();

            // 4. Confirmar transacción
            con.commit();
            return "Compra procesada exitosamente. Stock actualizado y carrito vaciado.";

        } catch (Exception e) {
            try {
                con.rollback(); // Revertir en caso de error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return "Error al procesar la compra: " + e.getMessage();
        } finally {
            try {
                con.setAutoCommit(true);
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}