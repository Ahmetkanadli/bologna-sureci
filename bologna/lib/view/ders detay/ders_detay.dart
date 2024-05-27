import 'package:bologna/common/entities/haftalik_icerik.dart';
import 'package:bologna/common/entities/idareci.dart';
import 'package:bologna/common/entities/kaynaklar.dart';
import 'package:bologna/common/entities/ogrenim_ciktisi.dart';
import 'package:bologna/common/entities/user_entity.dart';
import 'package:bologna/service/service.dart';
import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/view/ders%20detay/widgets/haftalik_icerik_widget.dart';
import 'package:bologna/view/ders%20detay/widgets/ogrenim_ciktilari_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DersDetay extends StatefulWidget {
  DersDetay({
    Key? key,
    this.docID,
    required this.ders_adi,
    required this.ders_kodu,
    this.ogretim_elemani,
    required this.akts,
    required this.kredi,
    required this.kaynaklar,
    required this.ogrenimCiktisi,
    required this.haftalik_icerik,
    this.on_kosul,
  }) : super(key: key);
  String? docID;
  final String ders_adi;
  final String ders_kodu;
  String? ogretim_elemani;
  final int akts;
  final int kredi;
  final List<Kaynaklar> kaynaklar;
  final List<OgrenimCiktisi> ogrenimCiktisi;
  final List<HaftalikIcerik> haftalik_icerik;
  final String? on_kosul;

  @override
  State<DersDetay> createState() => _DersDetayState();
}

class _DersDetayState extends State<DersDetay> {
  String? selectedOgretimElemani;

  @override
  void initState() {
    super.initState();
    selectedOgretimElemani = widget.ogretim_elemani;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.ogretim_elemani);
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.ders_adi,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabAlignment: TabAlignment.start,
            physics: BouncingScrollPhysics(),
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: "Genel Bilgiler"),
              Tab(text: "Ogrenim Çıktıları"),
              Tab(text: "Haftalık İçerik"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Genel Bilgiler
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Dersin Kodu",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.ders_kodu,
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Öğretim Elemanı",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 180,
                          height: 20,
                          child: BlocBuilder<SignInBloc, SignInState>(
                            builder: (context, state) {
                              return state.role == 'idareci'
                                  ? StreamBuilder<List<User>>(
                                stream: UserService().getTeachers(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }

                                  var teachers = snapshot.data!;
                                  var selectedOgretimElemani =
                                      widget.ogretim_elemani ?? '';

                                  // Öğretim elemanını tam isimle karşılaştırma
                                  if (selectedOgretimElemani.isNotEmpty &&
                                      teachers.where((teacher) {
                                        var fullName =
                                            "${teacher.name} ${teacher.surname}";
                                        return fullName ==
                                            selectedOgretimElemani;
                                      }).isEmpty) {
                                    print(
                                        "Seçilen öğretim elemanı listede yok, null yapılıyor");
                                    selectedOgretimElemani = '';
                                  }

                                  return DropdownButton<String>(
                                    value: selectedOgretimElemani.isEmpty
                                        ? null
                                        : selectedOgretimElemani,
                                    items: teachers.map((teacher) {
                                      var fullName =
                                          "${teacher.name} ${teacher.surname}";
                                      return DropdownMenuItem<String>(
                                        value: fullName,
                                        child: Text(fullName),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        widget.ogretim_elemani = value;
                                        Idareci(
                                            name: state.name,
                                            surname: state.surname,
                                            email: state.surname,
                                            password: state.password,
                                            role: state.role)
                                            .ogretmenAta(
                                            widget.docID, value!);
                                      });
                                    },
                                  );
                                },
                              )
                                  : Text(
                                widget.ogretim_elemani ?? '',
                                style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.9),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "AKTS",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.akts.toString(),
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Kredi",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.kredi.toString(),
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Ön Koşul",
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.redAccent.withOpacity(0.9),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            widget.on_kosul != null ? widget.on_kosul! : 'Yok',
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kaynaklar",
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...widget.kaynaklar.map((kaynak) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kaynak.kaynak_adi,
                                style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Genel Bilgileri burada Bitiyor
            OgrenimCiktilari(widget.ogrenimCiktisi,widget.docID),
            HaftalikIcerikler(widget.haftalik_icerik,widget.docID),
          ],
        ),
      ),
    );
  }
}

