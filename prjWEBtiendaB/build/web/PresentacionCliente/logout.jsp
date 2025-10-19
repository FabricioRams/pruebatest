<%-- 
    Document   : logout
    Created on : 10 oct 2025, 2:52:29
    Author     : kira1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>