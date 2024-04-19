<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="veri.DBKatmani" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KitabiX - Üye Paneli</title>
    <style>
        /* Stil dosyalarını burada ekleyebilirsiniz */
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: #fff;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav {
            background-color: #444;
            padding: 0.5rem;
            text-align: center;
        }

        nav a {
            color: #fff;
            text-decoration: none;
            padding: 0.5rem 1rem;
            margin: 0 0.25rem;
        }

        nav a:hover {
            background-color: #555;
        }

        .user-menu {
            display: flex;
            align-items: center;
        }

        .user-menu a {
            color: #fff;
            text-decoration: none;
            padding: 0.5rem 1rem;
            margin: 0 0.25rem;
        }

        .search-bar {
            display: flex;
            align-items: center;
            margin-left: 1rem;
        }

        .search-bar input[type="text"] {
            padding: 0.5rem;
        }
        
        .search-bar button {
            padding: 0.5rem 1rem;
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: #555;
        }

        .cart-icon {
            font-size: 1.2rem;
            margin-left: auto;
        }
        /* Bağlantılar için stil iptali */
        a {
            color: inherit; /* Varsayılan metin rengini kullan */
            text-decoration: none; /* Altı çizgiyi kaldır */
        }
        
        .logo {
            display: flex;
            align-items: center; /* İçerikleri dikeyde hizala */
        }

        .logo img {
            width: 60px; /* İstediğiniz genişlik */
            height: auto; /* Otomatik yükseklik ayarla, oranı koruyacak */
            margin-right: 5px; /* Sağ tarafından boşluk bırak */
        }

        .content {
            margin-top: 30px;
            margin-bottom: 20px;
            margin-left: 60px;
            margin-right: 60px;
        }

        /* Yeni eklenen üye giriş paneli tasarımı */
        .login-panel {
            background-color: #f2f2f2;
            padding: 2rem;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
            max-width: 400px;
            margin: 0 auto;
        }

        .login-panel h2 {
            margin-bottom: 1rem;
        }

        .login-panel input[type="email"],
        .login-panel input[type="password"] {
            width: 95%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .login-panel button {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .login-panel button:hover {
            background-color: #555;
        }

        .login-panel p {
            margin-top: 1rem;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<%
   String username = (String) session.getAttribute("username");
%>
<body>
    <header>
        <div class="logo">
        <a href="anasayfa.jsp">
        <img src="resimler/logo.png" alt="Kitap Resmi"> 
        </a>
        <h1 style="margin: 0;"><a href="anasayfa.jsp">KitabiX</a></h1>
         </div>
        <nav class="user-menu">
            <div class="search-bar">
                <input type="text" id="ara" placeholder="Arama yap...">
                <button type="submit" onclick="ara()" >Ara</button>
            </div>
            <%if(username==null){ %>
            <a href="uyePaneli.jsp"><i class="fas fa-user"></i> Üye Paneli</a>
            <%}else{%>
            <a href="uyeDetay.jsp"><i class="fas fa-user"></i> <%=username%></a>
            <%}%>
            <a href="sepet.jsp" class="cart-icon" id='dene'><i class="fas fa-shopping-cart"></i> Sepet</a>
        </nav>
    </header>

    <nav>
        <a href="anasayfa.jsp">Anasayfa</a>
        <a href="kategoriler.jsp">Kategoriler</a>
        <a href="hakkimizda.jsp">Hakkımızda</a>
        <a href="iletisim.jsp">İletişim</a>
    </nav>

    <div class="content">
        <!-- Üye giriş paneli -->
        <div class="login-panel">
            <h2>Üye Girişi</h2>
            <form method="post" onsumbit="return giris()"> <!-- Gerçek giriş işlemi için '#' yerine uygun URL'yi kullanın -->
                <input type="email" name="email" placeholder="E-posta" required>
                <input type="password" name="password" placeholder="Şifre" required>
                <button type="submit" >Giriş Yap</button>
            </form>
            <p><a href="sifremiUnuttum.jsp">Şifremi Unuttum</a></p> <!-- Gerçek unutulan şifre sayfasının URL'sini kullanın -->
            <p><a href="uyeOl.jsp">Kayıt Ol</a></p> <!-- Kayıt olma sayfasının URL'sini kullanın -->
        </div>
    </div>
<script>
    function giris(){
      <% String email = request.getParameter("email"); 
         String password = request.getParameter("password"); 
         DBKatmani dbkatmani = new DBKatmani(); 
         String girisBilgi = dbkatmani.getGiris(email);
         if (girisBilgi.equals(password)) {
            String isim = dbkatmani.getIsim(email);;
            session.setAttribute("email", email);
            session.setAttribute("username", isim);
            response.sendRedirect("hosgeldin.jsp"); 
            }else if(girisBilgi!=password && password!=null){
            response.sendRedirect("uyari.jsp"); 
            }
            %>
        }
        
        function handleKeyPress(event) {
        if (event.key === "Enter") {
            ara(); // Enter tuşuna basıldığında arama fonksiyonunu çağır
        }
    }
    // Arama kutusu elemanını seçin
    const aramaKutusu = document.getElementById("ara");

    // Arama kutusuna tıklanma olayını işleyen fonksiyon
    function handleAramaKutusuClick() {
        // Arama kutusu elemanına "Enter" tuşu olay dinleyicisini ekle
        aramaKutusu.addEventListener("keypress", handleKeyPress);
    }

    // Arama kutusuna tıklanma olayını dinlemeye başlayın
    aramaKutusu.addEventListener("click", handleAramaKutusuClick);
    
    function ara(){
        var ara = document.getElementById("ara").value;

        if (ara.trim() === "") {
            toastr.options = {"positionClass": "toast-top-center"};
            toastr.info('Boş arama yapılamaz!');
            return; 
        }
        window.location.href = "kontrol.jsp?bilgi="+ara;
    }
        
</script>
    <!-- Buraya altbilgi ve diğer içeriği ekleyin -->
</body>
</html>
