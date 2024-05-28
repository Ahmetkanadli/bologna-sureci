import 'package:bologna/common/entities/fakulte.dart';
import 'package:bologna/view/home/anonim/anonim_kullanici_home.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../service/service.dart';

class AnonimHome extends StatefulWidget {
  const AnonimHome({super.key});

  @override
  State<AnonimHome> createState() => _AnonimHomeState();
}

class _AnonimHomeState extends State<AnonimHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fakülteler",
          style: GoogleFonts.aBeeZee(
              textStyle : const TextStyle(
                  color: Colors.white
              )
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        backgroundColor: Colors.blueAccent,
      ),
      body: StreamBuilder<List<Fakulte>>(
        stream: UserService().getFakulte(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Atanmış Ders Bulunamadı'));
          } else {
            var fakulteList = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: fakulteList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainAnonimHome(
                                      fakulte:
                                          fakulteList[index].fakulte_adi)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text("${fakulteList[index].fakulte_adi} "),
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
