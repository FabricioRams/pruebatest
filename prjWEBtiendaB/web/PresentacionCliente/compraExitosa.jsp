<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente" %>
<%
    // Verificar sesión
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compra Exitosa</title>
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
            max-width: 800px;
            margin: 0 auto;
        }
        .success-container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            text-align: center;
            margin: 40px 0;
            border-top: 5px solid #28a745;
        }
        .success-icon {
            font-size: 80px;
            color: #28a745;
            margin-bottom: 20px;
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
            margin: 10px;
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
        .confirmation-message {
            padding: 20px;
            margin: 30px 0;
            background: #d4edda;
            color: #155724;
            border-radius: 8px;
            border: 1px solid #c3e6cb;
            font-size: 16px;
        }
        h1 {
            color: #28a745;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
            margin: 15px 0;
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
        <div class="success-container">
            <h1>¡Compra Exitosa!</h1>
            
            <%
                String mensaje = request.getParameter("mensaje");
                if (mensaje != null && !mensaje.isEmpty()) {
            %>
                <div class="confirmation-message">
                    <strong>Confirmación:</strong> <%= mensaje %>
                </div>
            <% } %>
            
            <p>Gracias por tu compra, <strong style="color: #333;"><%= cliente.getNombres() %></strong>!</p>
            <p>Tu pedido ha sido procesado exitosamente. El stock de los productos ha sido actualizado.</p>
            <p>Recibirás una confirmación por correo electrónico pronto.</p>
            
            <div style="margin-top: 40px;">
                <a href="../PresentacionProducto/listarProductos.jsp" class="btn btn-primary">Continuar Comprando</a>
                <a href="dashboard.jsp" class="btn btn-success">Volver al Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html>