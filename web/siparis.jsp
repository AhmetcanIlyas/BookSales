
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="veri.DBKatmani" %>
<!DOCTYPE html>

<%
    DBKatmani dbkatmani = new DBKatmani();
    String tutar = request.getParameter("tutar");
    session.setAttribute("tutar", tutar);
    dbkatmani.islem(request);
    dbkatmani.getSiparis(request);
    dbkatmani.stokGuncelle(request);
    session.removeAttribute("sepet");
    response.sendRedirect("sepet.jsp"); 
%>