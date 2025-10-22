<%-- 
    Document   : listar
    Created on : 19 oct 2025, 5:45:51 p.m.
    Author     : Mi Equipo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>
<%@page import="ModeloDao.UsuarioDAO"%>
<%@page import="java.util.*"%>
<%
    // Verificar permisos
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    if (usuarioSesion == null || usuarioSesion.getIdCargo() != 1) {
        response.sendRedirect("../home.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Usuarios</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f4f4f4;
            }
            .header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: #667eea;
                color: white;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            a {
                text-decoration: none;
                padding: 6px 12px;
                margin: 2px;
                border-radius: 4px;
                display: inline-block;
            }
            .btn-agregar {
                background-color: #4CAF50;
                color: white;
                padding: 12px 24px;
                margin-bottom: 20px;
            }
            .btn-editar {
                background-color: #2196F3;
                color: white;
            }
            .btn-eliminar {
                background-color: #f44336;
                color: white;
            }
            .btn-volver {
                background-color: #757575;
                color: white;
                padding: 10px 20px;
            }
            .badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: bold;
            }
            .badge-activo {
                background-color: #4CAF50;
                color: white;
            }
            .badge-inactivo {
                background-color: #f44336;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1> Gestión de Usuarios</h1>
            <p>Administración de usuarios del sistema</p>
        </div>
        
        <a href="UsuarioControlador?action=add" class="btn-agregar">+ Agregar Usuario</a>
        <a href="home.jsp" class="btn-volver"> Volver al Inicio</a>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Nombre Completo</th>
                    <th>Email</th>
                    <th>Cargo</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    UsuarioDAO dao = new UsuarioDAO();
                    List<Usuario> list = dao.listar();
                    for (Usuario u : list) {
                %>
                <tr>
                    <td><%= u.getIdUsuario()%></td>
                    <td><strong><%= u.getUsuario()%></strong></td>
                    <td><%= u.getNombre() + " " + u.getApellido()%></td>
                    <td><%= u.getEmail()%></td>
                    <td><%= u.getCargoNombre()%></td>
                    <td>
                        <% if (u.getEstado() == 1) { %>
                            <span class="badge badge-activo">Activo</span>
                        <% } else { %>
                            <span class="badge badge-inactivo">Inactivo</span>
                        <% } %>
                    </td>
                    <td>
                        <a href="UsuarioControlador?action=editar&id=<%= u.getIdUsuario()%>" class="btn-editar"> Editar</a>
                        <a href="UsuarioControlador?action=eliminar&id=<%= u.getIdUsuario()%>" 
                           class="btn-eliminar" 
                           onclick="return confirm('¿Está seguro de eliminar este usuario?')">
                             Eliminar
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </body>
</html>
