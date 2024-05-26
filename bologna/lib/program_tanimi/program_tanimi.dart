import 'package:bologna/bloc/program_tanim_control_bloc/program_tanim_bloc.dart';
import 'package:bologna/bloc/program_tanim_control_bloc/program_tanim_event.dart';
import 'package:bologna/bloc/program_tanim_control_bloc/program_tanim_state.dart';
import 'package:bologna/common/entities/idareci.dart';
import 'package:bologna/common/entities/program_tanimi.dart';
import 'package:bologna/common/values/colors.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgramTanimiWidget extends StatefulWidget {
  const ProgramTanimiWidget({super.key});

  @override
  State<ProgramTanimiWidget> createState() => _ProgramTanimiState();
}

class _ProgramTanimiState extends State<ProgramTanimiWidget> {
  final TextEditingController _kurulusController = TextEditingController();
  final TextEditingController _dereceController = TextEditingController();
  final TextEditingController _dereceduzeyController = TextEditingController();
  final TextEditingController _kosulController = TextEditingController();
  final TextEditingController _gecisController = TextEditingController();
  final TextEditingController _sinavlarController = TextEditingController();
  final TextEditingController _degerlendirmeController = TextEditingController();
  final TextEditingController _calismaSekliController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProgramTanimi>>(
        stream: UserService().getProgramTanimi("Bilgisayar Mühendisliği"),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<SignInBloc, SignInState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                if (state.role == "idareci") {
                                  // Handle the tap event for idareci role
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "Kuruluş",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                        builder: (context, stte) {
                                          return textField(
                                            _kurulusController,
                                            ciktiList[index].kurulus!,
                                                () {
                                              context.read<ProgramTanimInBloc>().add(KurulusEvent(true));
                                            },
                                          );
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].kurulus ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.kurulsuDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(KurulusEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'kurulus',
                                                      _kurulusController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Kazanılan Derece",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? textField(
                                        _dereceController,
                                        ciktiList[index].derece_duzeyi!,
                                            () {
                                          context.read<ProgramTanimInBloc>().add(DereceEvent(true));
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].kazanilan_derece ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.dereceDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(DereceEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'kazanilan_derece',
                                                      _dereceController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Derecenin Düzeyi (Ön Lisans , Lisans, Yüksek Lisans, Doktora)",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? textField(
                                        _dereceduzeyController,
                                        ciktiList[index].derece_duzeyi!,
                                            () {
                                          context.read<ProgramTanimInBloc>().add(DereceDuzeyEvent(true));
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].derece_duzeyi ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.dereeDuzeyDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(DereceDuzeyEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'derece_duzeyi',
                                                      _dereceduzeyController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Yeterlilik Koşulları ve Kuralları",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? textField(
                                        _kosulController,
                                        ciktiList[index].yeterlilik_kosullari!,
                                            () {
                                          context.read<ProgramTanimInBloc>().add(YeterlilikEvent(true));
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].yeterlilik_kosullari ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.yeterlilikDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(YeterlilikEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'yeterlilik_kosullari',
                                                      _kosulController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Üst Derece Programlarına Geçiş",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? textField(
                                        _gecisController,
                                        ciktiList[index].ust_derece_programlarina_gecis!,
                                            () {
                                          context.read<ProgramTanimInBloc>().add(GecisEvent(true));
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].ust_derece_programlarina_gecis ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.gecisDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(GecisEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'ust_derece_programlarina_gecis',
                                                      _gecisController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Sınavlar",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? textField(
                                        _sinavlarController,
                                        ciktiList[index].sinavlar!,
                                            () {
                                          context.read<ProgramTanimInBloc>().add(SinavlarEvent(true));
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].sinavlar ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.sinavlarDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(SinavlarEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'sinavlar',
                                                      _sinavlarController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Ölçme ve Değerlendirme",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? textField(
                                        _degerlendirmeController,
                                        ciktiList[index].olcme_ve_degerlerndirme!,
                                            () {
                                          context.read<ProgramTanimInBloc>().add(DegerlendirmeEvent(true));
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].olcme_ve_degerlerndirme ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.degerlendirmeDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(DegerlendirmeEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'olcme_ve_degerlerndirme',
                                                      _degerlendirmeController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Çalışma Şekli (Tam Zamanlı, e-öğrenme)",
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                      subtitle: state.role == 'idareci'
                                          ? textField(
                                        _calismaSekliController,
                                        ciktiList[index].calisma_sekli!,
                                            () {
                                          context.read<ProgramTanimInBloc>().add(CalismaEvent(true));
                                        },
                                      )
                                          : Text(
                                        ciktiList[index].calisma_sekli ?? '',
                                        style: GoogleFonts.aBeeZee(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        BlocBuilder<SignInBloc, SignInState>(
                                          builder: (context, state) {
                                            return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
                                              builder: (context, stte) {
                                                return stte.calismaDuzenleme == true
                                                    ? IconButton(
                                                  onPressed: () {
                                                    context.read<ProgramTanimInBloc>().add(CalismaEvent(false));
                                                    Idareci(
                                                      name: state.name,
                                                      surname: state.surname,
                                                      email: state.email,
                                                      password: state.password,
                                                      role: state.role,
                                                    ).programTanimiDuzenle(
                                                      'calisma_sekli',
                                                      _calismaSekliController.text,
                                                      state.gorevli_oldugu_fakulte,
                                                    );
                                                  },
                                                  icon: const Row(
                                                    children: [
                                                      Text("Kaydet"),
                                                      SizedBox(width: 5),
                                                      Icon(Icons.save_as_outlined),
                                                    ],
                                                  ),
                                                )
                                                    : const Center();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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

  Widget textField(TextEditingController controller, String deger, Function function) {
    controller.text = deger;
    return BlocBuilder<ProgramTanimInBloc, ProgramTanimState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              controller: controller,
              onTap: () {
                function(); // Fonksiyonu burada çağırın
              },
              onChanged: (value) {
                // Handle text change if needed
              },
              minLines: 1,
              maxLines: 200,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              style: GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                  fontSize: 13,
                ),
              ),
              autocorrect: false,
            ),
          ],
        );
      },
    );
  }
}
