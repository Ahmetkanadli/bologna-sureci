import 'package:bologna/common/entities/ogrenim_ciktisi.dart';
import 'package:bologna/common/entities/ogretim_elemani.dart';
import 'package:bologna/common/toast/flutter_toast.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/ders%20detay/widgets/ogrenim_cikti_detay.dart';
import 'package:bologna/view/ders%20detay/widgets/ogrenim_ciktisi_ekle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OgrenimCiktilari extends StatefulWidget {
  const OgrenimCiktilari(
      {super.key, required this.ogrenim_ciktilari, required this.docID});

  final List<OgrenimCiktisi> ogrenim_ciktilari;
  final String? docID;

  @override
  State<OgrenimCiktilari> createState() => _OgrenimCiktilariState();
}

class _OgrenimCiktilariState extends State<OgrenimCiktilari> {
  List<int> ids = [];

  @override
  void initState() {
    super.initState();
    ids = widget.ogrenim_ciktilari.map((cikti) => cikti.cikti_no).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: widget.ogrenim_ciktilari.length,
          itemBuilder: (context, index) {
            final cikti = widget.ogrenim_ciktilari[index];
            return GestureDetector(
              onTap: () {
                if (state.role == 'Öğretim elemanı') {
                  _openDetay(context, state.gorevli_oldugu_fakulte,
                      cikti.cikti_no, cikti.cikti_aciklama, widget.docID, ids);
                }
              },
              child: Column(
                children: [
                  state.role == 'Öğretim elemanı' && ids.length>5
                      ? Dismissible(
                    key: Key(cikti.cikti_aciklama),
                    background: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete_forever_sharp,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Not Silinecek",
                          style: GoogleFonts.montaga(color: Colors.red),
                        ),
                      ],
                    ),
                    onDismissed: (direction) async {
                      if (ids.length <= 5) {
                        toastInfo(
                            msg:
                            "Ogrenim Cıktısı sayısı 5'ten az olamaz");
                        setState(() {}); // Dismissible widget'ı geri ekle
                        return;
                      }

                      // Firestore'dan öğeyi silme işlemi
                      await OgretimElemani(
                          name: state.name,
                          surname: state.surname,
                          email: state.email,
                          password: state.password,
                          role: state.role)
                          .ogrenimCiktisiSil(widget.docID, cikti.cikti_no);

                      setState(() {
                        widget.ogrenim_ciktilari.removeAt(index);
                        ids.removeAt(index);
                      });
                    },
                    child: ListTile(
                      title: Text(
                        "Çıktı No: ${cikti.cikti_no}",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        cikti.cikti_aciklama,
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                      : ListTile(
                    title: Text(
                      "Çıktı No: ${cikti.cikti_no}",
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      cikti.cikti_aciklama,
                      style: GoogleFonts.aBeeZee(
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        ),
        floatingActionButton: state.role == 'Öğretim elemanı'
            ? FloatingActionButton.extended(
            onPressed: () {
              _openEkle(context, widget.docID, ids);
            },
            label: const Row(
              children: [
                Text("Ogrenim Ciktisi Ekle"),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.add)
              ],
            ))
            : const Center(),
      );
    });
  }
}

void _openDetay(BuildContext context, String fakulte_adi, int cikti_id,
    String cikti_aciklama, String? docID, List<int> ids) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: OgrenimCiktisiDetay(
            docID: docID,
            ids: ids,
            cikti_id: cikti_id,
            cikti_aciklama: cikti_aciklama,
            fakulte_adi: fakulte_adi)),
  );
}

void _openEkle(BuildContext context, String? docID, List<int> ids) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: OgrenimCiktisiEkle(ids: ids, docID: docID)),
  );
}
