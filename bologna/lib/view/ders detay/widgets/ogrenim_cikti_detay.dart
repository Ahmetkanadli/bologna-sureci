import 'package:bologna/common/entities/idareci.dart';
import 'package:bologna/common/entities/ogretim_elemani.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OgrenimCiktisiDetay extends StatefulWidget {
  OgrenimCiktisiDetay({
    super.key,
    required this.docID,
    required this.ids,
    required this.cikti_id,
    required this.cikti_aciklama,
    required this.fakulte_adi,
  });

  final String fakulte_adi;

  final String? docID;
  final List<int> ids;
  final int cikti_id;
  final String cikti_aciklama;

  @override
  State<OgrenimCiktisiDetay> createState() => _OgrenimCiktisiDetayState();
}

class _OgrenimCiktisiDetayState extends State<OgrenimCiktisiDetay> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _aciklamaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idController.text = widget.cikti_id.toString();
    _aciklamaController.text = widget.cikti_aciklama;
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
                      "Öğrenim Çıktısı Bilgileri",
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
                              .ogrenimCiktiGuncelle(
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
