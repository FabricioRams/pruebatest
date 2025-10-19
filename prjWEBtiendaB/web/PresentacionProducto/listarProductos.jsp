<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegProducto"%>
<%@page import="java.sql.*"%>
<%
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("../PresentacionCliente/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Productos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header h1 {
            color: #333;
            margin: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }
        tr:hover {
            background-color: #f8f9fa;
            transform: translateY(-1px);
            transition: all 0.3s ease;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 2px 5px rgba(102, 126, 234, 0.3);
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(102, 126, 234, 0.4);
        }
        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #ffb300 100%);
            color: black;
            box-shadow: 0 2px 5px rgba(255, 193, 7, 0.3);
        }
        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 193, 7, 0.4);
        }
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            box-shadow: 0 2px 5px rgba(220, 53, 69, 0.3);
        }
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.4);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
        }
        .actions-cell {
            display: flex;
            gap: 8px;
        }
        .price {
            font-weight: bold;
            color: #28a745;
        }
        .stock {
            font-weight: bold;
        }
        .stock-high { color: #28a745; }
        .stock-medium { color: #ffc107; }
        .stock-low { color: #dc3545; }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            text-align: center;
            font-weight: 500;
        }
        .message-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .btn-cart {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            box-shadow: 0 2px 5px rgba(40, 167, 69, 0.3);
        }
        .btn-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.4);
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Lista de Productos</h1>
        <div>
            <a href="agregarProducto.jsp" class="btn btn-primary">Agregar Producto</a>
            
            <a href="../PresentacionCliente/carrito.jsp" class="btn btn-primary" style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%);">
                🛒 Ver Carrito
            </a>
            <a href="../PresentacionCliente/dashboard.jsp" class="btn btn-secondary">Dashboard</a>
        </div>
    </div>

    <%
        String mensaje = request.getParameter("mensaje");
        String exito = request.getParameter("exito");
        if (mensaje != null && !mensaje.isEmpty()) {
    %>
        <div class="message <%= "true".equals(exito) ? "message-success" : "message-error" %>">
            <%= mensaje %>
        </div>
    <% } %>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Marca</th>
                <th>Modelo</th>
                <th>Color</th>
                <th>Talla</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Agregar al Carrito</th> 
                <th>Operaciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                clsNegProducto negProducto = new clsNegProducto();
                ResultSet rs = negProducto.MtdListarProductos();
                if (rs != null) {
                    while (rs.next()) {
                        String stockClass = "stock-high";
                        int stock = rs.getInt("stock");
                        if (stock <= 5) stockClass = "stock-low";
                        else if (stock <= 15) stockClass = "stock-medium";
            %>
            <tr>
                <td><strong><%= rs.getInt("idproducto") %></strong></td>
                <td><%= rs.getString("nombre") %></td>
                <td><%= rs.getString("marca_nombre") %></td>
                <td><%= rs.getString("modelo_nombre") %></td>
                <td><%= rs.getString("color_nombre") %></td>
                <td><%= rs.getString("talla_valor") %> (<%= rs.getString("tipo_talla") %>)</td>
                <td class="price">S/. <%= rs.getBigDecimal("precio") %></td>
                <td class="stock <%= stockClass %>"><%= stock %></td>

               
                <td>
                    <% if (stock > 0) { %>
                    <form action="../PresentacionCliente/processAgregarCarrito.jsp" method="post" style="display: flex; align-items: center; gap: 5px;">
                        <input type="hidden" name="idProducto" value="<%= rs.getInt("idproducto") %>">
                        <input type="hidden" name="precio" value="<%= rs.getBigDecimal("precio") %>">
                        <input type="number" name="cantidad" value="1" min="1" max="<%= Math.min(stock, 10) %>" 
                               style="width: 60px; padding: 5px; border: 1px solid #ddd; border-radius: 4px;">
                        <button type="submit" class="btn btn-primary" style="padding: 5px 10px; font-size: 12px;">
                            🛒 Agregar
                        </button>
                    </form>
                    <% } else { %>
                        <span style="color: #dc3545; font-weight: bold;">Sin Stock</span>
                    <% } %>
                </td>

                <td class="actions-cell">
                    <a href="editarProducto.jsp?id=<%= rs.getInt("idproducto") %>" class="btn btn-warning">Editar</a>
                    <a href="eliminarProducto.jsp?id=<%= rs.getInt("idproducto") %>" 
                       class="btn btn-danger" 
                       onclick="return confirm('¿Estás seguro de eliminar el producto: <%= rs.getString("nombre") %>?')">Eliminar</a>
                </td>
            </tr>
            <%
                    }
                    try {
                        if (rs != null) rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                } else {
            %>
            <tr>
                <td colspan="10" style="text-align: center; padding: 40px;"> <!-- Cambiado a 10 columnas -->
                    No hay productos registrados
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>