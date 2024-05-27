import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/service/service.dart';
import 'package:bologna/view/ders%20detay/ders_detay.dart';
import 'package:flutter/material.dart';

class OgretimPlani extends StatefulWidget {
  const OgretimPlani({super.key});

  @override
  State<OgretimPlani> createState() => _OgretimPlaniState();
}

class _OgretimPlaniState extends State<OgretimPlani> {

  List<Lesson> birinciDonem = [];
  List<Lesson> ikinciDonem = [];
  List<Lesson> ucuncuDonem = [];
  List<Lesson> dorduncuDonem = [];
  List<Lesson> besinciDonem = [];
  List<Lesson> altinciDonem = [];
  List<Lesson> yedinciDonem = [];
  List<Lesson> sekizinciDonem = [];
  List<Lesson> dokuzuncuDonem = [];
  List<Lesson> onuncuDonem = [];
  List<Lesson> onbirinciDonem = [];
  List<Lesson> onikinciDonem = [];
  List<Lesson> onucuncuDonem = [];
  List<Lesson> ondorduncuDonem = [];

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
            birinciDonem.clear();
            ikinciDonem.clear();
            ucuncuDonem.clear();
            dorduncuDonem.clear();
            besinciDonem.clear();
            altinciDonem.clear();
            yedinciDonem.clear();
            sekizinciDonem.clear();
            dokuzuncuDonem.clear();
            onuncuDonem.clear();
            onbirinciDonem.clear();
            onikinciDonem.clear();
            onucuncuDonem.clear();
            ondorduncuDonem.clear();

            for (var lesson in lessonList) {
              if (lesson.verildigi_donem == '1') {
                birinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '2') {
                ikinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '3') {
                ucuncuDonem.add(lesson);
              } else if (lesson.verildigi_donem == '4') {
                dorduncuDonem.add(lesson);
              } else if (lesson.verildigi_donem == '5') {
                besinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '6') {
                altinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '7') {
                yedinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '8') {
                sekizinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '9') {
                dokuzuncuDonem.add(lesson);
              } else if (lesson.verildigi_donem == '10') {
                onuncuDonem.add(lesson);
              } else if (lesson.verildigi_donem == '11') {
                onbirinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '12') {
                onikinciDonem.add(lesson);
              } else if (lesson.verildigi_donem == '13') {
                onucuncuDonem.add(lesson);
              } else if (lesson.verildigi_donem == '14') {
                ondorduncuDonem.add(lesson);
              }
            }

            return ListView(
              children: [
                if (birinciDonem.isNotEmpty) _buildDonemSection("1. Dönem Dersleri", birinciDonem),
                if (ikinciDonem.isNotEmpty) _buildDonemSection("2. Dönem Dersleri", ikinciDonem),
                if (ucuncuDonem.isNotEmpty) _buildDonemSection("3. Dönem Dersleri", ucuncuDonem),
                if (dorduncuDonem.isNotEmpty) _buildDonemSection("4. Dönem Dersleri", dorduncuDonem),
                if (besinciDonem.isNotEmpty) _buildDonemSection("5. Dönem Dersleri", besinciDonem),
                if (altinciDonem.isNotEmpty) _buildDonemSection("6. Dönem Dersleri", altinciDonem),
                if (yedinciDonem.isNotEmpty) _buildDonemSection("7. Dönem Dersleri", yedinciDonem),
                if (sekizinciDonem.isNotEmpty) _buildDonemSection("8. Dönem Dersleri", sekizinciDonem),
                if (dokuzuncuDonem.isNotEmpty) _buildDonemSection("9. Dönem Dersleri", dokuzuncuDonem),
                if (onuncuDonem.isNotEmpty) _buildDonemSection("10. Dönem Dersleri", onuncuDonem),
                if (onbirinciDonem.isNotEmpty) _buildDonemSection("11. Dönem Dersleri", onbirinciDonem),
                if (onikinciDonem.isNotEmpty) _buildDonemSection("12. Dönem Dersleri", onikinciDonem),
                if (onucuncuDonem.isNotEmpty) _buildDonemSection("13. Dönem Dersleri", onucuncuDonem),
                if (ondorduncuDonem.isNotEmpty) _buildDonemSection("14. Dönem Dersleri", ondorduncuDonem),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDonemSection(String title, List<Lesson> lessons) {
    return ExpansionTile(
      title: Text(title),
      children: lessons.map((lesson) {
        return ListTile(
          title: Text("${lesson.ders_kodu} ${lesson.ders_adi}"),
          subtitle: Text(lesson.ogretim_elemani),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DersDetay(
                  docID: lesson.docId,
                  ders_adi: lesson.ders_adi,
                  ders_kodu: lesson.ders_kodu,
                  ogretim_elemani: lesson.ogretim_elemani,
                  akts: lesson.akts,
                  kredi: lesson.kredi,
                  kaynaklar: lesson.kaynaklar,
                  ogrenimCiktisi: lesson.ogrenimCiktisi,
                  haftalik_icerik: lesson.haftalik_icerik,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
