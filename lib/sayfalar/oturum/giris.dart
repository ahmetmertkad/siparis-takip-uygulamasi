import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siparis_takip/sabitler/ext.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: renk(arka_renk)),

          child: Column(
            children: [
              Container(
                width: 180,
                height: 180,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.9),
                    width: 1,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white, width: 15),
                  ),
                  child: Icon(Icons.login, size: 45),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Giriş Yapın",
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
