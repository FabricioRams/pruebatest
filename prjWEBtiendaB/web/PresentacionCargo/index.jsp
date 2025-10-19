<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="Entidad.clsEntCargo"%>
<%@page import="Negocio.clsNegCargo"%>
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
        <meta charset="UTF-8">
        <title>Mantenimiento de Cargos</title>
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
            .nav-buttons {
                display: flex;
                gap: 10px;
                align-items: center;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Mantenimiento de Cargos</h1>
            <div class="nav-buttons">
                <a href="../PresentacionCliente/dashboard.jsp" class="btn btn-secondary">← Volver al Dashboard</a>
                <a href="AgregarCargo.jsp" class="btn btn-primary">Agregar Cargo</a>
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
                    <th>ID CARGO</th>
                    <th>NOMBRE</th>
                    <th>OPERACIONES</th>
                </tr>
            </thead>
            <tbody>
                <%
                    clsNegCargo ObjNca = new clsNegCargo();
                    ResultSet rs = ObjNca.MtdListarCargo();
                    if (rs != null) {
                        while (rs.next()) {
                            clsEntCargo Objcargo = new clsEntCargo();
                            Objcargo.setIdcargo(rs.getInt("idcargo"));
                            Objcargo.setNombre(rs.getString("nombre"));
                %>
                <tr>
                    <td><strong><%= Objcargo.getIdcargo() %></strong></td>
                    <td><%= Objcargo.getNombre() %></td>
                    <td class="actions-cell">
                        <a href="editarCargo.jsp?id=<%= Objcargo.getIdcargo() %>" class="btn btn-warning">Editar</a>
                        <a href="eliminarCargo.jsp?id=<%= Objcargo.getIdcargo() %>" 
                           class="btn btn-danger" 
                           onclick="return confirm('¿Estás seguro de eliminar el cargo: <%= Objcargo.getNombre() %>?')">Eliminar</a>
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
                    <td colspan="3" style="text-align: center; padding: 40px;">
                        No hay cargos registrados
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </body>
</html>