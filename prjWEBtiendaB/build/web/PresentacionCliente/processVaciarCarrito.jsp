<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente, Negocio.clsNegCarrito" %>
<%
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    try {
        clsNegCarrito negCarrito = new clsNegCarrito();
        String resultado = negCarrito.vaciarCarrito(cliente.getIdcliente());
        response.sendRedirect("carrito.jsp?mensaje=" + 
                            java.net.URLEncoder.encode(resultado, "UTF-8") + "&exito=true");
    } catch (Exception e) {
        response.sendRedirect("carrito.jsp?mensaje=Error: " + 
                            java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "&exito=false");
    }
%>