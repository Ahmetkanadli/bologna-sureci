import 'package:cloud_firestore/cloud_firestore.dart';

class OgrenimCiktisi {
  final int cikti_no;
  final String cikti_aciklama;
  List<int>? ilisikili_oldugu_program_ciktilari;

  OgrenimCiktisi({
    required this.cikti_no,
    required this.cikti_aciklama,
    this.ilisikili_oldugu_program_ciktilari
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cikti_no': cikti_no,
      'cikti_aciklama': cikti_aciklama,
      'ilisikili_oldugu_program_ciktilari' : ilisikili_oldugu_program_ciktilari,
    };
  }

  factory OgrenimCiktisi.fromMap(Map<String, dynamic> map) {
    return OgrenimCiktisi(
      cikti_no: map['cikti_no'] as int,
      cikti_aciklama: map['cikti_aciklama'] as String,
      ilisikili_oldugu_program_ciktilari: map['ilisikili_oldugu_program_ciktilari'] != null
          ? (map['ilisikili_oldugu_program_ciktilari'] as List<dynamic>).map((item) => item as int).toList()
          : [],
    );
  }

  factory OgrenimCiktisi.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return OgrenimCiktisi(
      cikti_no: doc['cikti_no'],
      cikti_aciklama: doc['cikti_aciklama'],
      ilisikili_oldugu_program_ciktilari: doc['ilisikili_oldugu_program_ciktilari'] != null
          ? (doc['ilisikili_oldugu_program_ciktilari'] as List<dynamic>).map((item) => item as int).toList()
          : [],
    );
  }
}
