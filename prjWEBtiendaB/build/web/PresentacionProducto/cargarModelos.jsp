<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Negocio.clsNegModelo"%>
<%@page import="java.util.List"%>
<%
    String idMarca = request.getParameter("idMarca");
    if (idMarca != null && !idMarca.isEmpty()) {
        clsNegModelo negModelo = new clsNegModelo();
        List<Entidad.clsEntModelo> modelos = negModelo.MtdListarModelosPorMarca(Integer.parseInt(idMarca));
%>
<option value="">Seleccionar Modelo</option>
<% for (Entidad.clsEntModelo modelo : modelos) { %>
<option value="<%= modelo.getIdmodelo() %>"><%= modelo.getNombre() %></option>
<% } %>
<% } %>