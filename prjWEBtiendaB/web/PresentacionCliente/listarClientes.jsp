<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegCliente"%>
<%@page import="java.sql.*"%>
<%
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Solo administradores pueden ver esta página
    if (cliente.getIdcargo() != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Clientes</title>
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
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #667eea;
            color: white;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        .btn-primary {
            background-color: #667eea;
            color: white;
        }
        .btn-warning {
            background-color: #ffc107;
            color: black;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .status-active {
            color: #28a745;
            font-weight: bold;
        }
        .status-inactive {
            color: #dc3545;
            font-weight: bold;
        }
        .badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            color: white;
        }
        .badge-admin { background-color: #dc3545; }
        .badge-vendedor { background-color: #007bff; }
        .badge-cliente { background-color: #28a745; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Lista de Clientes</h1>
        <div>
            <a href="registrarCliente.jsp" class="btn btn-primary">Agregar Cliente</a>
            <a href="dashboard.jsp" class="btn">Volver al Dashboard</a>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>DNI</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Email</th>
                <th>Teléfono</th>
                <th>Cargo</th>
                <th>Estado</th>
                <th>Operaciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                clsNegCliente negCliente = new clsNegCliente();
                ResultSet rs = negCliente.MtdListarClientes();
                if (rs != null) {
                    while (rs.next()) {
                        String cargoClass = "";
                        String cargoText = "";
                        switch(rs.getString("cargo")) {
                            case "Administrador":
                                cargoClass = "badge-admin";
                                break;
                            case "Vendedor":
                                cargoClass = "badge-vendedor";
                                break;
                            case "Cliente":
                                cargoClass = "badge-cliente";
                                break;
                        }
            %>
            <tr>
                <td><%= rs.getInt("idcliente") %></td>
                <td><%= rs.getString("dni") %></td>
                <td><%= rs.getString("nombres") %></td>
                <td><%= rs.getString("apellidos") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("telefono") != null ? rs.getString("telefono") : "N/A" %></td>
                <td><span class="badge <%= cargoClass %>"><%= rs.getString("cargo") %></span></td>
                <td class="<%= "Activo".equals(rs.getString("estado")) ? "status-active" : "status-inactive" %>">
                    <%= rs.getString("estado") %>
                </td>
                <td>
                    <a href="editarCliente.jsp?id=<%= rs.getInt("idcliente") %>" class="btn btn-warning">Editar</a>
                    <a href="eliminarCliente.jsp?id=<%= rs.getInt("idcliente") %>" 
                       class="btn btn-danger" 
                       onclick="return confirm('¿Estás seguro de eliminar este cliente?')">Eliminar</a>
                </td>
            </tr>
            <%
                    }
                    // Cerrar el ResultSet después de usarlo
                    try {
                        if (rs != null) rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>