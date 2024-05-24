import 'package:cloud_firestore/cloud_firestore.dart';

class OgrenimCiktisi {
  final int cikti_no;
  final String cikti_aciklama;

  OgrenimCiktisi({
    required this.cikti_no,
    required this.cikti_aciklama,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cikti_no': cikti_no,
      'cikti_aciklama': cikti_aciklama,
    };
  }

  factory OgrenimCiktisi.fromMap(Map<String, dynamic> map) {
    return OgrenimCiktisi(
      cikti_no: map['cikti_no'] as int,
      cikti_aciklama: map['cikti_aciklama'] as String,
    );
  }

  factory OgrenimCiktisi.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return OgrenimCiktisi(
      cikti_no: doc['cikti_no'],
      cikti_aciklama: doc['cikti_aciklama'],
    );
  }
}
