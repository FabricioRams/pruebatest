<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegCliente"%>
<%
    Entidad.clsEntCliente clienteSesion = (Entidad.clsEntCliente) session.getAttribute("cliente");
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
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            clsEntCliente cliente = new clsEntCliente();
            cliente.setIdcliente(Integer.parseInt(request.getParameter("txtID")));
            cliente.setDni(request.getParameter("txtDNI"));
            cliente.setEmail(request.getParameter("txtEmail"));
            cliente.setNombres(request.getParameter("txtNombres"));
            cliente.setApellidos(request.getParameter("txtApellidos"));
            cliente.setTelefono(request.getParameter("txtTelefono"));
            cliente.setDireccion(request.getParameter("txtDireccion"));
            cliente.setIdcargo(Integer.parseInt(request.getParameter("cboCargo")));
            cliente.setIdestado(Integer.parseInt(request.getParameter("cboEstado")));
            
            // Necesitas implementar este método en clsNegCliente
            clsNegCliente negCliente = new clsNegCliente();
            exito = negCliente.MtdActualizarCliente(cliente);
            
            if (exito) {
                mensaje = "Cliente actualizado exitosamente";
            } else {
                mensaje = "Error al actualizar el cliente";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    }
    
    String redirectURL = "listarClientes.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>