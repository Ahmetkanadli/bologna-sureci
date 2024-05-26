class ProgramTanimState {

  bool kurulsuDuzenleme;
  bool dereceDuzenleme;
  bool dereeDuzeyDuzenleme;
  bool yeterlilikDuzenleme;
  bool gecisDuzenleme;
  bool sinavlarDuzenleme;
  bool degerlendirmeDuzenleme;
  bool calismaDuzenleme;

  ProgramTanimState({
    required this.kurulsuDuzenleme,
    required this.dereceDuzenleme,
    required this.dereeDuzeyDuzenleme,
    required this.calismaDuzenleme,
    required this.degerlendirmeDuzenleme,
    required this.sinavlarDuzenleme,
    required this.gecisDuzenleme,
    required this.yeterlilikDuzenleme,
  });

  ProgramTanimState copyWith({
    bool? kurulsuDuzenleme,
    bool? dereceDuzenleme,
    bool? dereeDuzeyDuzenleme,
    bool? yeterlilikDuzenleme,
    bool? gecisDuzenleme,
    bool? sinavlarDuzenleme,
    bool? degerlendirmeDuzenleme,
    bool? calismaDuzenleme,
  }) {
    return ProgramTanimState(
      kurulsuDuzenleme: kurulsuDuzenleme ?? this.kurulsuDuzenleme,
      dereceDuzenleme: dereceDuzenleme ?? this.dereceDuzenleme,
      dereeDuzeyDuzenleme: dereeDuzeyDuzenleme ?? this.dereeDuzeyDuzenleme,
      yeterlilikDuzenleme: yeterlilikDuzenleme ?? this.yeterlilikDuzenleme,
      gecisDuzenleme: gecisDuzenleme ?? this.gecisDuzenleme,
      sinavlarDuzenleme: sinavlarDuzenleme ?? this.sinavlarDuzenleme,
      degerlendirmeDuzenleme: degerlendirmeDuzenleme ?? this.degerlendirmeDuzenleme,
      calismaDuzenleme: calismaDuzenleme ?? this.calismaDuzenleme,
    );
  }
}
