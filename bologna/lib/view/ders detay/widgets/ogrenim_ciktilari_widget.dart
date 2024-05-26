import 'package:bologna/common/entities/ogrenim_ciktisi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget OgrenimCiktilari(List<OgrenimCiktisi> ogrenim_ciktilari){
  return ListView.builder(
    padding: const EdgeInsets.all(8.0),
    itemCount: ogrenim_ciktilari.length,
    itemBuilder: (context, index) {
      final cikti = ogrenim_ciktilari[index];
      return Column(
        children: [
          ListTile(
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
          ),
          const Divider(),
        ],
      );
    },
  );
}