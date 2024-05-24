import 'package:bologna/common/entities/idareci.dart';
import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProgramCikti extends StatefulWidget {
  const AddProgramCikti({super.key});

  @override
  State<AddProgramCikti> createState() => _AddProgramCiktiState();
}

class _AddProgramCiktiState extends State<AddProgramCikti> {

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Program Çıktısı Bilgileri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        )),
                    Divider(thickness: 1.1, color: Colors.grey.shade200),
                    const SizedBox(height: 10,),
                    const Text(
                      "  ID",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: TextField(
                        style: TextStyle(

                        ),
                        controller: _idController,
                        autofocus: true,
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Çıktı ID'
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      "  Açıklama",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: TextField(
                        style: TextStyle(

                        ),
                        controller: _aciklamaController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Açıklama Ekle',
                        ),
                        maxLines: 15,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15)),
                            onPressed: () {
                              Idareci(
                                  name: state.name,
                                  surname: state.surname,
                                  email: state.email,
                                  password: state.password,
                                  role: state.password)
                                  .programCiktisiEkle(
                                  ProgramCiktilari(id: int.parse(_idController.text),
                                      cikti_aciklama: _aciklamaController.text),
                                  "Bilgisayar Mühendisliği"
                              );
                            },
                            child: Text("Kaydet")),
                        const SizedBox(width: 10,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
