import 'package:bologna/common/entities/ogretim_elemani.dart';
import 'package:bologna/common/toast/flutter_toast.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HaftalikIcrerikEkle extends StatefulWidget {
  HaftalikIcrerikEkle({
    super.key,
    required this.docID,
    required this.ids,
  });

  String? docID;
  final List<int> ids;

  @override
  State<HaftalikIcrerikEkle> createState() => _HaftalikIcrerikEkleState();
}

class _HaftalikIcrerikEkleState extends State<HaftalikIcrerikEkle> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Haftalık Icerik Bilgileri",
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                Divider(thickness: 1.1, color: Colors.grey.shade200),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "  Hafta Numarası",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextField(
                    style: TextStyle(),
                    controller: _idController,
                    readOnly: false,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Hafta No'),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "  Aciklama",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    style: TextStyle(),
                    controller: _aciklamaController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Aciklama Ekle',
                    ),
                    maxLines: 15,
                    onChanged: (value) {
                      // Burada sadece yeni değeri alıyoruz
                      // _aciklamaController.text = value; bu satıra gerek yok
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 15)),
                        onPressed: () {
                          if (_idController.text.isEmpty) {
                            toastInfo(msg: "ID alanı boş olamaz");
                            return;
                          } else if (_aciklamaController.text.isEmpty) {
                            toastInfo(msg: "Açıklama alanı boş olamaz");
                            return;
                          }

                          int ciktiID = int.parse(_idController.text);

                          if (widget.ids.contains(ciktiID)) {
                            toastInfo(msg: 'Bu ID\'ye ait bir çıktı zaten var');
                            return;
                          }

                          OgretimElemani(
                              name: state.name,
                              surname: state.surname,
                              email: state.email,
                              password: state.password,
                              role: state.role)
                              .haftalikIcerikEkle(widget.docID , int.parse(_idController.text), _aciklamaController.text);
                          Navigator.pop(context);
                        },
                        child: const Text("Kaydet")),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
