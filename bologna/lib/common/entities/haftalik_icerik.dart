import 'package:cloud_firestore/cloud_firestore.dart';

class HaftalikIcerik {

  final int hafta_no;
  final String icerik_aciklamasi;

  HaftalikIcerik({required this.hafta_no, required this.icerik_aciklamasi});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      'hafta_no': hafta_no,
      'icerik_aciklamasi': icerik_aciklamasi,

    };
  }

  factory HaftalikIcerik.fromMap(Map<String, dynamic> map) {
    return HaftalikIcerik(
      //docId: map['docId'] != null ? map['docId'] as String : null,
      hafta_no: map['hafta_no'] as int,
      icerik_aciklamasi: map['icerik_aciklamasi'] as String,
    );
  }

  factory HaftalikIcerik.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return HaftalikIcerik(
      //docId: doc.id,
      hafta_no: doc['hafta_no'],
      icerik_aciklamasi: doc['icerik_aciklamasi'],

    );
  }
}