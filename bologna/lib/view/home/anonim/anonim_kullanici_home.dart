import 'package:bologna/common/entities/program_tanimi.dart';

import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/dersler/ogretim_plani.dart';
import 'package:bologna/view/home/anonim/ogretim_elemanlari/ogretim_elemanlari.dart';
import 'package:bologna/view/home/anonim/ogretim_plani/ogretim_plani.dart';
import 'package:bologna/view/home/anonim/program_ciktilari/program_ciktilari.dart';
import 'package:bologna/view/home/anonim/program_tanimi/program_tanimi.dart';
import 'package:bologna/view/home/idareci_home.dart';
import 'package:bologna/view/ogretim_elemanlari/ogretim_elemanlari.dart';
import 'package:bologna/view/program_ciktilari/program_ciktilari.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAnonimHome extends StatefulWidget {
  const MainAnonimHome({super.key, required this.fakulte});

  final String fakulte;

  @override
  State<MainAnonimHome> createState() => _MainAnonimHomeState();
}

class _MainAnonimHomeState extends State<MainAnonimHome> {
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
            title: Text(
              widget.fakulte,
              style: GoogleFonts.aBeeZee(
                textStyle : const TextStyle(
                  color: Colors.white
                )
              ),
            ),
            actions: [

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
                    ProgramTanimiWidget(fakulte: widget.fakulte,),
                    AnonimProgramCiktilariScreen(fakulte_adi: widget.fakulte),
                    AnonimOgretimPlani(fakulte_adi: widget.fakulte),
                    AnonimOgretimElemanlari(fakulte_adi: widget.fakulte),
                  ],
                );
              }
          ),
        ),
      );
    });
  }
}
