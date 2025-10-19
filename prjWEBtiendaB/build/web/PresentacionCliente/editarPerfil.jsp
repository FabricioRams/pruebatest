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
    <title>Editar Mi Perfil</title>
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input:focus, textarea:focus {
            border-color: #667eea;
            outline: none;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #667eea;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .form-row {
            display: flex;
            gap: 20px;
        }
        .form-row .form-group {
            flex: 1;
        }
        .readonly-field {
            background-color: #f8f9fa;
            color: #6c757d;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Editar Mi Perfil</h1>
        
        <form action="procesarActualizarPerfil.jsp" method="POST">
            <div class="form-row">
                <div class="form-group">
                    <label for="txtDNI">DNI:</label>
                    <input type="text" id="txtDNI" name="txtDNI" value="<%= cliente.getDni() %>" class="readonly-field" readonly>
                </div>
                
                <div class="form-group">
                    <label for="txtEmail">Email:</label>
                    <input type="email" id="txtEmail" name="txtEmail" value="<%= cliente.getEmail() %>" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtNombres">Nombres:</label>
                    <input type="text" id="txtNombres" name="txtNombres" value="<%= cliente.getNombres() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="txtApellidos">Apellidos:</label>
                    <input type="text" id="txtApellidos" name="txtApellidos" value="<%= cliente.getApellidos() %>" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="txtTelefono">Teléfono:</label>
                <input type="tel" id="txtTelefono" name="txtTelefono" value="<%= cliente.getTelefono() != null ? cliente.getTelefono() : "" %>">
            </div>
            
            <div class="form-group">
                <label for="txtDireccion">Dirección:</label>
                <textarea id="txtDireccion" name="txtDireccion" rows="3"><%= cliente.getDireccion() != null ? cliente.getDireccion() : "" %></textarea>
            </div>
            
            <div class="form-group">
                <label for="txtClaveActual">Contraseña Actual (para confirmar cambios):</label>
                <input type="password" id="txtClaveActual" name="txtClaveActual" required>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Actualizar Perfil</button>
                <a href="perfil.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>