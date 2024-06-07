import 'package:bologna/bloc/program_tanim_control_bloc/program_tanim_bloc.dart';
import 'package:bologna/bloc/program_tanim_control_bloc/program_tanim_event.dart';
import 'package:bologna/bloc/program_tanim_control_bloc/program_tanim_state.dart';
import 'package:bologna/common/entities/idareci.dart';
import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/program_tanimi/program_tanimi.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/signin_events.dart';


import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/sign_in/sign_in.dart';
import 'package:bologna/view/dersler/ogretim_plani.dart';
import 'package:bologna/view/ogretim_elemanlari/ogretim_elemanlari.dart';
import 'package:bologna/view/program_ciktilari/program_ciktilari.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class IdareciHome extends StatefulWidget {
  const IdareciHome({super.key});

  @override
  State<IdareciHome> createState() => _IdareciHomeState();
}

class _IdareciHomeState extends State<IdareciHome> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(

            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )),
            backgroundColor: Colors.blueAccent,
            title: Text("${state.name} ${state.surname}",
              style: GoogleFonts.aBeeZee(
                  textStyle : const TextStyle(
                      color: Colors.white
                  )
              ),
            ),
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
              preferredSize: const Size.fromHeight(48.0),
              child: ClipPath(
                clipper: CustomTabBarClipper(),
                child: const TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  physics: BouncingScrollPhysics(),
                  tabs: <Widget>[
                    Tab(text: "Program Tanımı"),
                    Tab(text: "Program Çıktıları"),
                    Tab(text: "Programın Öğretim Planı"),
                    Tab(text: "Akademik Kadro"),
                  ],
                ),
              ),
            ),
          ),
          body: BlocBuilder<SignInBloc,SignInState>(
            builder: (context,state) {
              return  TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const ProgramTanimiWidget(),
                  ProgramCiktilariScreen(fakulte_adi: state.gorevli_oldugu_fakulte,),
                  const OgretimPlani(),
                  const OgretimElemanlari(),

                ],
              );
            }
          ),
        ),
      );
    });
  }
}

class CustomTabBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 120);
    path.quadraticBezierTo(0, size.height, 20, size.height);
    path.lineTo(size.width - 10, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
