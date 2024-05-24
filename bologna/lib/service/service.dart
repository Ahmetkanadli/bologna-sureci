import 'package:bologna/common/entities/fakulte.dart';
import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';
import 'package:bologna/common/entities/user_entity.dart';
import 'package:bologna/common/toast/flutter_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService{

  Future<void> getFacultys() async {

    try {
      await FirebaseFirestore.instance
          .collection('fakulte').snapshots().map((event) =>
      event.docs.map((snapshots) => Fakulte.fromSnapshot).toList()
      );

    } catch (error) {

      toastInfo(msg: "Failed to retrieve fakulte data: ${error.toString()}");
    }

  }


  Stream<List<Lesson>> getLessons() {
    return FirebaseFirestore.instance
        .collection('dersler')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Lesson.fromSnapshot(doc)).toList());
  }

  Stream<List<User>> getTeachers() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList());
  }

  Stream<List<ProgramCiktilari>> getProgramCikti(String fakulteAdi) {
    return FirebaseFirestore.instance
        .collection('fakulte')
        .doc(fakulteAdi)
        .collection('program çıktıları')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => ProgramCiktilari.fromSnapshot(doc)).toList());
  }

}