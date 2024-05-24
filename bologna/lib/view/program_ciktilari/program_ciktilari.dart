import 'package:bologna/view/program_ciktilari/add_program_cikti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bologna/service/service.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';

class ProgramCiktilariScreen extends StatefulWidget {
  const ProgramCiktilariScreen({super.key});

  @override
  State<ProgramCiktilariScreen> createState() => _ProgramCiktilariScreenState();
}

class _ProgramCiktilariScreenState extends State<ProgramCiktilariScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ProgramCiktilari>>(
        stream: UserService().getProgramCikti('Bilgisayar Mühendisliği'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Atanmış Ders Bulunamadı'));
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
                        child: GestureDetector(
                          onTap: () {
                            // Tıklama olayını işleyin
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text("${ciktiList[index].id}  ${ciktiList[index].cikti_aciklama}"),
                              subtitle: const Text("Ders Açıklması max 1 satır olarak getirilecek"),
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
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            _openDialog(context);
          },
          label: const Row(
            children: [
              Icon(CupertinoIcons.add_circled),
              SizedBox(width: 5,),
              Text("Ders Çıktısı Ekle")
            ],
          )
      ),
    );
  }
  void _openDialog(BuildContext context){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      builder: (context) => Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const AddProgramCikti(),
      ),
    );
  }
}
