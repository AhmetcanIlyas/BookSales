
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KitabiX - Hakkımızda</title>
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
    <div class="content">
    <h1>Hakkımızda</h1>
    <p>Kitap Satış Sitesi, kitapseverlere geniş bir kitap koleksiyonu sunmayı ve kitap dünyasına adım atmaya yardımcı olmayı amaçlayan bir online kitap satış platformudur.</p>

    <h2>Misyonumuz</h2>
    <p>Misyonumuz, müşterilerimize en iyi kitap seçeneklerini sunarak, okuma deneyimlerini zenginleştirmek ve kitap tutkunlarının ihtiyaçlarını karşılamaktır. Kültürel çeşitliliğe ve bilgi birikimine katkıda bulunarak, insanları kitaplarla bir araya getirerek dünya çapında bir okuma topluluğu oluşturmayı hedefliyoruz.</p>

    <h2>Vizyonumuz</h2>
    <p>Vizyonumuz, internet teknolojilerini kullanarak herkesin kolayca kitaplara erişebilmesini sağlamak ve kitap okuma alışkanlığını yaygınlaştırmak. Sadece kitap satın almakla kalmayıp, aynı zamanda kitap kulüpleri, yazar etkinlikleri ve diğer okuma etkinlikleri düzenleyerek kitap sevgisini destekleyen bir platform olmak istiyoruz.</p>

    <h2>Kalite ve Güvenlik</h2>
    <p>Kitap Satış Sitesi olarak, müşterilerimize yüksek kaliteli ve güvenli alışveriş deneyimi sunmayı taahhüt ediyoruz. Kitapları dikkatlice seçiyor, güvenli ödeme yöntemleri kullanıyor ve müşteri bilgilerini gizli tutuyoruz. Müşterilerimizin memnuniyeti ve güvenliği önceliğimizdir.</p>

    <h2>İletişim</h2>
    <p>Kitap Satış Sitesi olarak, müşteri geri bildirimlerine önem veriyor ve onların düşüncelerine saygı duyuyoruz. Sorularınızı, önerilerinizi veya herhangi bir konuda destek talebinizi iletişim formumuzu kullanarak bize iletebilirsiniz. Size en kısa sürede cevap vermek için buradayız!</p>

    <p>Teşekkür ederiz ve keyifli alışverişler dileriz!</p>
    </div>
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
</script>
</body>
</html>
