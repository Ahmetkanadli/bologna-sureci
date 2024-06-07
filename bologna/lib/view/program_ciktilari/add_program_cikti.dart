import 'package:bologna/bloc/program_cikti_control_bloc/program_cikti_bloc.dart';
import 'package:bologna/bloc/program_cikti_control_bloc/program_cikti_events.dart';
import 'package:bologna/bloc/program_cikti_control_bloc/program_control_states.dart';
import 'package:bologna/common/entities/idareci.dart';
import 'package:bologna/common/entities/lesson_entity.dart';
import 'package:bologna/common/entities/program_ciktilari.dart';
import 'package:bologna/common/toast/flutter_toast.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProgramCikti extends StatefulWidget {
  const AddProgramCikti({super.key,required this.fakulte_adi,required this.ciktiIds});

  final String fakulte_adi;
  final List<int> ciktiIds;

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
                      "  Çıktı Numarası",
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
                        keyboardType: TextInputType.number,
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
                        BlocBuilder<ProgramCiktiInBloc,ProgramCiktiState>(
                          builder: (context,stte) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15)),
                                onPressed: () {
                                  // Reset the state
                                  context.read<ProgramCiktiInBloc>().add(CiktiEvent(false));

                                  // Input validation
                                  if (_idController.text.isEmpty) {
                                    toastInfo(msg: "ID alanı boş olamaz");
                                    return;
                                  }

                                  if (_aciklamaController.text.isEmpty) {
                                    toastInfo(msg: "Açıklama alanı boş olamaz");
                                    return;
                                  }

                                  // Check if the ID already exists
                                  bool idExists = widget.ciktiIds.any((element) => element.toString() == _idController.text);

                                  if (idExists) {
                                    toastInfo(msg: "Bu çıktı numarasına ait bir program çıktısı zaten var");
                                    context.read<ProgramCiktiInBloc>().add(CiktiEvent(true));
                                    return;
                                  }

                                  if(widget.ciktiIds.length > 12){
                                    toastInfo(msg: "Çıktı Sayısı 12'den fazla olamaz");
                                    return;
                                  }

                                  // Since the ID does not exist, add the new program output
                                  context.read<ProgramCiktiInBloc>().state.program_cikti_var = false; // Ensure the state is correct
                                  Idareci(
                                    name: state.name,
                                    surname: state.surname,
                                    email: state.email,
                                    password: state.password,
                                    role: state.password,
                                  ).programCiktisiEkle(
                                    ProgramCiktilari(
                                      id: int.parse(_idController.text),
                                      cikti_aciklama: _aciklamaController.text,
                                    ),
                                    widget.fakulte_adi,
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Kaydet"));
                          }
                        ),
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
