<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Entidad.clsEntProducto"%>
<%@page import="Negocio.clsNegProducto"%>
<%@page import="java.math.BigDecimal"%>
<%
    // Verificar sesión
    Entidad.clsEntCliente cliente = (Entidad.clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("../PresentacionCliente/login.jsp");
        return;
    }
    
    if (cliente.getIdcargo() != 1 && cliente.getIdcargo() != 2) {
        response.sendRedirect("../PresentacionCliente/dashboard.jsp");
        return;
    }

    String mensaje = "";
    boolean exito = false;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            clsEntProducto producto = new clsEntProducto();
            producto.setIdproducto(Integer.parseInt(request.getParameter("txtID")));
            producto.setNombre(request.getParameter("txtNombre"));
            producto.setDescripcion(request.getParameter("txtDescripcion"));
            producto.setPrecio(new BigDecimal(request.getParameter("txtPrecio")));
            producto.setStock(Integer.parseInt(request.getParameter("txtStock")));
            producto.setIdmodelo(Integer.parseInt(request.getParameter("cboModelo")));
            producto.setIdcolor(Integer.parseInt(request.getParameter("cboColor")));
            producto.setIdtalla(Integer.parseInt(request.getParameter("cboTalla")));
            producto.setImagen(request.getParameter("txtImagen"));
            
            clsNegProducto negProducto = new clsNegProducto();
            exito = negProducto.MtdActualizarProducto(producto);
            
            if (exito) {
                mensaje = "Producto actualizado exitosamente";
            } else {
                mensaje = "Error al actualizar el producto";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    }
    
    // Redireccionar con mensaje
    String redirectURL = "listarProductos.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>