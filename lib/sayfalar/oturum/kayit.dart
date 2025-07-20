import 'package:flutter/material.dart';
import 'package:siparis_takip/sabitler/ext.dart';
import 'package:siparis_takip/sayfalar/oturum/giris.dart';
import 'package:siparis_takip/services/api_service.dart';

class KayitOl extends StatefulWidget {
  const KayitOl({super.key});

  @override
  State<KayitOl> createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kullaniciAdiController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();
  bool _obscureText = true;

  void _kaydol() async {
    if (_formKey.currentState!.validate()) {
      final username = _kullaniciAdiController.text.trim();
      final password = _sifreController.text;

      final sonuc = await ApiService.registerUser(
        username: username,
        password: password,
      );

      if (sonuc['success']) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("✅ ${sonuc['message']}")));
        _girisSayfasinaGit();
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ ${sonuc['message']}")));
      }
    }
  }

  void _girisSayfasinaGit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const GirisSayfasi()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: renk(arka_renk),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Icon(Icons.person_add_alt_1, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _kullaniciAdiController,
                  decoration: InputDecoration(
                    hintText: "Kullanıcı Adınız",
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Kullanıcı adı giriniz";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _sifreController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Şifre",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "En az 6 karakterli şifre giriniz";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.app_registration),
                    label: Text("Kayıt Ol"),
                    onPressed: _kaydol,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton.icon(
                  onPressed: _girisSayfasinaGit,
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text(
                    "Zaten hesabın var mı? Giriş Yap",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
