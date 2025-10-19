<%-- 
    Document   : procesarProducto
    Created on : 9 oct. 2025, 6:07:05 p. m.
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntProducto"%>
<%@page import="Negocio.clsNegProducto"%>
<%@page import="java.math.BigDecimal"%>
<%
    Entidad.clsEntCliente cliente = (Entidad.clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("../PresentacionCliente/login.jsp");
        return;
    }

    String mensaje = "";
    boolean exito = false;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            clsEntProducto producto = new clsEntProducto();
            producto.setNombre(request.getParameter("txtNombre"));
            producto.setDescripcion(request.getParameter("txtDescripcion"));
            producto.setPrecio(new BigDecimal(request.getParameter("txtPrecio")));
            producto.setStock(Integer.parseInt(request.getParameter("txtStock")));
            producto.setIdmodelo(Integer.parseInt(request.getParameter("cboModelo")));
            producto.setIdcolor(Integer.parseInt(request.getParameter("cboColor")));
            producto.setIdtalla(Integer.parseInt(request.getParameter("cboTalla")));
            producto.setImagen(request.getParameter("txtImagen"));
            
            clsNegProducto negProducto = new clsNegProducto();
            exito = negProducto.MtdGuardarProducto(producto);
            
            if (exito) {
                mensaje = "Producto guardado exitosamente";
            } else {
                mensaje = "Error al guardar el producto";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    }
    
    String redirectURL = "listarProductos.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>