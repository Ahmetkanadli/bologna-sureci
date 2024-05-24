import 'package:cloud_firestore/cloud_firestore.dart';

class Kaynaklar{

  final int kaynak_id;
  final String kaynak_adi;

  Kaynaklar({
    required this.kaynak_id,
    required this.kaynak_adi,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      'kaynak_id': kaynak_id,
      'kaynak_adi': kaynak_adi,
    };
  }

  factory Kaynaklar.fromMap(Map<String, dynamic> map) {
    return Kaynaklar(
      //docId: map['docId'] != null ? map['docId'] as String : null,
      kaynak_id: map['kaynak_id'] as int,
      kaynak_adi: map['kaynak_adi'] as String,
    );
  }

  factory Kaynaklar.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Kaynaklar(
      //docId: doc.id,
      kaynak_id: doc['kaynak_id'],
      kaynak_adi: doc['kaynak_adi'],
    );
  }
}