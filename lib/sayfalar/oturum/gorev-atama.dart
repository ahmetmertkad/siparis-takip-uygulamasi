import 'package:flutter/material.dart';
import 'package:siparis_takip/services/api_service.dart';

class GorevAtamaSayfasi extends StatefulWidget {
  const GorevAtamaSayfasi({super.key});

  @override
  State<GorevAtamaSayfasi> createState() => _GorevAtamaSayfasiState();
}

class _GorevAtamaSayfasiState extends State<GorevAtamaSayfasi> {
  List<Map<String, dynamic>> kullanicilar = [];
  String? secilenKullaniciId;
  bool yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _kullanicilariGetir();
  }

  Future<void> _kullanicilariGetir() async {
    final liste = await ApiService.getKullaniciListesi();
    setState(() {
      kullanicilar = liste;
      yukleniyor = false;
    });
  }

  void _gorevAta() {
    if (secilenKullaniciId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Lütfen bir kullanıcı seçin")));
      return;
    }

    // TODO: API ile görev atama işlemi yapılacak
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Görev başarıyla atandı!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Görev Atama")),
      body:
          yukleniyor
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: secilenKullaniciId,
                    hint: Text("Kullanıcı Seçin"),
                    items:
                        kullanicilar.map((kullanici) {
                          return DropdownMenuItem(
                            value: kullanici['id'].toString(),
                            child: Text(
                              '${kullanici['username']} (${kullanici['role']})',
                            ),
                          );
                        }).toList(),
                    onChanged: (deger) {
                      setState(() {
                        secilenKullaniciId = deger;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _gorevAta,
                    child: Text("Görevi Ata"),
                  ),
                ],
              ),
    );
  }
}
