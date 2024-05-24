import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramCiktilari {
  final int id;
  final String cikti_aciklama;

  ProgramCiktilari({
    required this.id,
    required this.cikti_aciklama,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cikti_aciklama': cikti_aciklama,
    };
  }

  factory ProgramCiktilari.fromMap(Map<String, dynamic> map) {
    return ProgramCiktilari(
      id: map['id'] as int,
      cikti_aciklama: map['cikti_aciklama'] as String,
    );
  }

  factory ProgramCiktilari.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ProgramCiktilari(
      id: doc['id'],
      cikti_aciklama: doc['cikti_aciklama'],
    );
  }
}
