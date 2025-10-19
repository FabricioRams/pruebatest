<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegCliente"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Sistema Tienda</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h1 {
            color: #333;
            margin-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #667eea;
            outline: none;
        }
        .btn-login {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-login:hover {
            background: #764ba2;
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>Iniciar Sesión</h1>
            <p>Ingresa a tu cuenta</p>
        </div>
        
        <%
            String mensajeError = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String usuario = request.getParameter("txtUsuario");
                String clave = request.getParameter("txtClave");
                
                if (usuario != null && clave != null && !usuario.trim().isEmpty() && !clave.trim().isEmpty()) {
                    clsNegCliente negCliente = new clsNegCliente();
                    clsEntCliente cliente = negCliente.MtdLogin(usuario, clave);
                    
                    if (cliente != null) {
                        session.setAttribute("cliente", cliente);
                        response.sendRedirect("dashboard.jsp");
                        return;
                    } else {
                        mensajeError = "Credenciales incorrectas o usuario inactivo";
                    }
                } else {
                    mensajeError = "Por favor, complete todos los campos";
                }
            }
        %>
        
        <% if (!mensajeError.isEmpty()) { %>
            <div class="error-message">
                <%= mensajeError %>
            </div>
        <% } %>
        
        <form method="POST" action="login.jsp">
            <div class="form-group">
                <label for="txtUsuario">DNI o Email:</label>
                <input type="text" id="txtUsuario" name="txtUsuario" required>
            </div>
            
            <div class="form-group">
                <label for="txtClave">Contraseña:</label>
                <input type="password" id="txtClave" name="txtClave" required>
            </div>
            
            <button type="submit" class="btn-login">Ingresar</button>
        </form>
        
        <div class="register-link">
            <p>¿No tienes cuenta? <a href="registrarCliente.jsp">Regístrate aquí</a></p>
        </div>
    </div>
</body>
</html>