import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';
import 'package:bologna/service/service.dart';
import 'package:flutter/material.dart';

Widget Matris(Lesson lesson) {
  // Program çıktıları ve öğrenim çıktıları sayısını al
  int programCiktiSayisi = 11; // Burada sabit 11 sütun olacak şekilde ayarladım
  int ogrenimCiktisiSayisi = lesson.ogrenimCiktisi.length;


  // Program çıktıları için kolonlar oluştur
  List<DataColumn> columns = [
    DataColumn(label: Text('')),
    for (int i = 1; i <= programCiktiSayisi; i++) DataColumn(label: Text('P.Ç. $i')),
  ];

  // Öğrenim çıktıları için satırlar oluştur
  List<DataRow> rows = [
    for (int i = 0; i < ogrenimCiktisiSayisi; i++)
      DataRow(cells: [
        DataCell(Text('Ö.Ç. ${i + 1}')),
        for (int j = 1; j <= programCiktiSayisi; j++)
          DataCell(Text(lesson.ogrenimCiktisi[i].ilisikili_oldugu_program_ciktilari != null &&
              lesson.ogrenimCiktisi[i].ilisikili_oldugu_program_ciktilari!.contains(j) ? '1' : '0')),
      ]),
  ];

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: DataTable(
      columns: columns,
      rows: rows,
    ),
  );
}
