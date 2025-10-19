<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegCliente"%>
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

    String mensaje = "";
    boolean exito = false;
    
    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int idCliente = Integer.parseInt(idParam);
            
            if (idCliente == clienteSesion.getIdcliente()) {
                mensaje = "Error: No puedes eliminar tu propio usuario";
            } else {
                clsEntCliente cliente = new clsEntCliente();
                cliente.setIdcliente(idCliente);
                
                clsNegCliente negCliente = new clsNegCliente();
                exito = negCliente.MtdEliminarCliente(cliente);
                
                if (exito) {
                    mensaje = "Cliente eliminado exitosamente";
                } else {
                    mensaje = "Error al eliminar el cliente";
                }
            }
        } catch (NumberFormatException e) {
            mensaje = "Error: ID de cliente inválido";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    } else {
        mensaje = "Error: No se proporcionó ID de cliente";
    }
    
    String redirectURL = "listarClientes.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>