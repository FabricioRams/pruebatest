<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente, Negocio.clsNegCarrito, Entidad.clsEntCarrito, Negocio.clsNegProducto, java.util.List" %>
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
    
    // Procesar la compra si se envió el formulario
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            clsNegProducto negProducto = new clsNegProducto();
            String resultado = negProducto.procesarCompra(cliente.getIdcliente());
            
            if (resultado.startsWith("Error")) {
                response.sendRedirect("checkout.jsp?mensaje=" + 
                                    java.net.URLEncoder.encode(resultado, "UTF-8") + "&exito=false");
            } else {
                response.sendRedirect("compraExitosa.jsp?mensaje=" + 
                                    java.net.URLEncoder.encode(resultado, "UTF-8") + "&exito=true");
            }
        } catch (Exception e) {
            response.sendRedirect("checkout.jsp?mensaje=Error: " + 
                                java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "&exito=false");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Finalizar Compra</title>
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
            max-width: 1000px;
            margin: 0 auto;
        }
        .checkout-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .checkout-header h1 {
            color: #333;
            margin: 0;
        }
        .resumen-item {
            background: white;
            padding: 20px;
            margin: 15px 0;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-left: 4px solid #28a745;
        }
        .total-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 30px;
            border-top: 3px solid #667eea;
        }
        .btn {
            padding: 12px 25px;
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
        .price {
            font-weight: bold;
            color: #28a745;
            font-size: 18px;
        }
        .form-group {
            margin: 20px 0;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 2px rgba(102, 126, 234, 0.1);
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
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            flex-wrap: wrap;
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
        <div class="checkout-header">
            <h1>Finalizar Compra</h1>
            <div>
                <a href="carrito.jsp" class="btn btn-secondary">Volver al Carrito</a>
                <a href="../PresentacionProducto/listarProductos.jsp" class="btn btn-primary">Seguir Comprando</a>
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
                <h3>No hay productos en el carrito</h3>
                <p>Agrega algunos productos para finalizar tu compra</p>
                <a href="../PresentacionProducto/listarProductos.jsp" class="btn btn-primary">Descubrir Productos</a>
            </div>
        <% } else { %>
            <h2 style="color: #333; margin-bottom: 20px;">Resumen de tu Pedido</h2>
            
            <% for (clsEntCarrito item : carrito) { %>
            <div class="resumen-item">
                <h3>Producto #<%= item.getIdProducto() %></h3>
                <p><strong>Cantidad:</strong> <%= item.getCantidad() %></p>
                <p class="price">Precio unitario: S/. <%= String.format("%.2f", item.getPrecioUnitario()) %></p>
                <p class="price"><strong>Subtotal: S/. <%= String.format("%.2f", item.getSubtotal()) %></strong></p>
            </div>
            <% } %>
            
            <div class="total-section">
                <h2 class="price" style="text-align: center; font-size: 24px;">Total a Pagar: S/. <%= String.format("%.2f", total) %></h2>
                
                <form method="POST" action="checkout.jsp">
                    <div class="form-group">
                        <label for="metodoPago">Método de Pago:</label>
                        <select id="metodoPago" name="metodoPago" required>
                            <option value="">Seleccione método de pago</option>
                            <option value="efectivo">Pago en Efectivo</option>
                            <option value="tarjeta">Tarjeta de Crédito/Débito</option>
                            <option value="transferencia">Transferencia Bancaria</option>
                            <option value="yape">Yape</option>
                            <option value="plin">Plin</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="direccionEnvio">Dirección de Envío:</label>
                        <input type="text" id="direccionEnvio" name="direccionEnvio" 
                               value="<%= cliente.getDireccion() != null ? cliente.getDireccion() : "" %>" 
                               placeholder="Ingrese su dirección de envío" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="telefonoContacto">Teléfono de Contacto:</label>
                        <input type="text" id="telefonoContacto" name="telefonoContacto" 
                               value="<%= cliente.getTelefono() != null ? cliente.getTelefono() : "" %>" 
                               placeholder="Ingrese su teléfono" required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-success" style="font-size: 16px; padding: 15px 30px;">
                            Confirmar Compra
                        </button>
                        <a href="carrito.jsp" class="btn btn-secondary">Volver al Carrito</a>
                        <a href="../PresentacionProducto/listarProductos.jsp" class="btn btn-primary">Seguir Comprando</a>
                    </div>
                </form>
            </div>
        <% } %>
    </div>
</body>
</html>