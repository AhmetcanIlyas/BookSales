
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String sepet[][] = (String[][]) session.getAttribute("sepet");
    String satir = request.getParameter("satir");
    int indexSatir = Integer.parseInt(satir);

    // Matrisin boyutunu güncellemek için yeni bir matris oluşturuyoruz
    String yeniSepet[][] = new String[sepet.length - 1][sepet[0].length];
    int yeniSatirIndex = 0;

    // Belirtilen satırı atlamak suretiyle matrisi güncelliyoruz
    for (int i = 0; i < sepet.length; i++) {
        if (i != indexSatir) {
            yeniSepet[yeniSatirIndex++] = sepet[i];
        }
    }

    // Session'da yeni matrisi güncelliyoruz
    session.setAttribute("sepet", yeniSepet);

    // sepet.jsp sayfasına yönlendirme yapıyoruz
    response.sendRedirect("sepet.jsp");
%>
