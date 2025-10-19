<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente, Negocio.clsNegCarrito" %>
<%
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String idCarritoStr = request.getParameter("idCarrito");
    if (idCarritoStr != null) {
        try {
            int idCarrito = Integer.parseInt(idCarritoStr);
            clsNegCarrito negCarrito = new clsNegCarrito();
            String resultado = negCarrito.eliminarDelCarrito(idCarrito);
            response.sendRedirect("carrito.jsp?mensaje=" + 
                                java.net.URLEncoder.encode(resultado, "UTF-8") + "&exito=true");
        } catch (Exception e) {
            response.sendRedirect("carrito.jsp?mensaje=Error: " + 
                                java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "&exito=false");
        }
    } else {
        response.sendRedirect("carrito.jsp?mensaje=Error: ID de carrito no especificado&exito=false");
    }
%>