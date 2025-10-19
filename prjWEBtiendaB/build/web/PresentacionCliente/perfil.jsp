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
    <title>Mi Perfil</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .profile-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eee;
        }
        .profile-info {
            margin-bottom: 20px;
        }
        .info-group {
            margin-bottom: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .info-label {
            font-weight: bold;
            color: #333;
        }
        .info-value {
            color: #666;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #667eea;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-header">
            <h1>Mi Perfil</h1>
            <p>Información de tu cuenta</p>
        </div>
        
        <div class="profile-info">
            <div class="info-group">
                <div class="info-label">DNI:</div>
                <div class="info-value"><%= cliente.getDni() %></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Email:</div>
                <div class="info-value"><%= cliente.getEmail() %></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Nombres Completos:</div>
                <div class="info-value"><%= cliente.getNombres() + " " + cliente.getApellidos() %></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Teléfono:</div>
                <div class="info-value"><%= cliente.getTelefono() != null ? cliente.getTelefono() : "No registrado" %></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Dirección:</div>
                <div class="info-value"><%= cliente.getDireccion() != null ? cliente.getDireccion() : "No registrada" %></div>
            </div>
            
            <div class="info-group">
                <div class="info-label">Fecha de Registro:</div>
                <div class="info-value"><%= cliente.getFecha_registro() != null ? cliente.getFecha_registro().toString() : "No disponible" %></div>
            </div>
        </div>
        
        <div style="text-align: center;">
            <a href="dashboard.jsp" class="btn btn-primary">Volver al Dashboard</a>
            <a href="editarPerfil.jsp" class="btn btn-primary">Editar Perfil</a>
        </div>
    </div>
</body>
</html>