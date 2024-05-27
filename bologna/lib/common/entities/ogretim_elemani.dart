import 'package:bologna/common/entities/haftalik_icerik.dart';
import 'package:bologna/common/entities/ogrenim_ciktisi.dart';
import 'package:bologna/common/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OgretimElemani extends User {
  OgretimElemani(
      {required super.name,
      required super.surname,
      required super.email,
      required super.password,
      required super.role});

  Future<void> ogrenimCiktiGuncelle(
      String? docID, int ciktiID, String yeniCikti) async {
    if (docID == null) {
      print("irdi");
      print("id $docID}");
      throw ArgumentError("Document ID cannot be null");
    }

    try {
      // 1. Mevcut ogrenimCiktisi listesini çek
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('dersler')
          .doc(docID)
          .get();

      if (!snapshot.exists) {
        throw Exception("Document does not exist");
      }

      List<dynamic> ogrenimCiktisiList =
          snapshot.data()?['ogrenimCiktisi'] ?? [];
      List<OgrenimCiktisi> ogrenimCiktisi = ogrenimCiktisiList
          .map((item) => OgrenimCiktisi.fromMap(item as Map<String, dynamic>))
          .toList();

      // 2. Güncellemek istediğin OgrenimCiktisi nesnesini bul ve değiştir
      int index =
          ogrenimCiktisi.indexWhere((cikti) => cikti.cikti_no == ciktiID);

      print("index $index");
      if (index == -1) {
        throw Exception("Ogrenim Ciktisi with ID $ciktiID not found");
      }

      ogrenimCiktisi[index] = OgrenimCiktisi(
          cikti_no: ogrenimCiktisi[index].cikti_no, // Mevcut cikti_no'yu koru
          // Yeni cikti değeri
          cikti_aciklama: yeniCikti // Mevcut aciklama'yı koru
          );

      // 3. Güncellenmiş listeyi Firestore'a geri yükle
      await FirebaseFirestore.instance.collection('dersler').doc(docID).update({
        'ogrenimCiktisi': ogrenimCiktisi.map((cikti) => cikti.toMap()).toList(),
      });
    } catch (e) {
      print("Güncelleme işlemi sırasında hata oluştu: $e");
    }
  }

  Future<void> ogrenimCiktiEkle(String? docID, OgrenimCiktisi yeniCikti) async {
    if (docID == null) {
      throw ArgumentError("Document ID cannot be null");
    }

    try {
      // 1. Mevcut ogrenimCiktisi listesini çek
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('dersler')
          .doc(docID)
          .get();

      if (!snapshot.exists) {
        throw Exception("Document does not exist");
      }

      List<dynamic> ogrenimCiktisiList =
          snapshot.data()?['ogrenimCiktisi'] ?? [];
      List<OgrenimCiktisi> ogrenimCiktisi = ogrenimCiktisiList
          .map((item) => OgrenimCiktisi.fromMap(item as Map<String, dynamic>))
          .toList();

      // 2. Yeni OgrenimCiktisi nesnesini listeye ekle
      ogrenimCiktisi.add(yeniCikti);

      // 3. Güncellenmiş listeyi Firestore'a geri yükle
      await FirebaseFirestore.instance.collection('dersler').doc(docID).update({
        'ogrenimCiktisi': ogrenimCiktisi.map((cikti) => cikti.toMap()).toList(),
      });
    } catch (e) {
      print("Ekleme işlemi sırasında hata oluştu: $e");
    }
  }

  Future<void> haftalikIcerikGuncelle(
      String? docID, int haftaNo, String yeniIcerik) async {
    if (docID == null) {
      print("irdi");
      print("id $docID}");
      throw ArgumentError("Document ID cannot be null");
    }

    try {
      // 1. Mevcut ogrenimCiktisi listesini çek
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('dersler')
          .doc(docID)
          .get();

      if (!snapshot.exists) {
        throw Exception("Document does not exist");
      }

      List<dynamic> haftalikIcerikList =
          snapshot.data()?['haftalik_icerik'] ?? [];
      List<HaftalikIcerik> haftalikIcerik = haftalikIcerikList
          .map((item) => HaftalikIcerik.fromMap(item as Map<String, dynamic>))
          .toList();

      // 2. Güncellemek istediğin OgrenimCiktisi nesnesini bul ve değiştir
      int index =
          haftalikIcerik.indexWhere((icerik) => icerik.hafta_no == haftaNo);

      print("index $index");
      if (index == -1) {
        throw Exception("Ogrenim Ciktisi with ID $haftaNo not found");
      }

      haftalikIcerik[index] = HaftalikIcerik(
          hafta_no: haftalikIcerik[index].hafta_no,
          icerik_aciklamasi: yeniIcerik);

      // 3. Güncellenmiş listeyi Firestore'a geri yükle
      await FirebaseFirestore.instance.collection('dersler').doc(docID).update({
        'haftalik_icerik': haftalikIcerik.map((icerik) => icerik.toMap()).toList(),
      });
    } catch (e) {
      print("Güncelleme işlemi sırasında hata oluştu: $e");
    }
  }
}
