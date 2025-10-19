package Negocio;

import Entidad.clsEntCarrito;
import Config.ClsConexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class clsNegCarrito {
    private Connection con = new ClsConexion().getConnection();
    
    // Agregar producto al carrito
    public String agregarAlCarrito(clsEntCarrito carrito) {
        try {
            // Verificar si el producto ya está en el carrito
            String sqlCheck = "SELECT idCarrito, cantidad FROM carrito WHERE idCliente = ? AND idProducto = ?";
            PreparedStatement psCheck = con.prepareStatement(sqlCheck);
            psCheck.setInt(1, carrito.getIdCliente());
            psCheck.setInt(2, carrito.getIdProducto());
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                // Actualizar cantidad si ya existe
                int nuevaCantidad = rs.getInt("cantidad") + carrito.getCantidad();
                String sqlUpdate = "UPDATE carrito SET cantidad = ? WHERE idCarrito = ?";
                PreparedStatement psUpdate = con.prepareStatement(sqlUpdate);
                psUpdate.setInt(1, nuevaCantidad);
                psUpdate.setInt(2, rs.getInt("idCarrito"));
                psUpdate.executeUpdate();
                return "Producto actualizado en carrito";
            } else {
           
                String sqlInsert = "INSERT INTO carrito (idCliente, idProducto, cantidad, precioUnitario, fechaAgregado) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
                PreparedStatement psInsert = con.prepareStatement(sqlInsert);
                psInsert.setInt(1, carrito.getIdCliente());
                psInsert.setInt(2, carrito.getIdProducto());
                psInsert.setInt(3, carrito.getCantidad());
                psInsert.setDouble(4, carrito.getPrecioUnitario());
                psInsert.executeUpdate();
                return "Producto agregado al carrito";
            }
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
    
    // Obtener carrito por cliente
    public List<clsEntCarrito> obtenerCarritoPorCliente(int idCliente) {
        List<clsEntCarrito> lista = new ArrayList<>();
        try {
            String sql = "SELECT c.*, p.nombre as nombreProducto, p.stock " +
                        "FROM carrito c " +
                        "INNER JOIN tbproducto p ON c.idProducto = p.idproducto " + 
                        "WHERE c.idCliente = ? " +
                        "ORDER BY c.fechaAgregado DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                clsEntCarrito carrito = new clsEntCarrito();
                carrito.setIdCarrito(rs.getInt("idCarrito"));
                carrito.setIdCliente(rs.getInt("idCliente"));
                carrito.setIdProducto(rs.getInt("idProducto"));
                carrito.setCantidad(rs.getInt("cantidad"));
                carrito.setPrecioUnitario(rs.getDouble("precioUnitario"));
                carrito.setFechaAgregado(rs.getTimestamp("fechaAgregado"));
                lista.add(carrito);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    // Actualizar cantidad
    public String actualizarCantidad(int idCarrito, int nuevaCantidad) {
        try {
            String sql = "UPDATE carrito SET cantidad = ? WHERE idCarrito = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, nuevaCantidad);
            ps.setInt(2, idCarrito);
            ps.executeUpdate();
            return "Cantidad actualizada";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
    
    // Eliminar producto del carrito
    public String eliminarDelCarrito(int idCarrito) {
        try {
            String sql = "DELETE FROM carrito WHERE idCarrito = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCarrito);
            ps.executeUpdate();
            return "Producto eliminado del carrito";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }

    public String vaciarCarrito(int idCliente) {
        try {
            String sql = "DELETE FROM carrito WHERE idCliente = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCliente);
            ps.executeUpdate();
            return "Carrito vaciado";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
    
    // Obtener total del carrito
    public double obtenerTotalCarrito(int idCliente) {
        double total = 0;
        try {
            String sql = "SELECT SUM(cantidad * precioUnitario) as total FROM carrito WHERE idCliente = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
}