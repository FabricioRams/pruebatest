<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente, Negocio.clsNegCarrito, Entidad.clsEntCarrito, java.util.List" %>
<%
    // Verificar sesión
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    clsNegCarrito negCarrito = new clsNegCarrito();
    List<clsEntCarrito> carrito = negCarrito.obtenerCarritoPorCliente(cliente.getIdcliente());
    double total = negCarrito.obtenerTotalCarrito(cliente.getIdcliente());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .user-info {
            text-align: right;
        }
        .nav-menu {
            background: white;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .nav-menu a {
            margin-right: 20px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .nav-menu a:hover {
            color: #667eea;
        }
        .container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .carrito-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .carrito-header h1 {
            color: #333;
            margin: 0;
        }
        .carrito-item {
            background: white;
            padding: 20px;
            margin: 15px 0;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-left: 4px solid #667eea;
        }
        .total-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 30px;
            text-align: center;
            border-top: 3px solid #28a745;
        }
        .btn {
            padding: 10px 20px;
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
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            box-shadow: 0 2px 5px rgba(220, 53, 69, 0.3);
        }
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(220, 53, 69, 0.4);
        }
        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            box-shadow: 0 2px 5px rgba(40, 167, 69, 0.3);
        }
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(40, 167, 69, 0.4);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .cantidad-input {
            width: 70px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-align: center;
        }
        .price {
            font-weight: bold;
            color: #28a745;
            font-size: 16px;
        }
        .item-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }
        .item-info {
            flex: 1;
        }
        .item-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }
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
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .empty-cart h3 {
            color: #6c757d;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Sistema de Tienda</h1>
        <div class="user-info">
            <p>Bienvenido: <%= cliente.getNombres() + " " + cliente.getApellidos() %></p>
            <p>DNI: <%= cliente.getDni() %> | Email: <%= cliente.getEmail() %></p>
            <a href="logout.jsp" style="color: white;">Cerrar Sesión</a>
        </div>
    </div>
    
    <div class="nav-menu">
        <a href="dashboard.jsp">Inicio</a>
        <a href="../PresentacionProducto/listarProductos.jsp">Productos</a>
        <a href="carrito.jsp">Carrito</a>
        <% if (cliente.getIdcargo() == 1) { %>
            <a href="../PresentacionCargo/index.jsp">Cargos</a>
            <a href="../PresentacionCliente/listarClientes.jsp">Clientes</a>
        <% } %>
    </div>

    <div class="container">
        <div class="carrito-header">
            <h1>Carrito de Compras</h1>
            <div>
                <a href="../PresentacionProducto/listarProductos.jsp" class="btn btn-primary">Continuar Comprando</a>
                <a href="dashboard.jsp" class="btn btn-secondary">Dashboard</a>
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
        
        <% if (carrito.isEmpty()) { %>
            <div class="empty-cart">
                <h3>Tu carrito está vacío</h3>
                <p>Agrega algunos productos para comenzar a comprar</p>
                <a href="../PresentacionProducto/listarProductos.jsp" class="btn btn-primary">Descubrir Productos</a>
            </div>
        <% } else { %>
            <% for (clsEntCarrito item : carrito) { %>
            <div class="carrito-item">
                <div class="item-details">
                    <div class="item-info">
                        <h3>Producto #<%= item.getIdProducto() %></h3>
                        <p><strong>Cantidad:</strong> 
                            <form action="processActualizarCarrito.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="idCarrito" value="<%= item.getIdCarrito() %>">
                                <input type="number" name="cantidad" value="<%= item.getCantidad() %>" 
                                       min="1" max="10" class="cantidad-input">
                                <button type="submit" class="btn btn-primary" style="padding: 8px 12px;">Actualizar</button>
                            </form>
                        </p>
                        <p class="price">Precio unitario: S/. <%= String.format("%.2f", item.getPrecioUnitario()) %></p>
                        <p class="price"><strong>Subtotal: S/. <%= String.format("%.2f", item.getSubtotal()) %></strong></p>
                    </div>
                    <div class="item-actions">
                        <a href="processEliminarCarrito.jsp?idCarrito=<%= item.getIdCarrito() %>" 
                           class="btn btn-danger" 
                           onclick="return confirm('¿Eliminar producto del carrito?')">
                           Eliminar
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
            
            <div class="total-section">
                <h2 class="price">Total: S/. <%= String.format("%.2f", total) %></h2>
                <div style="margin-top: 20px; display: flex; gap: 10px; justify-content: center;">
                    <a href="../PresentacionProducto/listarProductos.jsp" class="btn btn-primary">Continuar Comprando</a>
                    <a href="processVaciarCarrito.jsp" class="btn btn-danger" 
                       onclick="return confirm('¿Vaciar todo el carrito?')">Vaciar Carrito</a>
                    <a href="checkout.jsp" class="btn btn-success">Proceder al Pago</a>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>