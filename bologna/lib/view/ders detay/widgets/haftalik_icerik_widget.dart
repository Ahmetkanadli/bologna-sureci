import 'package:bologna/common/entities/haftalik_icerik.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/ders%20detay/widgets/haftalik_icerik_guncelle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Widget HaftalikIcerikler(List<HaftalikIcerik> haftalik_icerik,String? docID){
  return BlocBuilder<SignInBloc,SignInState>(
    builder: (context,state) {
      return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: haftalik_icerik.length,
        itemBuilder: (context, index) {
          final icerik = haftalik_icerik[index];
          return Column(
            children: [
              GestureDetector(
                onTap: (){
                  if(state.role == 'Öğretim elemanı'){
                    _openDetay(context, state.gorevli_oldugu_fakulte, icerik.hafta_no, icerik.icerik_aciklamasi, docID);
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
      );
    }
  );
}

void _openDetay(BuildContext context, String fakulte_adi, int icerik_id,
    String icerik_aciklama,String? docID,) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    builder: (context) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child:HaftalikIcerikGuncelle(icerik_id: icerik_id, icerik_aciklama: icerik_aciklama, docID: docID,)),
  );
}