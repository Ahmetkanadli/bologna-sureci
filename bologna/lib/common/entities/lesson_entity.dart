import 'package:bologna/common/entities/haftalik_icerik.dart';
import 'package:bologna/common/entities/kaynaklar.dart';
import 'package:bologna/common/entities/ogrenim_ciktisi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  String? docId;
  final String ders_adi;
  final String ders_kodu;
  final String ogretim_elemani;
  final int akts;
  final int kredi;
  final List<Kaynaklar> kaynaklar;
  final List<OgrenimCiktisi> ogrenimCiktisi;
  final List<HaftalikIcerik> haftalik_icerik;
  final String? on_kosul;
  final String verildigi_bolum;
  final String verildigi_donem;
  final List<int> ilisikili_oldugu_program_ciktilari;

  Lesson({
    this.docId,
    required this.ders_adi,
    required this.ders_kodu,
    required this.ogretim_elemani,
    required this.akts,
    required this.kredi,
    required this.kaynaklar,
    required this.ogrenimCiktisi,
    required this.haftalik_icerik,
    this.on_kosul,
    required this.verildigi_bolum,
    required this.verildigi_donem,
    required this.ilisikili_oldugu_program_ciktilari,
  });

  Map<String, dynamic> toMap() {
    return {
      'ders_adi': ders_adi,
      'ders_kodu': ders_kodu,
      'ogretim_elemani': ogretim_elemani,
      'akts': akts,
      'kredi': kredi,
      'kaynaklar': kaynaklar.map((kaynak) => kaynak.toMap()).toList(),
      'ogrenimCiktisi': ogrenimCiktisi.map((cikti) => cikti.toMap()).toList(),
      'haftalik_icerik': haftalik_icerik.map((icerik) => icerik.toMap()).toList(),
      'on_kosul': on_kosul,
      'verildigi_bolum' :verildigi_bolum,
      'verildigi_donem' : verildigi_donem,
      'ilisikili_oldugu_program_ciktilari' : ilisikili_oldugu_program_ciktilari,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      docId: map['docId'] != null ? map['docId'] as String : null,
      ders_adi: map['ders_adi'] as String,
      ders_kodu: map['ders_kodu'] as String,
      ogretim_elemani: map['ogretim_elemani'] as String,
      akts: map['akts'] as int,
      kredi: map['kredi'] as int,
      kaynaklar: (map['kaynaklar'] as List<dynamic>).map((item) => Kaynaklar.fromMap(item as Map<String, dynamic>)).toList(),
      ogrenimCiktisi: (map['ogrenimCiktisi'] as List<dynamic>).map((item) => OgrenimCiktisi.fromMap(item as Map<String, dynamic>)).toList(),
      haftalik_icerik: (map['haftalik_icerik'] as List<dynamic>).map((item) => HaftalikIcerik.fromMap(item as Map<String, dynamic>)).toList(),
      on_kosul: map['on_kosul'] as String?,
      verildigi_donem: map['verildigi_donem'] as String,
      verildigi_bolum: map['verildigi_bolum'] as String,
      ilisikili_oldugu_program_ciktilari: map['ilisikili_oldugu_program_ciktilari'] != null
          ? (map['ilisikili_oldugu_program_ciktilari'] as List<dynamic>).map((item) => item as int).toList()
          : [],
    );
  }

  factory Lesson.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Lesson(
      docId: doc.id,
      ders_adi: data['ders_adi'],
      ders_kodu: data['ders_kodu'],
      ogretim_elemani: data['ogretim_elemani'],
      akts: data['akts'],
      kredi: data['kredi'],
      kaynaklar: (data['kaynaklar'] as List<dynamic>).map((item) => Kaynaklar.fromMap(item as Map<String, dynamic>)).toList(),
      ogrenimCiktisi: (data['ogrenimCiktisi'] as List<dynamic>).map((item) => OgrenimCiktisi.fromMap(item as Map<String, dynamic>)).toList(),
      haftalik_icerik: (data['haftalik_icerik'] as List<dynamic>).map((item) => HaftalikIcerik.fromMap(item as Map<String, dynamic>)).toList(),
      on_kosul: data['on_kosul'] as String?,
      verildigi_donem: data['verildigi_donem'] as String,
      verildigi_bolum: data['verildigi_bolum'] as String,
      ilisikili_oldugu_program_ciktilari: data['ilisikili_oldugu_program_ciktilari'] != null
          ? (data['ilisikili_oldugu_program_ciktilari'] as List<dynamic>).map((item) => item as int).toList()
          : [],
    );
  }
}
