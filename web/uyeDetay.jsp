
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="veri.DBKatmani" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html lang="tr">

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KitabiX - Üye Profili</title>
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
            margin-left: 100px;
            margin-right: 100px;
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
            width: 100%;
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
        .profile-container {
            display: flex;
            justify-content: space-between;
        }

        .profile {
            flex: 1;
            max-width: 400px;
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .profile h2 {
            margin-bottom: 20px;
        }

        .profile label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .profile input[type="text"],
        .profile input[type="password"] {
            width: 95%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .profile button {
            padding: 10px 20px;
            background-color: #4CAF50; /* Yeşil renk */
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .profile button:hover {
            background-color: #45a049; /* Koyu yeşil renk */
        }

        .orders {
            flex: 1;
            max-width: 400px;
            margin-left: 20px;
            padding: 20px;
            background-color: #f2f2f2;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .order-item {
            margin-bottom: 20px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .order-item h3 {
            margin: 0;
        }

        .order-item p {
            margin-top: 5px;
        }
        .logout-btn {
            background-color: #f44336; /* Kırmızı renk */
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .logout-btn:hover {
            background-color: #d32f2f; /* Koyu kırmızı renk */
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<%
   String username = (String) session.getAttribute("username");
   String email = (String) session.getAttribute("email");
   if(email == null || email==""){
        response.sendRedirect("uyePaneli.jsp");
    }
   DBKatmani dbkatmani = new DBKatmani(); 
   String[] mDetay = dbkatmani.getMusteriDetay(email);
   String[][] gecmis = dbkatmani.getGecmis(request);    
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
<% if(gecmis != null && gecmis.length != 0 && Arrays.stream(gecmis).allMatch(row -> row != null && row.length != 0)){
    int colCount = gecmis[0].length; 
    int rowCount = gecmis.length; 
    if(rowCount>2){
        rowCount=2;
    }
%>
    <div class="content">
        <div class="profile-container">
            <!-- Üye Profili -->
            <div class="profile">
                <% for (int j = 0; j < mDetay.length; j++) { %>
                <h2>Üye Profili: <%=mDetay[j]%><% j=j+1;%> <%=mDetay[j]%></h2>
                <% j=j+1;%>
                <form method="post" > <!-- Gerçek profil güncelleme işlemi için '#' yerine uygun URL'yi kullanın -->
                    <label for="username">E-mail</label>
                    <input type="text" id="email" name="email" value="<%=mDetay[j]%>" disabled>
                    <% j=j+1;%>
                    <label for="email">Adres</label>
                    <input type="text" id="adres" name="adres" value="<%=mDetay[j]%>" required>
                    <label for="password">Şifre</label>
                    <input type="password" id="password" name="password" placeholder="Yeni Şifre">
                    <%}%>
                    <button type="submit" onclick="guncelle()">Profili Güncelle</button>
                </form>
            </div>

            <!-- Geçmiş Siparişler -->
            <div class="orders">
                <h2>Siparişler</h2>
                    <% for (int i = 0; i < rowCount; i++) { %>
                <div class="order-item">
                    <% for (int j = 0; j < colCount; j++) { %>
                    <p>Tarih: <%=gecmis[i][j]%></p>
                    <% j=j+1;%>
                    <p>Ürünler: <%=gecmis[i][j]%></p>
                    <% j=j+1;%>
                    <p>Toplam Tutar: <%=gecmis[i][j]%> TL</p>
                    <% } %>
                </div>
                <% } %>
            </div>
        </div>
        <button class="logout-btn" >Çıkış Yap</button>
    </div>
<% }else{ %>
    <div class="content">
        <div class="profile-container">
            <!-- Üye Profili -->
            <div class="profile">
                <% for (int j = 0; j < mDetay.length; j++) { %>
                <h2>Üye Profili: <%=mDetay[j]%><% j=j+1;%> <%=mDetay[j]%></h2>
                <% j=j+1;%>
                <form method="post" > <!-- Gerçek profil güncelleme işlemi için '#' yerine uygun URL'yi kullanın -->
                    <label for="username">E-mail</label>
                    <input type="text" id="email" name="email" value="<%=mDetay[j]%>" disabled>
                    <% j=j+1;%>
                    <label for="email">Adres</label>
                    <input type="text" id="adres" name="adres" value="<%=mDetay[j]%>" required>
                    <label for="password">Şifre</label>
                    <input type="password" id="password" name="password" placeholder="Yeni Şifre">
                    <%}%>
                    <button type="submit" onclick="guncelle()">Profili Güncelle</button>
                </form>
            </div>

            <!-- Geçmiş Siparişler -->
            <div class="orders">
                <h2>Siparişiniz Yok</h2>    
            </div>
        </div>
        <button class="logout-btn" >Çıkış Yap</button>
    </div>
<% } %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    $(".logout-btn").click(function() {
      window.location.href = "cikis.jsp";
    });
  });
  
  function guncelle(){ 
        <% 
        String adres = request.getParameter("adres"); 
        String sifre = request.getParameter("password");
        String yanit = dbkatmani.getGuncelle(email,adres,sifre);
        if(yanit=="1" && yanit!=null){
            response.sendRedirect("bilgilendir.jsp");
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
