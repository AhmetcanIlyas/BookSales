
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
    <title>KitabiX - Kayıt Ol</title>
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
        .login-panel input[type="tel"],
        .login-panel select[type="interests"],
        .login-panel input[type="email"],
        .login-panel input[type="text"],
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
        select {
            width: 100%;
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<%
   DBKatmani dbkatmani = new DBKatmani();   
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
            <a href="uyePaneli.jsp"><i class="fas fa-user"></i> Üye Paneli</a>
            <a href="sepet.jsp" class="cart-icon"><i class="fas fa-shopping-cart"></i> Sepet</a>
        </nav>
    </header>
    <nav>
        <a href="anasayfa.jsp">Anasayfa</a>
        <a href="kategoriler.jsp">Kategoriler</a>
        <a href="hakkimizda.jsp">Hakkımızda</a>
        <a href="iletisim.jsp">İletişim</a>
    </nav>
    <ul>
        <% List<String> sorular = dbkatmani.getGuvenlikSoru(); %>
    </ul>
    <div class="content">
        <!-- Üye olma paneli -->
        <div class="login-panel">
            <h2>Kayıt Ol</h2>
            <form method="post"> <!-- Gerçek üyelik işlemi için '#' yerine uygun URL'yi kullanın -->
                <input type="text" name="name" placeholder="Adı" required>
                <input type="text" name="surname" placeholder="Soyad" required>
                <input type="email" name="email" placeholder="E-posta Adresi" required>
                <input type="password" name="password" placeholder="Şifre" required>
                <input type="password" name="confirm_password" placeholder="Şifre Tekrar" required>
                <input type="tel" id=phone name="telefon" placeholder="Telefon Numarası (Başında 0 olmadan yazın)" required>
                <input type="text" name="adres" placeholder="Adres" required>
                <label for="interests">Güvenlik Sorusu</label>
                    <select id="interests" name="interests">
                    <% for (String veri : sorular) { %>
                    <option><%=(veri)%></option>
                    <%}%>
                </select>
                <input type="text" name="security" placeholder="Güvenlik Cevabı (Unutmayın Şifre Değişikliğinde Gerekli Olacaktır!)" required>
                <button type="submit" onclick="uyeOl()">Kayıt Ol</button>
            </form>
            <p><a href="uyePaneli.jsp">Zaten Üye misiniz? Giriş Yapın</a></p> <!-- Giriş yapma sayfasının URL'sini kullanın -->
            <p><a href="sifremiUnuttum.jsp">Şifremi Unuttum</a></p> <!-- Gerçek unutulan şifre sayfasının URL'sini kullanın -->
        </div>
    </div>
    <script>
        document.getElementById("phone").addEventListener("input", function() {
            var input = this;
            input.value = input.value.replace(/\D/g, "").slice(0, 10); // Sadece sayıları al ve ilk 10 karakteri kullan
        });
        
        function uyeOl(){
            <%
            String sifre = request.getParameter("password");
            String sifre2 = request.getParameter("confirm_password"); %>
            <%
            if (sifre != null && sifre2 != null && sifre.equals(sifre2)) {
                    String email = request.getParameter("email"); 
                    String adi = request.getParameter("name"); 
                    String soyadi = request.getParameter("surname");
                    String tel = request.getParameter("telefon");
                    String adres = request.getParameter("adres"); 
                    String soru = request.getParameter("interests"); 
                    String cevap = request.getParameter("security");
                    String yanit = dbkatmani.getUyeKayit(email, adi, soyadi, tel, adres, sifre, soru, cevap);
                    if(yanit=="0"){
                        response.sendRedirect("uyariMail.jsp");
                        }
                    if(yanit=="1"){
                        String isim = dbkatmani.getIsim(email);
                        session.setAttribute("username", isim);
                        session.setAttribute("email", email);
                        response.sendRedirect("hosgeldin.jsp");
                        }
            }else if(sifre!=sifre2 && sifre!=null){
                    response.sendRedirect("uyari3.jsp");
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
