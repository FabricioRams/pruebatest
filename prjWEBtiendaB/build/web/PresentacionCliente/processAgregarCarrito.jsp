<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entidad.clsEntCarrito, Negocio.clsNegCarrito" %>
<%@page import="Entidad.clsEntCliente"%>
<%
    // Verificar sesión y debug
    clsEntCliente cliente = (clsEntCliente) session.getAttribute("cliente");
    
    System.out.println("=== DEBUG PROCESS AGREGAR CARRITO ===");
    System.out.println("Cliente object: " + cliente);
    
    if (cliente == null) {
        System.out.println("Cliente es NULL - redirigiendo a login");
        response.sendRedirect("login.jsp");
        return;
    }
    
    System.out.println("Cliente ID: " + cliente.getIdcliente());
    System.out.println("Cliente Nombre: " + cliente.getNombres());
    
    // Obtener parámetros
    String idProductoStr = request.getParameter("idProducto");
    String cantidadStr = request.getParameter("cantidad");
    String precioStr = request.getParameter("precio");
    
    System.out.println("Parámetros - idProducto: " + idProductoStr + ", cantidad: " + cantidadStr + ", precio: " + precioStr);
    
    if (idProductoStr == null || cantidadStr == null || precioStr == null) {
        System.out.println("Parámetros incompletos");
        response.sendRedirect("../PresentacionProducto/listarProductos.jsp?mensaje=Error: Parámetros incompletos&exito=false");
        return;
    }
    
    try {
        int idProducto = Integer.parseInt(idProductoStr);
        int cantidad = Integer.parseInt(cantidadStr);
        double precio = Double.parseDouble(precioStr);
        
        System.out.println("Parsed - idProducto: " + idProducto + ", cantidad: " + cantidad + ", precio: " + precio);
        
        // Crear objeto carrito
        clsEntCarrito carrito = new clsEntCarrito();
        carrito.setIdCliente(cliente.getIdcliente()); // ESTA LÍNEA DEBERÍA FUNCIONAR
        carrito.setIdProducto(idProducto);
        carrito.setCantidad(cantidad);
        carrito.setPrecioUnitario(precio);
        
        System.out.println("Carrito creado - ClienteID: " + carrito.getIdCliente());
        
        // Agregar al carrito
        clsNegCarrito negCarrito = new clsNegCarrito();
        String resultado = negCarrito.agregarAlCarrito(carrito);
        
        System.out.println("Resultado: " + resultado);
        
        // Redirigir con mensaje de éxito
        response.sendRedirect("../PresentacionProducto/listarProductos.jsp?mensaje=" + 
                            java.net.URLEncoder.encode(resultado, "UTF-8") + "&exito=true");
        
    } catch (NumberFormatException e) {
        System.out.println("Error NumberFormat: " + e.getMessage());
        response.sendRedirect("../PresentacionProducto/listarProductos.jsp?mensaje=Error: Datos inválidos&exito=false");
    } catch (Exception e) {
        System.out.println("Error General: " + e.getMessage());
        e.printStackTrace();
        response.sendRedirect("../PresentacionProducto/listarProductos.jsp?mensaje=Error: " + 
                            java.net.URLEncoder.encode(e.getMessage(), "UTF-8") + "&exito=false");
    }
%>