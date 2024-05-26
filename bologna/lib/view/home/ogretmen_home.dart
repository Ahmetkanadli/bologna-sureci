import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/service/service.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/ders%20detay/ders_detay.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "${state.name} ${state.surname}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          body: StreamBuilder<List<Lesson>>(
            stream: lessonsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Atanmış Ders Bulunamadı'));
              } else {
                var lessonList = snapshot.data!;
                return Column(
                  children: [
                    const Text("Atanmış dersler"),
                    Expanded(
                      child: ListView.builder(
                        itemCount: lessonList.length,
                        itemBuilder: (context, index) {
                          var lesson = lessonList[index];
                          String name = "${state.name} ${state.surname}";
                          print(name);
                          return lessonList[index].ogretim_elemani == name
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DersDetay(
                                                ders_adi: lesson.ders_adi,
                                                ders_kodu: lesson.ders_kodu,
                                                ogretim_elemani: lesson.ogretim_elemani,
                                                akts: lesson.akts,
                                                kredi: lesson.kredi,
                                                kaynaklar: lesson.kaynaklar,
                                                ogrenimCiktisi: lesson.ogrenimCiktisi,
                                                haftalik_icerik: lesson.haftalik_icerik,

                                              )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ListTile(
                                        title: Text(
                                            "${lesson.ders_kodu}  ${lesson.ders_adi}"),
                                        subtitle: Text(
                                            "Ders Açıklması max 1 satır olarak getirelecek"),
                                      ),
                                    ),
                                  ),
                              )
                              : const Center();
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}