<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCliente"%>
<%@page import="Entidad.clsEntCargo"%>
<%@page import="Negocio.clsNegCargo"%>
<%
    Entidad.clsEntCliente cliente = (Entidad.clsEntCliente) session.getAttribute("cliente");
    if (cliente == null) {
        response.sendRedirect("../PresentacionCliente/login.jsp");
        return;
    }
    
    if (cliente.getIdcargo() != 1) {
        response.sendRedirect("../PresentacionCliente/dashboard.jsp");
        return;
    }

    String mensaje = "";
    boolean exito = false;
    
    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int idCargo = Integer.parseInt(idParam);
            
            clsEntCargo ObjEC = new clsEntCargo();
            ObjEC.setIdcargo(idCargo);
            
            clsNegCargo ObjNc = new clsNegCargo();
            exito = ObjNc.MtdEliminarCargo(ObjEC);
            
            if (exito) {
                mensaje = "Cargo eliminado exitosamente";
            } else {
                mensaje = " Error al eliminar el cargo (puede estar en uso)";
            }
        } catch (NumberFormatException e) {
            mensaje = " Error: ID de cargo inválido";
        } catch (Exception e) {
            mensaje = " Error: " + e.getMessage();
        }
    } else {
        mensaje = " Error: No se proporcionó ID de cargo";
    }
    
    // Redireccionar con mensaje
    String redirectURL = "index.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>