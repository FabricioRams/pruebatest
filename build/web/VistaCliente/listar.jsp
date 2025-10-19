<%-- 
    Document   : listar
    Created on : 16 oct 2025, 17:52:10
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Modelo.Cliente"%>
<%@page import="ModeloDao.ClienteDAO"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clientes</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #2196F3;
                color: white;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            a {
                text-decoration: none;
                padding: 5px 10px;
                margin: 2px;
            }
            .btn-agregar {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                display: inline-block;
                margin-bottom: 20px;
                border-radius: 4px;
            }
            .btn-editar {
                background-color: #2196F3;
                color: white;
                border-radius: 4px;
            }
            .btn-eliminar {
                background-color: #f44336;
                color: white;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <h1>Mantenimiento de Clientes</h1>
        <a href="ClienteControlador?action=add" class="btn-agregar">Agregar Cliente</a>
        <table>
            <thead>
                <tr>
                    <th>DNI</th>
                    <th>NOMBRES</th>
                    <th>APELLIDOS</th>
                    <th>DIRECCIÓN</th>
                    <th>EMAIL</th>
                    <th>ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ClienteDAO dao = new ClienteDAO();
                    List<Cliente> list = dao.listar();
                    Iterator<Cliente> iter = list.iterator();
                    Cliente cli = null;
                    while (iter.hasNext()) {
                        cli = iter.next();
                %>
                <tr>
                    <td><%= cli.getDni()%></td>
                    <td><%= cli.getNombres()%></td>
                    <td><%= cli.getApellidos()%></td>
                    <td><%= cli.getDireccion()%></td>
                    <td><%= cli.getEmail()%></td>
                    <td>
                        <a href="ClienteControlador?action=editar&vdni=<%= cli.getDni()%>" class="btn-editar">Editar</a>
                        <a href="ClienteControlador?action=eliminar&vdni=<%= cli.getDni()%>" class="btn-eliminar" onclick="return confirm('¿Está seguro de eliminar este cliente?')">Eliminar</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <br>
        <a href="index.jsp">Regresar</a>
    </body>
</html>
