import 'package:bologna/common/entities/ogretim_elemani.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HaftalikIcerikGuncelle extends StatefulWidget {
  HaftalikIcerikGuncelle({
    super.key,
    required this.docID,
    required this.icerik_id,
    required this.icerik_aciklama,
  });

  String? docID;
  final int icerik_id;
  final String icerik_aciklama;

  @override
  State<HaftalikIcerikGuncelle> createState() => _HaftalikIcerikGuncelleState();
}

class _HaftalikIcerikGuncelleState extends State<HaftalikIcerikGuncelle> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idController.text = widget.icerik_id.toString();
    _aciklamaController.text = widget.icerik_aciklama;
  }

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
                      "Haftalık İçerik Bilgileri",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                Divider(thickness: 1.1, color: Colors.grey.shade200),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "  Çıktı Numarası",
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
                    readOnly: true,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Çıktı ID'),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "  Açıklama",
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
                      hintText: 'Açıklama Ekle',
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
                          OgretimElemani(
                                  name: state.name,
                                  surname: state.surname,
                                  email: state.email,
                                  password: state.password,
                                  role: state.role)
                              .haftalikIcerikGuncelle(
                                  widget.docID,
                                  int.parse(_idController.text),
                                  _aciklamaController.text);
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
