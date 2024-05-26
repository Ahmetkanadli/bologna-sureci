// program_tanim_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'program_tanim_event.dart';
import 'program_tanim_state.dart';

class ProgramTanimInBloc extends Bloc<ProgramTanimEvent, ProgramTanimState> {
  ProgramTanimInBloc()
      : super(ProgramTanimState(
    kurulsuDuzenleme: false,
    dereceDuzenleme: false,
    dereeDuzeyDuzenleme: false,
    yeterlilikDuzenleme: false,
    gecisDuzenleme: false,
    sinavlarDuzenleme: false,
    degerlendirmeDuzenleme: false,
    calismaDuzenleme: false,
  )) {
    on<KurulusEvent>(_kurulusEvent);
    on<DereceEvent>(_dereceEvent);
    on<DereceDuzeyEvent>(_dereceDuzeyEvent);
    on<YeterlilikEvent>(_yeterlilikEvent);
    on<GecisEvent>(_gecisEvent);
    on<SinavlarEvent>(_sinavlarEvent);
    on<DegerlendirmeEvent>(_degerlendirmeEvent);
    on<CalismaEvent>(_calismaEvent);
  }

  void _kurulusEvent(KurulusEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(kurulsuDuzenleme: event.kurulsuDuzenleme));
  }

  void _dereceEvent(DereceEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(dereceDuzenleme: event.dereceDuzenleme));
  }

  void _dereceDuzeyEvent(DereceDuzeyEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(dereeDuzeyDuzenleme: event.dereeDuzeyDuzenleme));
  }

  void _yeterlilikEvent(YeterlilikEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(yeterlilikDuzenleme: event.yeterlilikDuzenleme));
  }

  void _gecisEvent(GecisEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(gecisDuzenleme: event.gecisDuzenleme));
  }

  void _sinavlarEvent(SinavlarEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(sinavlarDuzenleme: event.sinavlarDuzenleme));
  }

  void _degerlendirmeEvent(DegerlendirmeEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(degerlendirmeDuzenleme: event.degerlendirmeDuzenleme));
  }

  void _calismaEvent(CalismaEvent event, Emitter<ProgramTanimState> emit) {
    emit(state.copyWith(calismaDuzenleme: event.calismaDuzenleme));
  }

}
