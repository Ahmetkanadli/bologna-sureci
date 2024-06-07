import 'package:bologna/common/entities/haftalik_icerik.dart';
import 'package:bologna/common/entities/ogretim_elemani.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/ders%20detay/widgets/haftalikIcerikEkle.dart';
import 'package:bologna/view/ders%20detay/widgets/haftalik_icerik_guncelle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class HaftalikIcerikler extends StatefulWidget {
  HaftalikIcerikler({
    super.key,
    required this.docID,
    required this.haftalik_icerik
  });

  List<HaftalikIcerik> haftalik_icerik;
  String? docID;


  @override
  State<HaftalikIcerikler> createState() => _HaftalikIceriklerState();
}

class _HaftalikIceriklerState extends State<HaftalikIcerikler> {

  List<int> ids =[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Scaffold(
          body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: widget.haftalik_icerik.length,
            itemBuilder: (context, index) {
              final icerik = widget.haftalik_icerik[index];
              ids.add(icerik.hafta_no);
              return state.role == 'Öğretim elemanı' ?
              Dismissible(
                key: Key(icerik.icerik_aciklamasi),
                background: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (state.role == 'Öğretim elemanı') {
                          _openDetay(context, state.gorevli_oldugu_fakulte,
                              icerik.hafta_no, icerik.icerik_aciklamasi, widget.docID);
                        }
                      },
                      child: ListTile(
                        title: Text(
                          "Hafta ${icerik.hafta_no}",
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          icerik.icerik_aciklamasi,
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                onDismissed: (direction){
                  OgretimElemani(
                      name: state.name,
                      surname: state.surname,
                      email: state.email,
                      password: state.password,
                      role: state.role)
                      .haftalikIcerikSil(widget.docID, icerik.hafta_no);
                },
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (state.role == 'Öğretim elemanı') {
                          _openDetay(context, state.gorevli_oldugu_fakulte,
                              icerik.hafta_no, icerik.icerik_aciklamasi, widget.docID);
                        }
                      },
                      child: ListTile(
                        title: Text(
                          "Hafta ${icerik.hafta_no}",
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          icerik.icerik_aciklamasi,
                          style: GoogleFonts.aBeeZee(
                            textStyle: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              )
                  :Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (state.role == 'Öğretim elemanı') {
                        _openDetay(context, state.gorevli_oldugu_fakulte,
                            icerik.hafta_no, icerik.icerik_aciklamasi, widget.docID);
                      }
                    },
                    child: ListTile(
                      title: Text(
                        "Hafta ${icerik.hafta_no}",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        icerik.icerik_aciklamasi,
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
          floatingActionButton: state.role == 'Öğretim elemanı'
              ? FloatingActionButton.extended(
            onPressed: () {
              _openEkle(context, state.gorevli_oldugu_fakulte, widget.docID, ids);
            },
            label: const Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 10,),
                Text("İcerik Ekle"),
              ],
            ),
          )
              : Center());
    });
  }
}




void _openDetay(
  BuildContext context,
  String fakulte_adi,
  int icerik_id,
  String icerik_aciklama,
  String? docID,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: HaftalikIcerikGuncelle(
          icerik_id: icerik_id,
          icerik_aciklama: icerik_aciklama,
          docID: docID,
        )),
  );
}

void _openEkle(
    BuildContext context,
    String fakulte_adi,
    String? docID,
    List<int> ids
    ) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: HaftalikIcrerikEkle(docID: docID , ids: ids)
    ),
  );
}
