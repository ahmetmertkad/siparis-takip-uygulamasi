import 'package:flutter/material.dart';
import 'package:siparis_takip/sayfalar/oturum/giris.dart';
import 'package:siparis_takip/sayfalar/oturum/gorev-atama.dart'; // Görev atama sayfası

class AnaSayfa extends StatelessWidget {
  final String kullaniciAdi; // Kullanıcı adı alıyoruz

  const AnaSayfa({super.key, required this.kullaniciAdi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoş Geldin, $kullaniciAdi"),
        actions: [
          // Görev Atama Sayfasına geçiş
          IconButton(
            icon: Icon(Icons.assignment_ind),
            tooltip: "Görev Ata",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GorevAtamaSayfasi(),
                ),
              );
            },
          ),

          // Çıkış
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Çıkış Yap",
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GirisSayfasi()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Ana Sayfa İçeriği", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
