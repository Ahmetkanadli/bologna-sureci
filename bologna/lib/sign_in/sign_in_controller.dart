import 'package:bologna/common/toast/flutter_toast.dart';
import 'package:bologna/sign_in/bloc/signin_events.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/home/idareci_home.dart';
import 'package:bologna/view/home/ogretmen_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingInController {
  final BuildContext context;

  const SingInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == "email") {
        final state = context.read<SignInBloc>().state;
        String emailAdress = state.email;
        String password = state.password;

        if (emailAdress.isEmpty) {
          toastInfo(msg: "You need to fill email address");
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: "You need to fill password");
          return;
        }

        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
              email: emailAdress, password: password);

          if (credential.user == null) {
            toastInfo(msg: "You don't exist");
            return;
          }

          var user = credential.user;

          if (user != null) {
            print('User exists : ${user.uid}');
            try {
              DocumentSnapshot userDoc = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .get();
              if (userDoc.exists) {
                final userData = userDoc.data() as Map<String, dynamic>;
                context.read<SignInBloc>().add(NameEvent(userData['name'] ?? ''));
                context.read<SignInBloc>().add(SurnameEvent(userData['surname'] ?? ''));
                context.read<SignInBloc>().add(RoleEvent(userData['role'] ?? ''));

                // Update the state with the new user data
                final updatedState = context.read<SignInBloc>().state;
                
                // Debug print to check role
                print("Role: ${userData['role']}");

                // Navigate based on role
                if (userData['role'].toString() == 'Öğretim elemanı') {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => TeacherHome())
                  );
                } else if (userData['role'].toString() == 'idareci') {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const IdareciHome())
                  );
                }
              } else {
                toastInfo(msg: "User data not found");
              }

            } catch (e) {
              toastInfo(msg: "Failed to retrieve user data: ${e.toString()}");
            }
          } else {
            toastInfo(msg: "Currently you are not a user of this app");
            return;
          }

        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            toastInfo(msg: "No user found for that email");
          } else if (e.code == 'wrong-password') {
            toastInfo(msg: "Wrong password provided for that user");
          } else if (e.code == 'invalid-email') {
            toastInfo(msg: "Your email format is wrong");
          }
        }
      }
    } catch (e) {
      toastInfo(msg: "An error occurred: ${e.toString()}");
    }
  }
}
