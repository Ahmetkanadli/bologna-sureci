import 'package:bologna/common/entities/haftalik_icerik.dart';
import 'package:bologna/common/entities/kaynaklar.dart';
import 'package:bologna/common/entities/ogrenim_ciktisi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DersDetay extends StatefulWidget {
  const DersDetay({
    Key? key,
    required this.ders_adi,
    required this.ders_kodu,
    required this.ogretim_elemani,
    required this.akts,
    required this.kredi,
    required this.kaynaklar,
    required this.ogrenimCiktisi,
    required this.haftalik_icerik,
    this.on_kosul,
  }) : super(key: key);

  final String ders_adi;
  final String ders_kodu;
  final String ogretim_elemani;
  final int akts;
  final int kredi;
  final List<Kaynaklar> kaynaklar;
  final List<OgrenimCiktisi> ogrenimCiktisi;
  final List<HaftalikIcerik> haftalik_icerik;
  final String? on_kosul;

  @override
  State<DersDetay> createState() => _DersDetayState();
}

class _DersDetayState extends State<DersDetay> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.ders_adi,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          bottom: const TabBar(
            tabAlignment: TabAlignment.start,
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: "Genel Bilgiler"),
              Tab(text: "Ogrenim Çıktıları"),
              Tab(text: "Haftalık İçerik"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Dersin Kodu",
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.ders_kodu,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Öğretim Elemanı",
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.ogretim_elemani,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "AKTS",
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.akts.toString(),
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Kredi",
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.kredi.toString(),
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  widget.on_kosul != null
                      ? Row(
                    children: [
                      Text(
                        "Ön Koşul",
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.on_kosul!,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(),
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.ogrenimCiktisi.length,
              itemBuilder: (context, index) {
                final cikti = widget.ogrenimCiktisi[index];
                return ListTile(
                  title: Text(
                    "Çıktı No: ${cikti.cikti_no}",
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    cikti.cikti_aciklama,
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.haftalik_icerik.length,
              itemBuilder: (context, index) {
                final icerik = widget.haftalik_icerik[index];
                return ListTile(
                  title: Text(
                    "Hafta ${icerik.hafta_no}",
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    icerik.icerik_aciklamasi,
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
