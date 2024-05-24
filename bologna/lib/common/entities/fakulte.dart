import 'package:cloud_firestore/cloud_firestore.dart';

class Fakulte{

  final String fakulte_adi;

  Fakulte({required this.fakulte_adi});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      'fakulte_adi': fakulte_adi,
    };
  }


  factory Fakulte.fromMap(Map<String, dynamic> map) {
    return Fakulte(
      //docId: map['docId'] != null ? map['docId'] as String : null,
        fakulte_adi: map['fakulte_adi'] as String,
    );
  }

  factory Fakulte.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Fakulte(
      //docId: doc.id,
        fakulte_adi: doc['fakulte_adi'],
    );
  }
}