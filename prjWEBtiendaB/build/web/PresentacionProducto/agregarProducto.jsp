<%-- 
    Document   : agregarProducto
    Created on : 9 oct. 2025, 5:45:52 p. m.
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegMarca"%>
<%@page import="Negocio.clsNegModelo"%>
<%@page import="Negocio.clsNegColor"%>
<%@page import="Negocio.clsNegTalla"%>
<%@page import="java.util.List"%>
<%
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("../PresentacionCliente/login.jsp");
        return;
    }
    
    clsNegMarca negMarca = new clsNegMarca();
    clsNegColor negColor = new clsNegColor();
    clsNegTalla negTalla = new clsNegTalla();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Agregar Producto</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
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
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
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
        <h1>Agregar Nuevo Producto</h1>
        
        <form action="procesarProducto.jsp" method="POST">
            <div class="form-group">
                <label for="txtNombre">Nombre del Producto:</label>
                <input type="text" id="txtNombre" name="txtNombre" required>
            </div>
            
            <div class="form-group">
                <label for="txtDescripcion">Descripción:</label>
                <textarea id="txtDescripcion" name="txtDescripcion" rows="3"></textarea>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtPrecio">Precio (S/.):</label>
                    <input type="number" id="txtPrecio" name="txtPrecio" step="0.01" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="txtStock">Stock:</label>
                    <input type="number" id="txtStock" name="txtStock" min="0" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="cboMarca">Marca:</label>
                    <select id="cboMarca" name="cboMarca" required onchange="cargarModelos()">
                        <option value="">Seleccionar Marca</option>
                        <% for (Entidad.clsEntMarca marca : negMarca.MtdListarMarcasCombo()) { %>
                            <option value="<%= marca.getIdmarca() %>"><%= marca.getNombre() %></option>
                        <% } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="cboModelo">Modelo:</label>
                    <select id="cboModelo" name="cboModelo" required>
                        <option value="">Primero seleccione una marca</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="cboColor">Color:</label>
                    <select id="cboColor" name="cboColor" required>
                        <option value="">Seleccionar Color</option>
                        <% for (Entidad.clsEntColor color : negColor.MtdListarColoresCombo()) { %>
                            <option value="<%= color.getIdcolor() %>" style="background-color: <%= color.getCodigo_hex() %>; color: white;">
                                <%= color.getNombre() %>
                            </option>
                        <% } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="cboTalla">Talla:</label>
                    <select id="cboTalla" name="cboTalla" required>
                        <option value="">Seleccionar Talla</option>
                        <% for (Entidad.clsEntTalla talla : negTalla.MtdListarTallasCombo()) { %>
                            <option value="<%= talla.getIdtalla() %>">
                                <%= talla.getValor() %> (<%= talla.getNombreTipoTalla() %>)
                            </option>
                        <% } %>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="txtImagen">URL de Imagen (opcional):</label>
                <input type="text" id="txtImagen" name="txtImagen" placeholder="https://ejemplo.com/imagen.jpg">
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Guardar Producto</button>
                <a href="listarProductos.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>

    <script>
        function cargarModelos() {
            var idMarca = document.getElementById('cboMarca').value;
            var comboModelo = document.getElementById('cboModelo');
            
            if (idMarca === '') {
                comboModelo.innerHTML = '<option value="">Primero seleccione una marca</option>';
                return;
            }
            
            comboModelo.innerHTML = '<option value="">Cargando modelos...</option>';
            
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    comboModelo.innerHTML = xhr.responseText;
                }
            };
            xhr.open('GET', 'cargarModelos.jsp?idMarca=' + idMarca, true);
            xhr.send();
        }
    </script>
</body>
</html>