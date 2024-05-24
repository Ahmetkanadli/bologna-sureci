import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';
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

}
