import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramTanimi {
  String? kurulus;
  String? kazanilan_derece;
  String? derece_duzeyi;
  String? yeterlilik_kosullari;
  String? ust_derece_programlarina_gecis;
  String? sinavlar;
  String? olcme_ve_degerlerndirme;
  String? calisma_sekli;

  ProgramTanimi({
    this.kurulus,
    this.kazanilan_derece,
    this.derece_duzeyi,
    this.calisma_sekli,
    this.olcme_ve_degerlerndirme,
    this.sinavlar,
    this.ust_derece_programlarina_gecis,
    this.yeterlilik_kosullari,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'kurulus': kurulus,
      'kazanilan_derece': kazanilan_derece,
      'derece_duzeyi': derece_duzeyi,
      'yeterlilik_kosullari': yeterlilik_kosullari,
      'ust_derece_programlarina_gecis': ust_derece_programlarina_gecis,
      'sinavlar': sinavlar,
      'olcme_ve_degerlerndirme': olcme_ve_degerlerndirme,
      'calisma_sekli': calisma_sekli,
    };
  }

  factory ProgramTanimi.fromMap(Map<String, dynamic> map) {
    return ProgramTanimi(
      kurulus: map['kurulus'] as String?,
      kazanilan_derece: map['kazanilan_derece'] as String?,
      derece_duzeyi: map['derece_duzeyi'] as String?,
      yeterlilik_kosullari: map['yeterlilik_kosullari'] as String?,
      ust_derece_programlarina_gecis: map['ust_derece_programlarina_gecis'] as String?,
      sinavlar: map['sinavlar'] as String?,
      olcme_ve_degerlerndirme: map['olcme_ve_degerlerndirme'] as String?,
      calisma_sekli: map['calisma_sekli'] as String?,
    );
  }

  factory ProgramTanimi.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ProgramTanimi(
      kurulus: doc.data()?['kurulus'],
      kazanilan_derece: doc.data()?['kazanilan_derece'],
      derece_duzeyi: doc.data()?['derece_duzeyi'],
      yeterlilik_kosullari: doc.data()?['yeterlilik_kosullari'],
      ust_derece_programlarina_gecis: doc.data()?['ust_derece_programlarina_gecis'],
      sinavlar: doc.data()?['sinavlar'],
      olcme_ve_degerlerndirme: doc.data()?['olcme_ve_degerlerndirme'],
      calisma_sekli: doc.data()?['calisma_sekli'],
    );
  }
}

class UserService {
  Stream<List<ProgramTanimi>> getProgramTanimi(String fakulteAdi) {
    return FirebaseFirestore.instance
        .collection('fakulte')
        .doc(fakulteAdi)
        .collection('program tanımı')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ProgramTanimi.fromSnapshot(doc)).toList());
  }
}
