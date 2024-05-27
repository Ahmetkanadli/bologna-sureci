import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/service/service.dart';
import 'package:bologna/view/ders%20detay/ders_detay.dart';
import 'package:flutter/material.dart';

class Dersler extends StatefulWidget {
  const Dersler({super.key});

  @override
  State<Dersler> createState() => _DerslerState();
}

class _DerslerState extends State<Dersler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Lesson>>(
        stream: UserService().getLessons(),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: lessonList.length,
                    itemBuilder: (context, index) {
                      var lesson = lessonList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DersDetay(
                                    docID : lesson.docId,
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title:
                              Text("${lesson.ders_kodu}  ${lesson.ders_adi}"),
                              subtitle: Text(lesson.ogretim_elemani),
                            ),
                          ),
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
}