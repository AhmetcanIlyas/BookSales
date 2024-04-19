
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="veri.DBKatmani" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KitabiX</title>
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

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 1rem;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .book-card {
            display: grid;
            grid-template-columns: 130px 1fr;
            gap: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .book-card img {
            width: 100%;
            height: 205px;
            object-fit: cover;
            border-radius: 5px 0 0 5px;
        }

        .book-card-content {
            padding: 1rem;
        }

        .book-card h3 {
            margin-bottom: 0.5rem;
        }

        .book-card p {
            color: #666;
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
        #ekleButon {
        cursor: pointer;
        }
        a img,
        a {
        vertical-align: top;
        }
        .satanlar-banner {
        background-color: #f0f0f0; /* Arka plan rengi */
        padding: 10px; /* İçeriği etrafındaki dolgu alanı */
        text-align: center; /* Metni merkezlemek için */
        }

        .satanlar-banner h2 {
        color: #333; /* Metin rengi */
        margin: 0; /* Başlık etrafında boşluk bırakmamak için */
        font-family: "Arial", sans-serif; 
        font-size: 26px;
        font-weight: bold;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<%
   String username = (String) session.getAttribute("username");
   DBKatmani dbkatmani = new DBKatmani();
   String kitaplar[][] = dbkatmani.getCokSatanListe();
   int rowCount = kitaplar.length;
   int colCount = kitaplar[0].length;
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
                <input type="text" id="ara" name="ara" placeholder="Arama yap..." required>
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
    <div class="satanlar-banner">
        <h2>Çok Satanlar</h2>
    </div>
    <div class="container">
        <% for (int i = 0; i < rowCount; i++) { %>
        <div class="book-card">
            <% for (int j = 0; j < colCount; j++) { %>
            <% j=j+1;%>
            <a href="detay.jsp?bilgi=<%=kitaplar[i][j]%>"> 
            <% j=j-1;%>
            <img src="<%=kitaplar[i][j]%>" alt="Kitap 1">
                <% j=j+1;%>
            <div class="book-card-content">
                <a href="detay.jsp?bilgi=<%=kitaplar[i][j]%>">  
                <h3 id="adi<%=i%>"></h3>
                </a>
                <script>
                var maxCharacters = 30; // İstediğiniz karakter sayısını burada belirleyin
                var text = '<%= kitaplar[i][j] %>'; // Kartın tam adını alıyoruz
                var truncatedText = text.length > maxCharacters ? text.slice(0, maxCharacters) + '...' : text; // Üç noktalı hali
                document.getElementById('adi<%=i%>').innerText = truncatedText; // Üç noktalı hali içine yazdırıyoruz
                </script>
                <% j=j+1;%>
                <p><%=kitaplar[i][j]%></p>
                <% j=j+1;%>
                <p><%=kitaplar[i][j]%> TL</p>
                <button id="ekleButon" onclick="sepeteEkle('<%= kitaplar[i][j-2] %>')"> Sepete Ekle</button>
            </div>
            <%}%>
        </div> 
        <%}%>
    </div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
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
    
    function sepeteEkle(tamAd) {
        var adi = tamAd
        var url = window.location.href;
        
        // Create a new XMLHttpRequest object
        var xhr = new XMLHttpRequest();
        
        // Set up the URL to send the data to
        var targetUrl = "sepetEkle.jsp?adi=" + encodeURIComponent(adi) + "&url=" + encodeURIComponent(url);

        // Configure the AJAX request
        xhr.open("GET", targetUrl, true);

        // Set up a callback function to handle the server response
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    // Success: show toastr message
                    toastr.success('Sepete Eklendi!');
                } else {
                    // Error: handle error response if needed
                    console.error("An error occurred while adding to cart.");
                }
            }
        };
        // Send the request
        xhr.send();
    }
</script>
</body>
</html>
