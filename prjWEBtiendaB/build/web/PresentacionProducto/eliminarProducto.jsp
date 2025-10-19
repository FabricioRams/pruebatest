<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegProducto"%>
<%

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
    
    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int idProducto = Integer.parseInt(idParam);
            
            clsNegProducto negProducto = new clsNegProducto();
            exito = negProducto.MtdEliminarProducto(idProducto);
            
            if (exito) {
                mensaje = "Producto eliminado exitosamente";
            } else {
                mensaje = "Error al eliminar el producto";
            }
        } catch (NumberFormatException e) {
            mensaje = "Error: ID de producto inválido";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    } else {
        mensaje = "Error: No se proporcionó ID de producto";
    }
    
    String redirectURL = "listarProductos.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>