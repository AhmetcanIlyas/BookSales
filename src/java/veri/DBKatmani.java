package veri;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.lang.StringBuilder;
import java.time.LocalDate;
import java.util.Date;
import java.time.ZoneId;
import java.sql.Timestamp;
import java.time.LocalDateTime;


/**
 * 
 * @author ahmet
 */
public class DBKatmani {
    
    private Connection conn;
    String dburl = "jdbc:mysql://localhost:3306/kitap?useTimezone=true&serverTimezone=UTC";
    String user = "root";
    String pass = "Veritabani123";
    
    public Connection baglan(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println(dburl + user + pass);
            conn = DriverManager.getConnection(dburl, user, pass);
            System.out.println("baglanti basarili");
        } catch(Exception e) {
            System.out.println("baglantida sorun var");
        }
        return conn;
    }
    
    public String[][] getKitapListesi(String gelenBilgi) {
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        try {
            Statement stmt = conn.createStatement();
            System.out.println(gelenBilgi);
            ResultSet rs = stmt.executeQuery("SELECT * FROM kitap WHERE kategori ='"+gelenBilgi+"'");
            // Veritabanındaki kayıt sayısını bulmak için önce sonuca bir kez taşınmalıyız.
            rs.last();
            int rowCount = rs.getRow();
            
            // Matrisi oluşturuyoruz
            String[][] kitaplar = new String[rowCount][4]; // 2 sütun var: kitap adı ve yazar adı/soyadı

            // ResultSet başa alınır
            rs.beforeFirst();
            
            int rowIndex = 0;
            while (rs.next()) {
                kitaplar[rowIndex][0] = rs.getString(8); // resim
                kitaplar[rowIndex][1] = rs.getString(3); // Kitap adı
                kitaplar[rowIndex][2] = rs.getString(4); // Yazar adı ve soyadı
                kitaplar[rowIndex][3] = rs.getString(7); // fiyat

                rowIndex++;
            }
            return kitaplar;
            
        } catch(Exception e) {
            System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public List<String> getKategoriListesi() {
        List<String> kategoriler = new ArrayList<>();
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM kategori");
            while (rs.next()) {
                kategoriler.add(rs.getString(2));
                
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println(kategoriler);

        return kategoriler;
    }
    public String[] getKitapDetay(String detayBilgi) {
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        try {
            Statement stmt = conn.createStatement();
            System.out.println(detayBilgi);
            ResultSet rs = stmt.executeQuery("SELECT * FROM kitap WHERE kitapAdi ='"+detayBilgi+"'");
            // Veritabanındaki kayıt sayısını bulmak için önce sonuca bir kez taşınmalıyız.
            rs.last();
            
            // Matrisi oluşturuyoruz
            String[] detaylar = new String[7]; // 2 sütun var: kitap adı ve yazar adı/soyadı

            // ResultSet başa alınır
            rs.beforeFirst();
            
            int rowIndex = 0;
            while (rs.next()) {
                detaylar[0] = rs.getString(8); // resim
                detaylar[1] = rs.getString(3); // Kitap adı
                detaylar[2] = rs.getString(4); // Yazar adı 
                detaylar[3] = rs.getString(5); // yayınevi adı
                detaylar[4] = rs.getString(6); // sayfa sayısı
                detaylar[5] = rs.getString(7); // fiyat
                detaylar[6] = rs.getString(9); // acıklama
                rowIndex++;
            }
            System.out.println(detaylar);
            return detaylar;
            
        } catch(Exception e) {
            System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public String getGiris(String email) {
        String girisBilgi="";
       
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT sifre FROM musteri WHERE email ='"+email+"'");
            if (rs.next()) {
                girisBilgi=rs.getString("sifre");
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println(girisBilgi);

        return girisBilgi;
    }
    
    public String getIsim(String email) {
        String isim="";
       
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT musteriAdi FROM musteri WHERE email ='"+email+"'");
            if (rs.next()) {
                isim=rs.getString("musteriAdi");
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println(isim);

        return isim;
    }
    
    public String[][] getSepet(HttpServletRequest request) {
        // Eğer 'conn' bağlantısı henüz kurulmadıysa, veritabanına bağlanın
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        // İstekten ürün adı (adi) ve adet miktarı (adet) değerlerini alın
        String adi = request.getParameter("adi");
        String adet = request.getParameter("adet");
        if(adet==null){
            adet="1";
        }
        System.out.println(adi + adet);

        // Oturumu alın
        HttpSession session = request.getSession();

        // Önceki matrisi oturumdan almak için:
        String[][] eskiMatris = (String[][]) session.getAttribute("sepet");

        // Yeni matrisi oluşturun veya mevcut matrisi kullanın
        String[][] yeniMatris;

        if (eskiMatris != null) {
            yeniMatris = eskiMatris;
        } else {
            yeniMatris = new String[0][];
        }

        String[] yeniVeri = new String[4];

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM kitap WHERE kitapAdi ='" + adi + "'");
        
            // Veritabanındaki kayıt sayısını bulmak için önce sonuca bir kez taşınmalıyız.
            rs.last();
            // ResultSet başa alınır
            rs.beforeFirst();
        
            int rowIndex = 0;
        
            while (rs.next()) {
                yeniVeri[0] = rs.getString(8); // resim
                yeniVeri[1] = rs.getString(3); // Kitap adı
                yeniVeri[2] = rs.getString(7); // fiyat
                yeniVeri[3] = adet; // adet
                rowIndex++;
            }

        } catch (Exception e) {
            System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }

        // Ürünün (adi) sepette zaten var olup olmadığını kontrol edin
        boolean urunVar = false;
        int varolanUrunIndex = -1;

        for (int i = 0; i < yeniMatris.length; i++) {
            if (yeniMatris[i][1].equals(adi)) { // Ürün adının ikinci sütunda (index 1) olduğunu varsayıyoruz
                urunVar = true;
                varolanUrunIndex = i;
                break;
            }
        }

        if (urunVar) {
            // Eğer ürün zaten varsa, adet miktarını güncelleyin
            int varolanAdet = Integer.parseInt(yeniMatris[varolanUrunIndex][3]);
            int yeniAdet = Integer.parseInt(adet);
            yeniMatris[varolanUrunIndex][3] = String.valueOf(varolanAdet + yeniAdet);
        } else {
            // Eğer ürün sepette yoksa, yeni bir giriş olarak ekleyin
            if (adi != null) {
                String[][] guncellenmisMatris = new String[yeniMatris.length + 1][];
                System.arraycopy(yeniMatris, 0, guncellenmisMatris, 0, yeniMatris.length);
                guncellenmisMatris[yeniMatris.length] = yeniVeri;

                int satirlar = guncellenmisMatris.length;
                int sutunlar = guncellenmisMatris[0].length;

                // Güncellenmiş matrisi oturum değişkenine ekleyin
                session.setAttribute("sepet", guncellenmisMatris);
            }
        }

        return null; 
    }
    
    public String[] getMusteriDetay(String email) {
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM musteri WHERE email ='"+email+"'");
            // Veritabanındaki kayıt sayısını bulmak için önce sonuca bir kez taşınmalıyız.
            rs.last();
            
            // Matrisi oluşturuyoruz
            String[] mDetay = new String[4]; // 2 sütun var: kitap adı ve yazar adı/soyadı

            // ResultSet başa alınır
            rs.beforeFirst();
            
            int rowIndex = 0;
            while (rs.next()) {
                mDetay[0] = rs.getString(2); // adi
                mDetay[1] = rs.getString(3); // soyadi
                mDetay[2] = rs.getString(5); // eposta
                mDetay[3] = rs.getString(6); // adres
                rowIndex++;
            }
            System.out.println(mDetay);
            return mDetay;
            
        } catch(Exception e) {
            System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public String getGuncelle(String email, String adres, String sifre) {
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        String isTrue="1";

        if(adres!=null && !adres.isEmpty()){
            try {
            String sql = "UPDATE musteri SET ";
            int parametreSayisi = 0;

            if (adres != null && !adres.isEmpty()) {
                sql += "adres = ?";
                parametreSayisi++;
            }

            if (sifre != null && !sifre.isEmpty()) {
                if (parametreSayisi > 0) {
                    sql += ", ";
                }
                sql += "sifre = ?";
                parametreSayisi++;
            }
            
            sql += " WHERE email = ?";

            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                int paramIndex = 1;

                if (adres != null && !adres.isEmpty()) {
                    pstmt.setString(paramIndex++, adres);
                }

                if (sifre != null && !sifre.isEmpty()) {
                    pstmt.setString(paramIndex++, sifre);
                }

                pstmt.setString(paramIndex, email);
                
                int etkilenenSatirSayisi = pstmt.executeUpdate();

                if (etkilenenSatirSayisi > 0) {
                    System.out.println("Veriler güncellendi.");
                    return isTrue;
                } else {
                    System.out.println("Güncellenecek kişi bulunamadı.");
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        }
      return null;
    }

    public String getUyeKayit(String email, String adi, String soyadi, String tel, String adres, String sifre, String soru, String cevap) {
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        String isTrue ="1";
        String isFalse ="0";
        try {
            String kontrolSorgusu = "SELECT COUNT(*) FROM musteri WHERE email = ?";
            
            PreparedStatement kontrolStatement = conn.prepareStatement(kontrolSorgusu);
            kontrolStatement.setString(1, email);

            ResultSet resultSet = kontrolStatement.executeQuery();
            resultSet.next();
            int kayitSayisi = resultSet.getInt(1);

            if (kayitSayisi == 0) {
                // Yeni kayıt için SQL sorgusu oluşturun
                String sql = "INSERT INTO musteri (musteriAdi, musteriSoyadi, telefon, email, adres, sifre, guvenlikSoru, guvenlikCevap) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                // PreparedStatement oluşturun
                PreparedStatement preparedStatement = conn.prepareStatement(sql);

                // Parametreleri belirleyin (örneğin)
                preparedStatement.setString(1, adi);
                preparedStatement.setString(2, soyadi);
                preparedStatement.setString(3, tel);
                preparedStatement.setString(4, email);
                preparedStatement.setString(5, adres);
                preparedStatement.setString(6, sifre);
                preparedStatement.setString(7, soru);
                preparedStatement.setString(8, cevap); 

                // Sorguyu çalıştırın
                preparedStatement.executeUpdate();

                System.out.println("Yeni kayıt başarıyla eklendi!");
                return isTrue;
                } else {
                    System.out.println("E-posta adresi zaten mevcut, işlem yapılmadı.");
                    return isFalse;
                }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<String> getGuvenlikSoru() {
        List<String> sorular = new ArrayList<>();
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM guvenliksoru");
            while (rs.next()) {
                sorular.add(rs.getString(2));
                
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }

        return sorular;
    }
    
    public String getKontrol(String email) {
       
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        String isFalse="0";
        String isTrue="1";
        try {
            String kontrolSorgusu = "SELECT COUNT(*) FROM musteri WHERE email = ?";
            
            PreparedStatement kontrolStatement = conn.prepareStatement(kontrolSorgusu);
            kontrolStatement.setString(1, email);

            ResultSet resultSet = kontrolStatement.executeQuery();
            resultSet.next();
            int kayitSayisi = resultSet.getInt(1);

            if(email!=null){
                if (kayitSayisi == 0) {
                System.out.println("E-posta adresi yok");
                return isFalse;
                } else {
                    System.out.println("E-posta adresi mevcut");
                    return isTrue;
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public String getGuvenlikSoru(String email) {
        String soru ="";
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT guvenlikSoru FROM musteri WHERE email ='"+email+"'");
            if (rs.next()) {
                soru=rs.getString("guvenlikSoru");
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println(soru);

        return soru;
    }
    
    public String getGuvenlikCevap(String email) {
        String cevap ="";
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT guvenlikCevap FROM musteri WHERE email ='"+email+"'");
            if (rs.next()) {
                cevap=rs.getString("guvenlikCevap");
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println(cevap);

        return cevap;
    }
    
    public String getSifreGuncelle(String email, String sifre) {
        
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        
        try{
            // SQL güncelleme sorgusu
            String updateQuery = "UPDATE musteri SET sifre = ? WHERE email = ?";

            // PreparedStatement oluşturma
            PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
            preparedStatement.setString(1, sifre);
            preparedStatement.setString(2, email);

            // Sorguyu çalıştırma
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Veri güncelleme başarılı.");
            } else {
                System.out.println("Güncellenecek veri bulunamadı.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public String[][] getAra(String aramaIfade) {
    if (conn == null) {
        System.out.println("Veritabanı bağlı değil, bağlanıyorum");
        baglan();
    }

    System.out.println(aramaIfade);
    List<String[]> sonucListesi = new ArrayList<>();

    try {
        Statement stmt = conn.createStatement();

        // İlk sütun için arama yap ve sonuçları ekleyin
        ResultSet rs = stmt.executeQuery("SELECT * FROM kitap WHERE kitapAdi ='" + aramaIfade + "'");
        if (rs.next()) {
            do {
                String[] sonuc = new String[4];
                sonuc[0] = rs.getString(8); // resim
                sonuc[1] = rs.getString(3); // Kitap adı
                sonuc[2] = rs.getString(4); // Yazar adı ve soyadı
                sonuc[3] = rs.getString(7); // fiyat
                sonucListesi.add(sonuc);
            } while (rs.next());
        }

        // İkinci sütun için arama yap ve sonuçları ekleyin
        rs = stmt.executeQuery("SELECT * FROM kitap WHERE yazarAdi ='" + aramaIfade + "'");
        if (rs.next()) {
            do {
                String[] sonuc = new String[4];
                sonuc[0] = rs.getString(8); // resim
                sonuc[1] = rs.getString(3); // Kitap adı
                sonuc[2] = rs.getString(4); // Yazar adı ve soyadı
                sonuc[3] = rs.getString(7); // fiyat
                sonucListesi.add(sonuc);
            } while (rs.next());
        }
        
        rs = stmt.executeQuery("SELECT * FROM kitap WHERE yayinevi ='" + aramaIfade + "'");
        if (rs.next()) {
            do {
                String[] sonuc = new String[4];
                sonuc[0] = rs.getString(8); // resim
                sonuc[1] = rs.getString(3); // Kitap adı
                sonuc[2] = rs.getString(4); // Yazar adı ve soyadı
                sonuc[3] = rs.getString(7); // fiyat
                sonucListesi.add(sonuc);
            } while (rs.next());
        }
        
        rs = stmt.executeQuery("SELECT * FROM kitap WHERE kategori ='" + aramaIfade + "'");
        if (rs.next()) {
            do {
                String[] sonuc = new String[4];
                sonuc[0] = rs.getString(8); // resim
                sonuc[1] = rs.getString(3); // Kitap adı
                sonuc[2] = rs.getString(4); // Yazar adı ve soyadı
                sonuc[3] = rs.getString(7); // fiyat
                sonucListesi.add(sonuc);
            } while (rs.next());
        }

        // Diğer sütunlar için de arama yapılabilir...

    } catch (Exception e) {
        System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
        e.printStackTrace();
    }

    String[][] birlesikSonuc = new String[sonucListesi.size()][4];
    for (int i = 0; i < sonucListesi.size(); i++) {
        birlesikSonuc[i] = sonucListesi.get(i);
    }
    if (birlesikSonuc != null) {
        for (int i = 0; i < birlesikSonuc.length; i++) {
            for (int j = 0; j < birlesikSonuc[i].length; j++) {
                System.out.print(birlesikSonuc[i][j] + " ");
            }
            System.out.println();
        }
    } else {
        System.out.println("Sonuç bulunamadı.");
    }
    return birlesikSonuc;
}   
    
    public String getSiparis(HttpServletRequest request) {

        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        LocalDateTime localDateTime = LocalDateTime.now();
        Timestamp sqlDateTime = Timestamp.valueOf(localDateTime);
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String tutar = (String) session.getAttribute("tutar");
        int intTutar = Integer.parseInt(tutar);
        String musteriID="";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT musteriID FROM musteri WHERE email ='"+email+"'");
            if (rs.next()) {
                musteriID=rs.getString("musteriID");
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        int intID = Integer.parseInt(musteriID);
        String sepet[][] = (String[][]) session.getAttribute("sepet");
        StringBuilder builder = new StringBuilder();
        int birinciSutun = 1;
        int ikinciSutun = 3;
        
        for (String[] satir : sepet) {
            if (birinciSutun < satir.length && ikinciSutun < satir.length) {
                String birinciDeger = satir[birinciSutun];
                String ikinciDeger = satir[ikinciSutun];

                // İki sütunu birleştirerek yeni bir String oluştur
                String birlesikSatir = birinciDeger + "(Adet: " + ikinciDeger + ")";

                builder.append(birlesikSatir);
                if (satir != sepet[sepet.length - 1]) {
                    builder.append(", ");
                    }

            }
        }
        String birlesik = builder.toString();
        System.out.println(birlesik+email+sqlDateTime+intID+tutar);
        
        try{
            // Yeni kayıt eklemek için SQL sorgusu
            String sql = "INSERT INTO siparis (musteriID, urunler, tutar, tarih) VALUES (?, ?, ?, ?)";

            // SQL sorgusunu çalıştırmak için PreparedStatement oluşturma
            PreparedStatement preparedStatement = conn.prepareStatement(sql);

            // Kayıt değerlerini atama
            preparedStatement.setInt(1, intID);
            preparedStatement.setString(2, birlesik);
            preparedStatement.setInt(3, intTutar);
            preparedStatement.setTimestamp(4, sqlDateTime);

            // SQL sorgusunu çalıştırma
            int affectedRows = preparedStatement.executeUpdate();

            // Etkilenen satır sayısını kontrol edebiliriz
            if (affectedRows > 0) {
                System.out.println("Yeni kayıt başarıyla eklendi.");
            } else {
                System.out.println("Kayıt eklenirken bir hata oluştu.");
            }

            // PreparedStatement ve Connection nesnelerini kapatma
            preparedStatement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return birlesik;
    }
    
    public String[][] getGecmis(HttpServletRequest request) {
        // Eğer 'conn' bağlantısı henüz kurulmadıysa, veritabanına bağlanın
        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        System.out.println(email);
        String musteriID="";
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT musteriID FROM musteri WHERE email ='"+email+"'");
            if (rs.next()) {
                musteriID=rs.getString("musteriID");
                
            }
        } catch(Exception e) {
           System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM siparis WHERE musteriID ='"+musteriID+"' ORDER BY tarih DESC");
            // Veritabanındaki kayıt sayısını bulmak için önce sonuca bir kez taşınmalıyız.
            rs.last();
            int rowCount = rs.getRow();
            
            // Matrisi oluşturuyoruz
            String[][] gecmis = new String[rowCount][3]; 

            // ResultSet başa alınır
            rs.beforeFirst();
            
            int rowIndex = 0;
            while (rs.next()) {
                Timestamp timestamp = rs.getTimestamp(5); // 5. sütun: tarih
                LocalDateTime localDateTime = timestamp.toLocalDateTime();

                // Yıl, ay, gün, saat ve dakika bilgilerini alarak tarih bilgisini oluşturun
                int year = localDateTime.getYear();
                int month = localDateTime.getMonthValue();
                int day = localDateTime.getDayOfMonth();
                int hour = localDateTime.getHour();
                int minute = localDateTime.getMinute();
    
                String formattedDateTime = String.format("%04d-%02d-%02d %02d:%02d", year, month, day, hour, minute);

                gecmis[rowIndex][0] = formattedDateTime; // tarih, saat ve dakika
                gecmis[rowIndex][1] = rs.getString(3); // urunler
                gecmis[rowIndex][2] = rs.getString(4); // tutar
                rowIndex++;
            }
            for (int i = 0; i < gecmis.length; i++) {
            for (int j = 0; j < gecmis[i].length; j++) {
                System.out.print(gecmis[i][j] + "\t");
            }
            System.out.println();
        }
            return gecmis;
            
        } catch(Exception e) {
            System.out.println("Veritabanı bağlantısında sorun var: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    public String[][] getCokSat(String kitapAdi, int yeniAdet) {

        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        
        try {
            // Kitap bilgilerini alacağımız SQL sorgusu
            String selectSorgu = "SELECT * FROM coksatan WHERE kitapAdi = ?";

            // Yeni kitap ekleme veya mevcut kitabın adetini güncelleme SQL sorgusu
            String insertOrUpdateSorgu = "INSERT INTO coksatan (kitapAdi, adet) VALUES (?, ?) ON DUPLICATE KEY UPDATE adet = adet + ?";

            // Sorguları hazırlama
            PreparedStatement selectStatement = conn.prepareStatement(selectSorgu);
            selectStatement.setString(1, kitapAdi);

            PreparedStatement insertOrUpdateStatement = conn.prepareStatement(insertOrUpdateSorgu);
            insertOrUpdateStatement.setString(1, kitapAdi);
            insertOrUpdateStatement.setInt(2, yeniAdet);
            insertOrUpdateStatement.setInt(3, yeniAdet);

            // Kitabın var olup olmadığını kontrol etme
            ResultSet resultSet = selectStatement.executeQuery();

            if (resultSet.next()) {
                 // Kitap zaten varsa, adet bilgisini güncelle
                insertOrUpdateStatement.executeUpdate();
                System.out.println("Kitap bilgisi güncellendi.");
            } else {
                // Kitap yoksa, yeni kayıt ekle
                insertOrUpdateStatement.executeUpdate();
                System.out.println("Yeni kitap kaydedildi.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public String islem(HttpServletRequest request){
        
        HttpSession session = request.getSession();
        String[][] sepet = (String[][]) session.getAttribute("sepet");
        for (int i = 0; i < sepet.length; i++) {
            String kitapAdi = sepet[i][1];
            int yeniAdet = Integer.parseInt(sepet[i][3]);

            // Kitap adı ve adet bilgisini kullanarak veritabanı işlemini gerçekleştirme
            getCokSat(kitapAdi, yeniAdet);
        }
        return null;
    }
    
    public String[][] getCokSatanListe() {

        if (conn == null) {
            System.out.println("Veritabanı bağlı değil, bağlanıyorum");
            baglan();
        }
        
        try{
            // KitapAdi'na göre coksatan tablosunu adet miktarına göre azalan sırayla sorgula
            String selectQuery = "SELECT kitapAdi FROM coksatan ORDER BY adet DESC LIMIT 4";

            PreparedStatement selectStatement = conn.prepareStatement(selectQuery);
            ResultSet resultSet = selectStatement.executeQuery();

            // Sıralı olarak ilk 4 kitap adını depolamak için bir matris oluştur
            String[] kitapAdlari = new String[4];
            int index = 0;

            // İlk 4 kitap adını matrise kaydet
            while (resultSet.next()) {
                kitapAdlari[index] = resultSet.getString("kitapAdi");
                index++;
            }

            // Matristeki her kitap adı için kitap detaylarını al ve matrise kaydet
            String kitapDetayQuery = "SELECT kitapFoto, kitapAdi, yazarAdi, fiyat FROM kitap WHERE kitapAdi = ?";
            PreparedStatement kitapDetayStatement = conn.prepareStatement(kitapDetayQuery);

            // Kitap detaylarını tutmak için bir matris oluştur
            String[][] kitapDetaylari = new String[4][4];

            for (int i = 0; i < 4; i++) {
                kitapDetayStatement.setString(1, kitapAdlari[i]);
                ResultSet kitapDetayResultSet = kitapDetayStatement.executeQuery();

                if (kitapDetayResultSet.next()) {
                    kitapDetaylari[i][0] = kitapDetayResultSet.getString("kitapFoto");
                    kitapDetaylari[i][1] = kitapDetayResultSet.getString("kitapAdi");
                    kitapDetaylari[i][2] = kitapDetayResultSet.getString("yazarAdi");
                    kitapDetaylari[i][3] = kitapDetayResultSet.getString("fiyat");
                }
            }
            return kitapDetaylari;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public int stokKontrol(HttpServletRequest request){
    int sonuc = 0; 
    
    if (conn == null) {
        System.out.println("Veritabanı bağlı değil, bağlanıyorum");
        baglan();
    }

    HttpSession session = request.getSession();
    String[][] eskiMatris = (String[][]) session.getAttribute("sepet");
    String kitapAdi = request.getParameter("adi");
    String adetStr = request.getParameter("adet");
    int adetInt = 0;

    if(adetStr!=null){
        try {
        adetInt = Integer.parseInt(adetStr);
    } catch (NumberFormatException e) {
        e.printStackTrace();
    }
    }else if(adetStr==null){
        adetInt=1;
    }

    if (eskiMatris != null) {
        for (int i = 0; i < eskiMatris.length; i++) {
            String kitap = eskiMatris[i][1]; // Kitap adı 2. sütunda

            if (kitap.equals(kitapAdi)) {
                int eskiAdet = Integer.parseInt(eskiMatris[i][3]); // Adet bilgisi 4. sütunda
                adetInt = eskiAdet + adetInt;
                break;
            }
        }
    }
    
    System.out.println(adetInt);
    
    if(kitapAdi!=null){
        try {
        String query = "SELECT stok FROM kitap WHERE kitapAdi = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, kitapAdi);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            int stok = resultSet.getInt("stok");
            System.out.println("Kitap Adı: " + kitapAdi + ", Stok: " + stok);
            
            if (stok >= adetInt) {
                sonuc = 1;
                System.out.println("Stok var");
                getSepet(request); 
            } else {
                sonuc = 0;
                System.out.println("Stok yok");
            }
        } else {
            System.out.println("Belirtilen kitap bulunamadı.");
        }
        
    } catch (SQLException e) {
        e.printStackTrace();
    }
    }
    
    System.out.println("sonuc:" + sonuc); 
    return sonuc;
}  
    
    
    public String stokGuncelle(HttpServletRequest request) {
    
    if (conn == null) {
        System.out.println("Veritabanı bağlı değil, bağlanıyorum");
        baglan();
    }
    HttpSession session = request.getSession();
    String[][] matris = (String[][]) session.getAttribute("sepet");
    String updateQuery = "UPDATE kitap SET stok = stok - ? WHERE kitapAdi = ?";
    for (String[] row : matris) {
        String kitapAdi = row[1]; // 2nd column
        int adet = Integer.parseInt(row[3]); // 4th column
        
        try (PreparedStatement preparedStatement = conn.prepareStatement(updateQuery)) {
            preparedStatement.setInt(1, adet);
            preparedStatement.setString(2, kitapAdi);
            preparedStatement.executeUpdate();
            System.out.println("Güncelleme başarılı: " + kitapAdi);
        } catch (SQLException e) {
            System.err.println("Hata oluştu: " + e.getMessage());
        }
    }
    return null;
    }
    
    public int stokBilgi(String kitapAdi) throws SQLException{
    
    if (conn == null) {
        System.out.println("Veritabanı bağlı değil, bağlanıyorum");
        baglan();
    }    
        System.out.println(kitapAdi);
        String query = "SELECT stok FROM kitap WHERE kitapAdi = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, kitapAdi);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
        int stok = resultSet.getInt("stok");
        System.out.println("Kitap Adı: " + kitapAdi + ", Stok: " + stok);
        return stok;
        }
    
    return 0;
    }
        
    public static void main(String[] args) {
        DBKatmani dbk = new DBKatmani();
        dbk.getCokSatanListe();

    }
}
