<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%
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
    <title>Dashboard - Sistema Tienda</title>
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
        }
        .welcome-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
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
        <% if (cliente.getIdcargo() == 1) { %>
            <a href="../PresentacionCargo/index.jsp">Cargos</a>
            <a href="../PresentacionCliente/listarClientes.jsp">Clientes</a>
        <% } %>
    </div>
    
    <div class="container">
        <div class="welcome-card">
            <h2>Bienvenido al Sistema</h2>
            <p>Selecciona una opción del menú para comenzar</p>
        </div>
    </div>
</body>
</html>