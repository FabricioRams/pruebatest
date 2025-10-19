<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("../PresentacionCliente/login.jsp");
        return;
    }
    
    if (cliente.getIdcargo() != 1) {
        response.sendRedirect("../PresentacionCliente/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agregar Cargo</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 500px;
                margin: 0 auto;
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }
            .form-group {
                margin-bottom: 25px;
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                color: #333;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            input[type="text"] {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 16px;
                box-sizing: border-box;
                transition: all 0.3s ease;
                background-color: #f8f9fa;
            }
            input[type="text"]:focus {
                border-color: #667eea;
                background-color: white;
                outline: none;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }
            .btn {
                padding: 12px 30px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-size: 16px;
                font-weight: 600;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }
            .btn-secondary {
                background: #6c757d;
                color: white;
                box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
            }
            .btn-secondary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
            }
            .form-actions {
                display: flex;
                gap: 15px;
                justify-content: center;
                margin-top: 30px;
            }
            .back-link {
                text-align: center;
                margin-top: 20px;
            }
            .back-link a {
                color: #667eea;
                text-decoration: none;
                font-weight: 500;
            }
            .back-link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Agregar Nuevo Cargo</h1>
            <form action="AddCargo.jsp" method="POST">
                <div class="form-group">
                    <label for="txtID">ID CARGO:</label>
                    <input type="text" id="txtID" name="txtID" required 
                           placeholder="Ingrese el ID numérico del cargo">
                </div>
                
                <div class="form-group">
                    <label for="txtNombre">NOMBRE DEL CARGO:</label>
                    <input type="text" id="txtNombre" name="txtNombre" required 
                           placeholder="Ingrese el nombre del cargo">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Guardar Cargo</button>
                    <a href="index.jsp" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
            
            <div class="back-link">
                <a href="index.jsp">← Volver al listado de cargos</a>
            </div>
        </div>
    </body>
</html>