<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="veri.DBKatmani" %>
<!DOCTYPE html>
<%  
    DBKatmani dbkatmani = new DBKatmani();
    String adi = request.getParameter("adi");
    String url = request.getParameter("url");
    session.setAttribute("adi", adi);
    dbkatmani.stokKontrol(request);
    
    // "url" değişkenine göre parametre eklemeyi belirle
    if (url.contains("anasayfa.jsp")) {
        response.sendRedirect(url + "?ok=1");
    } else {
        response.sendRedirect(url + "&ok=1");
    }
%>

