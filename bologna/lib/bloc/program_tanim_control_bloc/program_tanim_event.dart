abstract class
ProgramTanimEvent {
  const ProgramTanimEvent();
}

class KurulusEvent extends ProgramTanimEvent {
  final bool kurulsuDuzenleme;
  KurulusEvent(this.kurulsuDuzenleme);
}

class DereceEvent extends ProgramTanimEvent {
  final bool dereceDuzenleme;
  DereceEvent(this.dereceDuzenleme);
}

class DereceDuzeyEvent extends ProgramTanimEvent {
  final bool dereeDuzeyDuzenleme;
   DereceDuzeyEvent(this.dereeDuzeyDuzenleme);
}

class YeterlilikEvent extends ProgramTanimEvent {
  final bool yeterlilikDuzenleme;
  YeterlilikEvent(this.yeterlilikDuzenleme);
}

class GecisEvent extends ProgramTanimEvent {
  final bool gecisDuzenleme;
  GecisEvent(this.gecisDuzenleme);
}

class SinavlarEvent extends ProgramTanimEvent {
  final bool sinavlarDuzenleme;
  SinavlarEvent(this.sinavlarDuzenleme);
}

class DegerlendirmeEvent extends ProgramTanimEvent {
  final bool degerlendirmeDuzenleme;
  DegerlendirmeEvent(this.degerlendirmeDuzenleme);
}

class CalismaEvent extends ProgramTanimEvent {
  final bool calismaDuzenleme;
  CalismaEvent(this.calismaDuzenleme);
}

class TanimEvent extends ProgramTanimEvent {
  final bool tanimDuzenleme;
  const TanimEvent(this.tanimDuzenleme);
}

