<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Entidad.clsEntCargo"%>
<%@page import="Negocio.clsNegCargo"%>
<%@page import="java.sql.*"%>
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

    String idParam = request.getParameter("id");
    clsEntCargo cargo = new clsEntCargo();
    boolean encontrado = false;
    
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int idCargo = Integer.parseInt(idParam);
            clsNegCargo negCargo = new clsNegCargo();
            ResultSet rs = negCargo.MtdListarCargo();
            
            while (rs != null && rs.next()) {
                if (rs.getInt("idcargo") == idCargo) {
                    cargo.setIdcargo(rs.getInt("idcargo"));
                    cargo.setNombre(rs.getString("nombre"));
                    encontrado = true;
                    break;
                }
            }
            
            if (rs != null) rs.close();
            
        } catch (NumberFormatException e) {
            out.println("<div class='error'>Error: ID de cargo inválido</div>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Cargo</title>
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
        }
        input[type="text"]:focus {
            border-color: #667eea;
            background-color: white;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .readonly-field {
            background-color: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
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
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #f5c6cb;
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
        <h1> Editar Cargo</h1>
        
        <% if (!encontrado && idParam != null) { %>
            <div class="error">
                Error: No se encontró el cargo con ID <%= idParam %>
            </div>
            <div style="text-align: center; margin-top: 20px;">
                <a href="index.jsp" class="btn btn-secondary">← Volver al Listado</a>
            </div>
        <% } else if (encontrado) { %>
        
        <form action="ActualizarCargo.jsp" method="POST">
            <div class="form-group">
                <label for="txtID">ID CARGO:</label>
                <input type="text" id="txtID" name="txtID" value="<%= cargo.getIdcargo() %>" 
                       class="readonly-field" readonly>
            </div>
            
            <div class="form-group">
                <label for="txtNombre">NOMBRE DEL CARGO:</label>
                <input type="text" id="txtNombre" name="txtNombre" value="<%= cargo.getNombre() %>" required 
                       placeholder="Ingrese el nuevo nombre del cargo">
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Actualizar Cargo</button>
                <a href="index.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
        
        <div class="back-link">
            <a href="index.jsp">← Volver al listado de cargos</a>
        </div>
        <% } %>
    </div>
</body>
</html>