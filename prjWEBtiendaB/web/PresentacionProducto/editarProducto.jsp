<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Entidad.clsEntProducto"%>
<%@page import="Negocio.clsNegProducto"%>
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
    
    if (cliente.getIdcargo() != 1 && cliente.getIdcargo() != 2) {
        response.sendRedirect("../PresentacionCliente/dashboard.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    clsEntProducto producto = null;
    boolean encontrado = false;
    
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int idProducto = Integer.parseInt(idParam);
            clsNegProducto negProducto = new clsNegProducto();
            producto = negProducto.MtdObtenerProductoPorId(idProducto);
            encontrado = (producto != null);
        } catch (NumberFormatException e) {
            out.println("<div class='error'>Error: ID de producto inválido</div>");
        }
    }
    
  
    clsNegMarca negMarca = new clsNegMarca();
    clsNegColor negColor = new clsNegColor();
    clsNegTalla negTalla = new clsNegTalla();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>
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
        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px;
            box-sizing: border-box;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus,
        select:focus {
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
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #f5c6cb;
        }
        .readonly-field {
            background-color: #f8f9fa;
            color: #6c757d;
            cursor: not-allowed;
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
        <h1> Editar Producto</h1>
        
        <% if (!encontrado && idParam != null) { %>
            <div class="error">
                Error: No se encontró el producto con ID <%= idParam %>
            </div>
            <div style="text-align: center; margin-top: 20px;">
                <a href="listarProductos.jsp" class="btn btn-secondary">← Volver al Listado</a>
            </div>
        <% } else if (encontrado) { %>
        
        <form action="procesarActualizarProducto.jsp" method="POST">
            <input type="hidden" name="txtID" value="<%= producto.getIdproducto() %>">
            
            <div class="form-group">
                <label for="txtNombre">Nombre del Producto:</label>
                <input type="text" id="txtNombre" name="txtNombre" value="<%= producto.getNombre() %>" required>
            </div>
            
            <div class="form-group">
                <label for="txtDescripcion">Descripción:</label>
                <textarea id="txtDescripcion" name="txtDescripcion" rows="3"><%= producto.getDescripcion() != null ? producto.getDescripcion() : "" %></textarea>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtPrecio">Precio (S/.):</label>
                    <input type="number" id="txtPrecio" name="txtPrecio" step="0.01" min="0" 
                           value="<%= producto.getPrecio() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="txtStock">Stock:</label>
                    <input type="number" id="txtStock" name="txtStock" min="0" 
                           value="<%= producto.getStock() %>" required>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="txtMarca">Marca (solo lectura):</label>
                    <input type="text" id="txtMarca" value="<%= producto.getNombreMarca() %>" 
                           class="readonly-field" readonly>
                    <input type="hidden" name="cboModelo" value="<%= producto.getIdmodelo() %>">
                </div>
                
                <div class="form-group">
                    <label for="txtModelo">Modelo (solo lectura):</label>
                    <input type="text" id="txtModelo" value="<%= producto.getNombreModelo() %>" 
                           class="readonly-field" readonly>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="cboColor">Color:</label>
                    <select id="cboColor" name="cboColor" required>
                        <option value="">Seleccionar Color</option>
                        <% for (Entidad.clsEntColor color : negColor.MtdListarColoresCombo()) { 
                            String selected = (color.getIdcolor() == producto.getIdcolor()) ? "selected" : "";
                        %>
                        <option value="<%= color.getIdcolor() %>" <%= selected %> 
                                style="background-color: <%= color.getCodigo_hex() %>; color: white;">
                            <%= color.getNombre() %>
                        </option>
                        <% } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="cboTalla">Talla:</label>
                    <select id="cboTalla" name="cboTalla" required>
                        <option value="">Seleccionar Talla</option>
                        <% for (Entidad.clsEntTalla talla : negTalla.MtdListarTallasCombo()) { 
                            String selected = (talla.getIdtalla() == producto.getIdtalla()) ? "selected" : "";
                        %>
                        <option value="<%= talla.getIdtalla() %>" <%= selected %>>
                            <%= talla.getValor() %> (<%= talla.getNombreTipoTalla() %>)
                        </option>
                        <% } %>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="txtImagen">URL de Imagen:</label>
                <input type="text" id="txtImagen" name="txtImagen" 
                       value="<%= producto.getImagen() != null ? producto.getImagen() : "" %>" 
                       placeholder="https://ejemplo.com/imagen.jpg">
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Actualizar Producto</button>
                <a href="listarProductos.jsp" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
        
        <div class="back-link">
            <a href="listarProductos.jsp">← Volver al listado de productos</a>
        </div>
        <% } %>
    </div>
</body>
</html>