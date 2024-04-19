
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="veri.DBKatmani" %>
<!DOCTYPE html>

<%
    String sepet[][] = (String[][]) session.getAttribute("sepet");
    String adet = request.getParameter("adet");
    String satir = request.getParameter("satir");
    int indexAdet = Integer.parseInt(adet);
    int indexSatir = Integer.parseInt(satir);
    int indexSutun = 3;
    String kitapIsmi = sepet[indexSatir][1]; 
    DBKatmani dbkatmani = new DBKatmani();
    int kontrol = dbkatmani.stokBilgi(kitapIsmi);
    if(indexAdet<=kontrol){
        sepet[indexSatir][indexSutun] = adet;
    }
    response.sendRedirect("sepet.jsp"); 
%>
