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
    
    if (clienteSesion.getIdcargo() != 1) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
    
    clsNegCargo negCargo = new clsNegCargo();
    clsNegEstado negEstado = new clsNegEstado();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Cliente</title>
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
        input[type="password"],
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
        }
        .btn-primary {
            background-color: #667eea;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
        }
        .form-row {
            display: flex;
            gap: 20px;
        }
        .form-row .form-group {
            flex: 1;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Registrar Nuevo Cliente</h1>
        
        <form action="procesarRegistroCliente.jsp" method="POST">
            <div class="form-row">
                <div class="form-group">
                    <label for="txtDNI">DNI:</label>
                    <input type="text" id="txtDNI" name="txtDNI" maxlength="8" required>
                </div>
                
                <div class="form-group">
                    <label for="txtEmail">Email:</label>
                    <input type="email" id="txtEmail" name="txtEmail" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtClave">Contraseña:</label>
                    <input type="password" id="txtClave" name="txtClave" required>
                </div>
                
                <div class="form-group">
                    <label for="txtConfirmarClave">Confirmar Contraseña:</label>
                    <input type="password" id="txtConfirmarClave" name="txtConfirmarClave" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtNombres">Nombres:</label>
                    <input type="text" id="txtNombres" name="txtNombres" required>
                </div>
                
                <div class="form-group">
                    <label for="txtApellidos">Apellidos:</label>
                    <input type="text" id="txtApellidos" name="txtApellidos" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtTelefono">Teléfono:</label>
                    <input type="text" id="txtTelefono" name="txtTelefono">
                </div>
                
                <div class="form-group">
                    <label for="cboCargo">Cargo:</label>
                    <select id="cboCargo" name="cboCargo" required>
                        <option value="">Seleccionar Cargo</option>
                        <%
                            ResultSet rsCargos = negCargo.MtdListarCargo();
                            if (rsCargos != null) {
                                while (rsCargos.next()) {
                        %>
                        <option value="<%= rsCargos.getInt("idcargo") %>">
                            <%= rsCargos.getString("nombre") %>
                        </option>
                        <%
                                }
                                try {
                                    if (rsCargos != null) rsCargos.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
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
                        %>
                        <option value="<%= rsEstados.getInt("idestado") %>">
                            <%= rsEstados.getString("nombre") %>
                        </option>
                        <%
                                }
                                try {
                                    if (rsEstados != null) rsEstados.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="txtDireccion">Dirección:</label>
                <textarea id="txtDireccion" name="txtDireccion" rows="3"></textarea>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Registrar Cliente</button>
                <a href="listarClientes.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>

    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            var clave = document.getElementById('txtClave').value;
            var confirmarClave = document.getElementById('txtConfirmarClave').value;
            
            if (clave !== confirmarClave) {
                e.preventDefault();
                alert('Las contraseñas no coinciden');
                return false;
            }
            
            if (clave.length < 6) {
                e.preventDefault();
                alert('La contraseña debe tener al menos 6 caracteres');
                return false;
            }
        });
    </script>
</body>
</html>