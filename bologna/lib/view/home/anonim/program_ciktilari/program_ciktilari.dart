import 'package:bologna/common/entities/idareci.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/program_ciktilari/add_program_cikti.dart';
import 'package:bologna/view/program_ciktilari/program_cikti_detay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bologna/service/service.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';
import 'package:google_fonts/google_fonts.dart';

class AnonimProgramCiktilariScreen extends StatefulWidget {
  const AnonimProgramCiktilariScreen({super.key, required this.fakulte_adi});

  final String fakulte_adi;

  @override
  State<AnonimProgramCiktilariScreen> createState() => _AnonimProgramCiktilariScreenState();
}

class _AnonimProgramCiktilariScreenState extends State<AnonimProgramCiktilariScreen> {
  List<int> ciktiIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProgramCiktilari>>(
        stream: UserService().getProgramCikti(widget.fakulte_adi),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Program Bulunamadı'));
          } else {
            var ciktiList = snapshot.data!;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: ciktiList.length,
                    itemBuilder: (context, index) {
                      ciktiIds.add(ciktiList[index].id);
                      print(ciktiIds);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<SignInBloc, SignInState>(
                            builder: (context, state) {
                          return state.role == 'idareci' ?  Dismissible(
                            key: Key(ciktiList[index].docId as String),
                            background: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.delete_forever_sharp,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Not Silinecek",
                                  style: GoogleFonts.montaga(color: Colors.red),
                                ),
                              ],
                            ),
                            onDismissed: (direction) {
                              Idareci(
                                      name: state.name,
                                      surname: state.surname,
                                      email: state.email,
                                      password: state.password,
                                      role: state.role)
                                  .programCiktisiSil(
                                      state.gorevli_oldugu_fakulte,
                                      ciktiList[index].docId);
                            },
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListTile(
                                  title: Text(
                                    "Program Çıktısı${ciktiList[index].id} ",
                                    style: GoogleFonts.aBeeZee(),
                                  ),
                                  subtitle: Text(
                                    ciktiList[index].cikti_aciklama,
                                    style: GoogleFonts.aBeeZee(),
                                  ),
                                ),
                              ),
                            ),
                          ) : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text(
                                "Program Çıktısı${ciktiList[index].id} ",
                                style: GoogleFonts.aBeeZee(),
                              ),
                              subtitle: Text(
                                ciktiList[index].cikti_aciklama,
                                style: GoogleFonts.aBeeZee(),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),

    );
  }
}
