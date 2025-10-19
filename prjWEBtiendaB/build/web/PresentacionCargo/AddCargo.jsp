<%@page import="Entidad.clsEntCargo"%>
<%@page import="Negocio.clsNegCargo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            clsEntCargo ObjEC = new clsEntCargo();
            clsNegCargo ObjNc = new clsNegCargo();
            
            ObjEC.setIdcargo(Integer.valueOf(request.getParameter("txtID")));
            ObjEC.setNombre(request.getParameter("txtNombre"));
            
            if(ObjNc.MtdGuardarCargo(ObjEC)) {
                mensaje = " Cargo guardado exitosamente";
                exito = true;
            } else {
                mensaje = "Error al guardar el cargo (¿ID ya existe?)";
                exito = false;
            }
        } catch (NumberFormatException e) {
            mensaje = "Error: El ID debe ser un número válido";
            exito = false;
        } catch (Exception e) {
            mensaje = " Error: " + e.getMessage();
            exito = false;
        }
    }
    
    String redirectURL = "index.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8") + "&exito=" + exito;
    response.sendRedirect(redirectURL);
%>