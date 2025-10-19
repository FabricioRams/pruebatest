<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Negocio.clsNegCliente"%>
<%
    clsEntCliente clienteSesion = (clsEntCliente) session.getAttribute("cliente");
    if (clienteSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String mensaje = "";
    boolean exito = false;
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            String claveActual = request.getParameter("txtClaveActual");
            
            clsNegCliente negCliente = new clsNegCliente();
            clsEntCliente clienteVerificado = negCliente.MtdLogin(clienteSesion.getDni(), claveActual);
            
            if (clienteVerificado != null) {
                clienteSesion.setEmail(request.getParameter("txtEmail"));
                clienteSesion.setNombres(request.getParameter("txtNombres"));
                clienteSesion.setApellidos(request.getParameter("txtApellidos"));
                clienteSesion.setTelefono(request.getParameter("txtTelefono"));
                clienteSesion.setDireccion(request.getParameter("txtDireccion"));
                
                exito = negCliente.MtdActualizarPerfil(clienteSesion);
                
                if (exito) {
                    // Actualizar la sesión
                    session.setAttribute("cliente", clienteSesion);
                    mensaje = "Perfil actualizado exitosamente";
                } else {
                    mensaje = "Error al actualizar el perfil";
                }
            } else {
                mensaje = "Error: Contraseña actual incorrecta";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    }
    
    String redirectURL = "perfil.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>