import 'package:bologna/common/entities/ogrenim_ciktisi.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/ders%20detay/widgets/ogrenim_cikti_detay.dart';
import 'package:bologna/view/ders%20detay/widgets/ogrenim_ciktisi_ekle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Widget OgrenimCiktilari(List<OgrenimCiktisi> ogrenim_ciktilari,String? docID) {

  List<int> ids = [];

  return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: ogrenim_ciktilari.length,
          itemBuilder: (context, index) {
            final cikti = ogrenim_ciktilari[index];
            ids.add(ogrenim_ciktilari[index].cikti_no);
              return GestureDetector(
                onTap: () {
                  if (state.role == 'Öğretim elemanı') {
                    _openDetay(context, state.gorevli_oldugu_fakulte, cikti.cikti_no, cikti.cikti_aciklama,docID,ids);
                  }
                },
                child: Column(
                  children: [
                    ListTile(
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
       floatingActionButton:  state.role == 'Öğretim elemanı' ? FloatingActionButton.extended(
           onPressed: (){
             _openEkle(context, docID, ids);
           },
           label: const Row(
             children: [
               Text("Ogrenim Ciktisi Ekle"),
               SizedBox(width: 10,),
               Icon(Icons.add)
             ],
           )
       ) : const Center(),
      );
    }
  );
}

void _openDetay(BuildContext context, String fakulte_adi, int cikti_id,
    String cikti_aciklama,String? docID, List<int> ids) {
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
            ids : ids,
            cikti_id: cikti_id,
            cikti_aciklama: cikti_aciklama,
            fakulte_adi: fakulte_adi)),
  );
}

void _openEkle(BuildContext context,String? docID, List<int> ids) {
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
