import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditableMatrix extends StatefulWidget {
  final Lesson lesson;

  EditableMatrix({required this.lesson});

  @override
  _EditableMatrixState createState() => _EditableMatrixState();
}

class _EditableMatrixState extends State<EditableMatrix> {
  late List<List<int>> _matrixValues;
  int programCiktiSayisi = 11;

  @override
  void initState() {
    super.initState();
    _initializeMatrixValues();
  }

  void _initializeMatrixValues() {

    _matrixValues = List.generate(
      widget.lesson.ogrenimCiktisi.length,
          (i) => List.generate(
        programCiktiSayisi,
            (j) {
          return widget.lesson.ogrenimCiktisi[i].ilisikili_oldugu_program_ciktilari?.contains(j + 1) ?? false ? 1 : 0;
        },
      ),
    );
  }

  void _saveChanges() async {
    for (int i = 0; i < widget.lesson.ogrenimCiktisi.length; i++) {
      List<int> updatedProgramCiktilari = [];
      for (int j = 0; j < programCiktiSayisi; j++) {
        if (_matrixValues[i][j] == 1) {
          updatedProgramCiktilari.add(j + 1);
        }
      }
      widget.lesson.ogrenimCiktisi[i].ilisikili_oldugu_program_ciktilari = updatedProgramCiktilari;
    }

    // Save to Firebase
    CollectionReference lessons = FirebaseFirestore.instance.collection('dersler');
    await lessons.doc(widget.lesson.docId).update({
      'ogrenimCiktisi': widget.lesson.ogrenimCiktisi.map((e) => e.toMap()).toList(),
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Changes saved to Firebase!')));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('')),
              for (int i = 1; i <= programCiktiSayisi; i++) DataColumn(label: Text('P.Ç. $i')),
            ],
            rows: [
              for (int i = 0; i < widget.lesson.ogrenimCiktisi.length; i++)
                DataRow(cells: [
                  DataCell(Text('Ö.Ç. ${i + 1}')),
                  for (int j = 0; j < programCiktiSayisi; j++)
                    DataCell(
                      DropdownButton<int>(
                        value: _matrixValues[i][j],
                        items: [
                          DropdownMenuItem(
                            value: 0,
                            child: Text('0'),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text('1'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _matrixValues[i][j] = value ?? 0;
                          });
                        },
                      ),
                    ),
                ]),
            ],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveChanges,
          child: Text('Save Changes'),
        ),
      ],
    );
  }
}
