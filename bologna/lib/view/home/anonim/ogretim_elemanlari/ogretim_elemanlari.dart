import 'package:bologna/common/entities/user_entity.dart';
import 'package:bologna/service/service.dart';
import 'package:flutter/material.dart';

class AnonimOgretimElemanlari extends StatefulWidget {
  const AnonimOgretimElemanlari({super.key, required this.fakulte_adi});

  final String fakulte_adi;

  @override
  State<AnonimOgretimElemanlari> createState() => _AnonimOgretimElemanlariState();
}

class _AnonimOgretimElemanlariState extends State<AnonimOgretimElemanlari> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder<List<User>>(
        stream: UserService().getTeachers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Atanmış Ders Bulunamadı'));
          } else {
            var teacherList = snapshot.data!;
            return Column(
              children: [

                Expanded(
                  child: ListView.builder(
                    itemCount: teacherList.length,
                    itemBuilder: (context, index) {
                      return widget.fakulte_adi == teacherList[index].gorevli_oldugu_fakulte ?
                        GestureDetector(
                          onTap: () {

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              child: ListTile(
                                title: Text(
                                    "${teacherList[index].name}  ${teacherList[index].surname}"),
                                subtitle: Text(
                                    "${teacherList[index].email}  ${teacherList[index].role}"),
                              ),
                            ),
                          ),
                        ) : const Center();

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
