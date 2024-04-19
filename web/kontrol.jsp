<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="veri.DBKatmani" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>

<%
  String gelenBilgi = request.getParameter("bilgi");  
  DBKatmani dbkatmani = new DBKatmani(); 
  String[][] kitaplar = dbkatmani.getAra(gelenBilgi);
  gelenBilgi = java.net.URLEncoder.encode(gelenBilgi, "UTF-8");
  if (kitaplar == null || kitaplar.length == 0 || Arrays.stream(kitaplar).allMatch(row -> row == null || row.length == 0)) {
    response.sendRedirect("uyari4.jsp"); 
  } else {  
    response.sendRedirect("ara.jsp?bilgi=" + gelenBilgi); 
  }
%>



