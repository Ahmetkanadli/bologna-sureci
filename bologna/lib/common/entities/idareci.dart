
import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';
import 'package:bologna/common/entities/program_tanimi.dart';
import 'package:bologna/common/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Idareci extends User {
  Idareci(
      {required super.name,
      required super.surname,
      required super.email,
      required super.password,
      required super.role
      });

  Future<void> dersEkle(Lesson lesson) async{

    FirebaseFirestore.instance.collection("dersler").add(lesson.toMap());
  }

  Future<void> programCiktisiEkle(ProgramCiktilari ciktiModel,String fakulteAdi) async{
    FirebaseFirestore.instance
        .collection('fakulte')
        .doc(fakulteAdi)
        .collection('program çıktıları')
        .add(ciktiModel.toMap());
  }

  Future<void> programCiktisiDuzenle(String cikti_aciklama,String fakulteAdi, String? docID) async{
    FirebaseFirestore.instance
        .collection('fakulte')
        .doc(fakulteAdi)
        .collection('program çıktıları')
        .doc(docID)
        .update({"cikti_aciklama" : cikti_aciklama});
  }

  Future<void> programCiktisiSil(String fakulteAdi, String? docID) async{
    FirebaseFirestore.instance
        .collection('fakulte')
        .doc(fakulteAdi)
        .collection('program çıktıları')
        .doc(docID)
        .delete();
  }

  Future<void> ogretmenAta(String? docID, String ogretimElemani) async{
    FirebaseFirestore.instance
        .collection('dersler')
        .doc(docID)
        .update({
            "ogretim_elemani" : ogretimElemani,
    });

  }

  Future<void> programTanimiDuzenle(String guncellenecekDeger,String deger,String fakulteAdi,) async {
    FirebaseFirestore.instance
        .collection('fakulte')
        .doc(fakulteAdi)
        .collection('program tanımı')
        .doc('5k5YzGsbNK8HkXxcWvHE')
        .update({
            '$guncellenecekDeger' :deger
          });
  }


}
