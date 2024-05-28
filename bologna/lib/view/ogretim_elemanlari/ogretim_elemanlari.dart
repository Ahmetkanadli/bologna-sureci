import 'package:bologna/common/entities/user_entity.dart';
import 'package:bologna/service/service.dart';
import 'package:flutter/material.dart';

class OgretimElemanlari extends StatefulWidget {
  const OgretimElemanlari({super.key});

  @override
  State<OgretimElemanlari> createState() => _OgretimElemanlariState();
}

class _OgretimElemanlariState extends State<OgretimElemanlari> {
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
                      return
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
                            child: Row(
                              children: [

                                ListTile(
                                  title: Text(
                                      "${teacherList[index].name}  ${teacherList[index].surname}"),
                                  subtitle: Text(
                                      "${teacherList[index].email}  ${teacherList[index].role}"),
                                ),
                              ],
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
