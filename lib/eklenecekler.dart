/* 

Sıra:
Abimin attığı şekilde view ve viewmodel değiştirilecek.++
GoogleSign++
Firebase sign işlemleri++

-language ve stringlerin tutulacağı alan++
-state yapısı provider++
Esnek size değerleri öğrenilip eklenecek

AUTOROUTE+
LANGUAGE+
BASE YAPISI+
PROVİDER+
MVVM MANTIKLI KLASÖR MİMARİSİ+
FİREBASE++
  Firebase kişinin kelimelerinin gelmesi vs.++
CRASHANALYTCS++




Repository katmanı++
debug release seçenek katmanı
kullanıcının giriş çıkış ve o anki user ı tutan katman++
fakeuser
user modeli++
userviewmodeli
locator ile tanımlanmış sayfalar++

önce giriş yapma çıkış vs sayfası++

splash(force update kontrolü+oturup açıksa otomatik yönlendirme)




Kelimelerin firebase den alındığı bir sayfa++
bu sayfa view- viewmodel- repostory katmanı- kelimelerin alındığı katman şeklinde çağrılcak++

şöyle bir sorun var veritabanında userslar ayrılmamış++
bir users ın words listesine kaydediliyor her şey++

her kullanıcıya ait users altında bir unique kod açılıp words ona yazılmalı ÖNCELİK++

*/


      /*
        TextButton(
          onPressed: () => throw Exception(),
          child: const Text("Throw Test Exception"),
        ),
        */



//Kullanıcının bilgilerini alıp home ekranında Drawer arayüzünde göstermek istiyorum 
//abim bunun için viewmodel olan bir usermanager oluşturup oradan çağırmamı istedi yapamadım



/**
 * Splash screen
 * sayfa kuralları (app route guard) 5 kelimeden az ise teste giremesin
 * Bildi bilemedi animasyonu
 * dil, geçerli son dili hive da tutmak
 * new word translate e basılmadan da eklenebilsin
 * profil, hesap bilgileri, hesabı sil eklemek
 * 30 puan'a ulaştıysa listeden kalksın
 * Test sayfalarının sonuna bir alert ve şu kadar kelimeden şu kadarını bildiniz tarzında
 * Login sayfasında email ile giriş ayarlanacak + firebaseden
 */