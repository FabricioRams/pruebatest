<%-- 
    Document   : editarCliente
    Created on : 10 oct 2025, 4:11:18
    Author     : kira1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegCliente"%>
<%@page import="Negocio.clsNegCargo"%>
<%@page import="Negocio.clsNegEstado"%>
<%@page import="java.sql.*"%>
<%
    clsEntCliente clienteSesion = (clsEntCliente) session.getAttribute("cliente");
    if (clienteSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Solo administradores pueden editar clientes
    if (clienteSesion.getIdcargo() != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    clsEntCliente cliente = null;
    boolean encontrado = false;
    
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int idCliente = Integer.parseInt(idParam);
            clsNegCliente negCliente = new clsNegCliente();
            ResultSet rs = negCliente.MtdListarClientes();
            
            while (rs != null && rs.next()) {
                if (rs.getInt("idcliente") == idCliente) {
                    cliente = new clsEntCliente();
                    cliente.setIdcliente(rs.getInt("idcliente"));
                    cliente.setDni(rs.getString("dni"));
                    cliente.setEmail(rs.getString("email"));
                    cliente.setNombres(rs.getString("nombres"));
                    cliente.setApellidos(rs.getString("apellidos"));
                    cliente.setTelefono(rs.getString("telefono"));
                    cliente.setDireccion(rs.getString("direccion"));
                    cliente.setIdcargo(rs.getInt("idcargo"));
                    cliente.setIdestado(rs.getInt("idestado"));
                    encontrado = true;
                    break;
                }
            }
            
            if (rs != null) rs.close();
            
        } catch (NumberFormatException e) {
            out.println("<div class='error'>Error: ID de cliente inválido</div>");
        }
    }
    
    clsNegCargo negCargo = new clsNegCargo();
    clsNegEstado negEstado = new clsNegEstado();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Cliente</title>
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
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input:focus, select:focus, textarea:focus {
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
        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Editar Cliente</h1>
        
        <% if (!encontrado && idParam != null) { %>
            <div class="error">
                Error: No se encontró el cliente con ID <%= idParam %>
            </div>
            <div style="text-align: center; margin-top: 20px;">
                <a href="listarClientes.jsp" class="btn btn-secondary">Volver al Listado</a>
            </div>
        <% } else if (encontrado) { %>
        
        <form action="procesarActualizarCliente.jsp" method="POST">
            <input type="hidden" name="txtID" value="<%= cliente.getIdcliente() %>">
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtDNI">DNI:</label>
                    <input type="text" id="txtDNI" name="txtDNI" value="<%= cliente.getDni() %>" maxlength="8" required readonly style="background-color: #f8f9fa;">
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
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtTelefono">Teléfono:</label>
                    <input type="text" id="txtTelefono" name="txtTelefono" value="<%= cliente.getTelefono() != null ? cliente.getTelefono() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="cboCargo">Cargo:</label>
                    <select id="cboCargo" name="cboCargo" required>
                        <option value="">Seleccionar Cargo</option>
                        <%
                            ResultSet rsCargos = negCargo.MtdListarCargo();
                            if (rsCargos != null) {
                                while (rsCargos.next()) {
                                    String selected = (rsCargos.getInt("idcargo") == cliente.getIdcargo()) ? "selected" : "";
                        %>
                        <option value="<%= rsCargos.getInt("idcargo") %>" <%= selected %>>
                            <%= rsCargos.getString("nombre") %>
                        </option>
                        <%
                                }
                                rsCargos.close();
                            }
                        %>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="cboEstado">Estado:</label>
                    <select id="cboEstado" name="cboEstado" required>
                        <option value="">Seleccionar Estado</option>
                        <%
                            ResultSet rsEstados = negEstado.MtdListarEstados();
                            if (rsEstados != null) {
                                while (rsEstados.next()) {
                                    String selected = (rsEstados.getInt("idestado") == cliente.getIdestado()) ? "selected" : "";
                        %>
                        <option value="<%= rsEstados.getInt("idestado") %>" <%= selected %>>
                            <%= rsEstados.getString("nombre") %>
                        </option>
                        <%
                                }
                                rsEstados.close();
                            }
                        %>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="txtDireccion">Dirección:</label>
                <textarea id="txtDireccion" name="txtDireccion" rows="3"><%= cliente.getDireccion() != null ? cliente.getDireccion() : "" %></textarea>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Actualizar Cliente</button>
                <a href="listarClientes.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
        <% } %>
    </div>
</body>
</html>