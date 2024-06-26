import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  final String? name;
  final String? surname;
  final String? email;
  final String? password;
  final String? role;
  String? gorevli_oldugu_fakulte;

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.role,
    this.gorevli_oldugu_fakulte
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'role' : role,
      'gorevli_oldugu_fakulte' : gorevli_oldugu_fakulte
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      //docId: map['docId'] != null ? map['docId'] as String : null,
      name: map['name'] as String,
      surname: map['surname'] as String,
      email: map['email'] as String,
      password: map['password'] != null ? map['password'] as String : null,
      role: map['role'] as String,
        gorevli_oldugu_fakulte: map['gorevli_oldugu_fakulte'] as String
    );
  }

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return User(
      //docId: doc.id,
      name: doc['name'] ?? '',
      surname: doc['surname'],
      email: doc['email'],
      password: doc['password'] ?? '',
       role: doc['role'],
        gorevli_oldugu_fakulte : doc['gorevli_oldugu_fakulte']
    );
  }
}