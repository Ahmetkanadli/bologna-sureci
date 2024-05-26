class ProgramCiktiState {

  bool? program_cikti_var;

  ProgramCiktiState({
    required this.program_cikti_var,
  });

  ProgramCiktiState copyWith({
    bool? program_cikti_var
  }) {
    return ProgramCiktiState(
        program_cikti_var: program_cikti_var ?? this.program_cikti_var,
    );
  }
}
