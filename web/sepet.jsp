<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ page import="veri.DBKatmani" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KitabiX - Sepet</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        img {
            width: 50px;
            height: auto;
        }

        .total {
            font-weight: bold;
            text-align: right; /* Toplam tutarı sağa dayalı yapar */
        }

        .actions {
            text-align: right; /* Butonları sağa dayalı yapar */
            margin-top: 10px;
        }

        .actions button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .actions button:hover {
            background-color: #45a049;
        }
        .content {
        margin-top: 30px;
        margin-bottom: 20px;
        margin-left: 60px;
        margin-right: 60px;
        }
        .remove-button {
            padding: 5px 10px;
            background-color: #f44336; /* Kırmızı renk */
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .remove-button:hover {
            background-color: #d32f2f; /* Koyu kırmızı renk */
        }
        .quantity-input {
            width: 40px;
            text-align: center;
        }
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
        tr td a {
            text-decoration: none; /* Alt çizgiyi kaldır */
            transition: text-decoration 0.3s;
        }

        tr td a:hover,
        tr td a:focus {
            text-decoration: underline; /* Alt çizgiyi ekleyerek tıklanabilirliği belirt */
        }
        tr td a {
            color: #007bff; /* Normal renk */
            transition: color 0.3s;
        }

        tr td a:hover,
        tr td a:focus {
            color: #ff6600; /* Yeni renk */
        }
        .message-container {
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        padding: 15px;
        border-radius: 5px;
        text-align: center;
        margin: 20px auto;
        max-width: 400px;
        }

        .message-container p {
        margin: 10px 0;
        font-size: 16px;
        color: #333;
        }


    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.0.20/dist/sweetalert2.min.css">
</head>
<%
   String username = (String) session.getAttribute("username");
   String sepet[][] = (String[][]) session.getAttribute("sepet");
   DBKatmani dbkatmani = new DBKatmani();
   int genelToplam=0;
    StringBuilder sepetJson = new StringBuilder("[");
    if(sepet!=null){
        
        for (int i = 0; i < sepet.length; i++) {
            sepetJson.append("{\"resim\":\"").append(sepet[i][0]).append("\",")
                .append("\"ad\":\"").append(sepet[i][1]).append("\",")
                .append("\"fiyat\":\"").append(sepet[i][2]).append("\",")
                .append("\"adet\":\"").append(sepet[i][3]).append("\"}");
        if (i < sepet.length - 1) {
            sepetJson.append(",");
        }
    }
    sepetJson.append("];");
    }
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
    <%if(sepet != null && sepet.length != 0 && Arrays.stream(sepet).allMatch(row -> row != null && row.length != 0)){
      int rowCount = sepet.length;
      int colCount = sepet[0].length;%>
    <div class="content">
        <!-- Sepet içeriği -->
        <h2>Sepetim</h2>
        <table>
            <tr>
                <th>Ürün Resmi</th>
                <th>Ürün Adı</th>
                <th>Fiyat</th>
                <th>Adet</th>
                <th>Toplam</th>
                <th></th>
            </tr>
            <% for (int i = 0; i < rowCount; i++) { %>
            <tr>
                <% for (int j = 0; j < colCount; j++) { %>
                <td><img src="<%=sepet[i][j]%>" alt="Kitap 1 Resmi"></td>
                <% j=j+1;%>
                <td><a href="detay.jsp?bilgi=<%=sepet[i][j]%>"><%=sepet[i][j]%></a></td>
                <% j=j+1;%>
                <% int price = Integer.parseInt(sepet[i][j]); %>
                <td data-price="<%= price %>" ><%=sepet[i][j]%> TL</td>
                <% j=j+1;%>
                <td>
                    <button onclick="adetDegistir(this, -1)">-</button>
                    <input type="text" class="quantity-input" value="<%=sepet[i][j]%>" maxlength="2" oninput="toplamFiyatGuncelle(this)" readonly>
                    <button onclick="adetDegistir(this, 1)">+</button>
                </td>
                <% int adet = Integer.parseInt(sepet[i][j]); %>
                <% int toplam = price*adet;%>
                <td class="toplam-fiyat" ><%=toplam%> TL</td>
                <% genelToplam = genelToplam + toplam; %>
                <td><button class="remove-button" onclick="kitapSil(this)" >Sil</button></td>
                <%}%>
            </tr>
            <%}%>
            
            <!-- Diğer ürünler buraya eklenebilir -->
        </table>
        <p class="total">Toplam Tutar: <span id="toplamMiktar"><%= genelToplam %></span> TL</p>
        <div class="actions">
            <button onclick="onayla()">Sepeti Onayla</button>
        </div>
        <div class="message-container">
        <p>Sepete ekleyemediğiniz bir ürün varsa bu ürünün stoğu maalesef tükenmiştir.</p>
        </div>
    </div>
        <%}else{%>
        <div class="content">
        <!-- Üye giriş paneli -->
        <div class="login-panel">
            <h1>Sepet Boş</h1>
            
        </div>
        <div class="message-container">
        <p>Sepete eklenmemiş olan bir ürün varsa bu ürünün stoğu maalesef tükenmiştir.</p>
        </div>
    </div>
        <%}%>
    
    <script>
    function adetDegistir(btn, fark) {
        var row = btn.parentNode.parentNode;
        var rowIndex = row.rowIndex - 1;
        var input = btn.parentNode.querySelector(".quantity-input");
        var mevcutDeger = parseInt(input.value);
        var yeniDeger = mevcutDeger + fark;
        if (yeniDeger >= 1 && yeniDeger <= 99) {
            input.value = yeniDeger;
            toplamFiyatGuncelle(input);
            window.location.href = "sepetAdet.jsp?adet="+yeniDeger+"&satir="+rowIndex;
        }
    }

    function toplamFiyatGuncelle(input) {
        var satir = input.parentNode.parentNode;
        var fiyatHucresi = satir.querySelector("[data-price]");
        var fiyat = parseInt(fiyatHucresi.dataset.price);
        var adet = parseInt(input.value);
        var toplamFiyat = fiyat * adet;
        satir.querySelector(".toplam-fiyat").textContent = toplamFiyat + " TL";
        toplamTutariGuncelle();
    }

    function toplamTutariGuncelle() {
        var toplamFiyatHucreleri = document.querySelectorAll(".toplam-fiyat");
        var genelToplam = 0;
        toplamFiyatHucreleri.forEach(function (fiyatHucresi) {
            genelToplam += parseInt(fiyatHucresi.textContent);
        });
        document.getElementById("toplamMiktar").textContent = genelToplam;
    }
    
    var sepet = <%= sepetJson %>;
    function kitapSil(btn) {
        var row = btn.parentNode.parentNode;
        var rowIndex = row.rowIndex - 1; // Tablo başlık satırı olduğu için 1 çıkarıyoruz

        // JavaScript ile satırı sepet matrisinden çıkarın
        sepet.splice(rowIndex, 1);
        
        // Sayfadaki tabloyu güncelleyin (silinen kitap artık görüntülenmeyecek)
        row.remove();
        
        // Toplam tutarı güncelleyin (istediğiniz şekilde)
        toplamTutariGuncelle();
        window.location.href = "sepetSil.jsp?satir="+rowIndex;  
    }
    
    function onayla(){
        var tutar = document.getElementById("toplamMiktar").textContent;
    <%  if(username!=null){ %>
        Swal.fire({
                title: 'Sepeti Onayla',
                text: 'Sipariş vermek istediğinizden emin misiniz?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Evet',
                cancelButtonText: 'Hayır'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Kullanıcı onay verdi, istediğiniz işlemi burada gerçekleştirin.
                    Swal.fire('Sipariş Verildi!', 'Onaylama başarıyla gerçekleştirildi.', 'success');
                    setTimeout(function() {
                        window.location.href = "siparis.jsp?tutar="+tutar;
                        }, 1500); 
                } else {
                    // Kullanıcı onay vermedi, işlemi iptal et.
                    Swal.fire('İptal Edildi', 'Sipariş verilmedi!', 'error');
                }
            });
        <%}else{%>
            toastr.options = {"positionClass": "toast-top-center"};
            toastr.warning('Önce Giriş Yapmalısınız!');
        <%}%>
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

</body>
</html>