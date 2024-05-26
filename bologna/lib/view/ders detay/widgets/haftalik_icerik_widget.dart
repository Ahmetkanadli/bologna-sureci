import 'package:bologna/common/entities/haftalik_icerik.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget HaftalikIcerikler(List<HaftalikIcerik> haftalik_icerik){
  return ListView.builder(
    padding: const EdgeInsets.all(8.0),
    itemCount: haftalik_icerik.length,
    itemBuilder: (context, index) {
      final icerik = haftalik_icerik[index];
      return Column(
        children: [
          ListTile(
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
          ),
          const Divider(),
        ],
      );
    },
  );
}