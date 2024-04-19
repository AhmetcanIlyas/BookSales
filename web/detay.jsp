<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="veri.DBKatmani" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KitabiX - Kitap</title>
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
        margin-top: 40px;
        margin-bottom: 20px;
        margin-left: 200px;
        margin-right: 60px;
        }
                a img,
        a {
        vertical-align: top;
        }
        #ekleButon {
        width: 150px; /* Buton genişliği */
        height: 50px; /* Buton yüksekliği */
        background-color: #4CAF50; /* Arkaplan rengi */
        color: white; /* Yazı rengi */
        padding: 10px 20px; /* Buton iç boşluğu */
        border: none; /* Kenarlık olmadan */
        border-radius: 5px; /* Kenar yumuşatma */
        cursor: pointer; /* Fare imlecini değiştirme */
        font-size: 16px; /* Yazı boyutu */
        transition: background-color 0.2s;
        }
        #ekleButon:hover {
            background-color: #45a049;
        }
        #adet {
        width: 20px;
        height: 20px;
        font-size: 16px;
        }
        .adet-control {
        display: flex;
        align-items: center;
        }

        .adet-btn {
        width: 30px;
        height: 30px;
        background-color: #f2f2f2;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 18px;
        cursor: pointer;
        margin: 5px;
        display: flex;
        justify-content: center;
        align-items: center;
        }
        .link-style {
        text-decoration: none;
        color: #007bff;
        font-weight: bold;
        transition: color 0.3s, text-decoration 0.3s;
        }

        .link-style:hover {
        color: #ff6600;
        text-decoration: underline;
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
        <%-- JSP kodu ile Java sınıfından liste verisini çekiyoruz --%>
        <%String detayBilgi = request.getParameter("bilgi");%>
        <% DBKatmani dbkatmani = new DBKatmani(); %>
        <%String[] detay = dbkatmani.getKitapDetay(detayBilgi);%>
    </ul>
    <% for (int j = 0; j < detay.length; j++) { %>
    <div class="content">
        <div style="display: flex;">
            <img src="<%=detay[j]%>" alt="Sol Resim" style="width: 253px; height: 400px;">
                <% j=j+1;%>
            <div style="margin-left: 300px;">
                <h1 id="adi"><%=detay[j]%></h1>
                <% j=j+1;%>
                <p><b>Yazar Adı :</b> <a href="kontrol.jsp?bilgi=<%=detay[j]%>" class="link-style"><span><%=detay[j]%></span></a></p>
<% j=j+1;%>
<p><b>Yayınevi Adı :</b> <a href="kontrol.jsp?bilgi=<%=detay[j]%>" class="link-style"><span><%=detay[j]%></span></a></p>
<% j=j+1;%>

                <p><b>Sayfa Sayısı :</b> <%=detay[j]%></p>
                <% j=j+1;%>
                <p><b>Fiyat :</b> <%=detay[j]%> TL</p>
                <% j=j+1;%>
                <!-- Diğer bilgileri buraya ekleyin -->
                <div>
  <div class="adet-control">
    <button class="adet-btn" onclick="azaltAdet()">-</button>
    <input type="text" id="adet" name="adet" min="1" max="99" value="1" maxlength="2"readonly>
    <button class="adet-btn" onclick="arttirAdet()">+</button>
  </div>
</div>
                <button id="ekleButon" onclick="sepeteEkle()">Sepete Ekle</button>
            </div>
        </div>
    </div>
    <div style="display: flex;">
        <div style="margin-left: 90px;">
            <div style="margin-right: 90px;">  
        <div>
        <p><%=detay[j]%>
        </p>
        </div>
            </div>
        </div>
    </div>
    <% } %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    <% String kitapAdi = detay[1]; %>
    <% int kontrolAdet = dbkatmani.stokBilgi(kitapAdi); %>
    function sepeteEkle() {
        var adet = document.getElementById("adet").value;
        var adi = document.getElementById("adi").innerText;

        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'detay.jsp', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

        // Hem adet hem de adi değişkenlerini göndermek için aşağıdaki şekilde kullanabilirsiniz
        xhr.send('adet=' + adet + '&adi=' + adi);
        if(<%=kontrolAdet%>===0){
            toastr.error('Stokta Yok!');
        }else{
            <% dbkatmani.stokKontrol(request); %>      
            toastr.success('Sepete Eklendi!');
        }  
    }
</script>
    <script>
  function azaltAdet() {
    var adetInput = document.getElementById("adet");
    var adetMiktar = parseInt(adetInput.value);
    if (adetMiktar > 1) {
      adetMiktar--;
      adetInput.value = adetMiktar;
    }
  }

  function arttirAdet() {
    
    var adetInput = document.getElementById("adet");
    var adetMiktar = parseInt(adetInput.value);
    if (adetMiktar < <%=kontrolAdet%>) {
    adetMiktar++;
    adetInput.value = adetMiktar;
  }else{
      toastr.error('Yeterli Stok Yok!');
  }}
  
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

</body>
</html>
