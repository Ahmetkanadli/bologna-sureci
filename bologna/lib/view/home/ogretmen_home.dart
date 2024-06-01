import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/service/service.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/signin_events.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/sign_in/sign_in.dart';
import 'package:bologna/view/atanm%C4%B1s_dersler/atanm%C4%B1s_dersler.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    var lessonsStream = UserService().getLessons();

    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 1, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              backgroundColor: Colors.blueAccent,
              title: Text("${state.name} ${state.surname}"),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SingIn()));
                      context.read<SignInBloc>().add(const EmailEvent(''));
                      context.read<SignInBloc>().add(const PasswordEvent(''));
                      context.read<SignInBloc>().add(const NameEvent(''));
                      context.read<SignInBloc>().add(const SurnameEvent(''));
                      context.read<SignInBloc>().add(const RoleEvent(''));
                      context.read<SignInBloc>().add(const GorevliOlduguFakulteEvent(''));

                    },
                    icon: const Icon(Icons.logout)
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(24.0),
                child: ClipPath(
                  clipper: CustomTabBarClipper(),
                  child: const TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    physics: BouncingScrollPhysics(),
                    tabs: <Widget>[
                      Tab(text: ""),
                    ],
                  ),
                ),
              ),
            ),
            body: BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return const TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    AtanmisDersler(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class CustomTabBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Custom clipping logic here if needed
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
