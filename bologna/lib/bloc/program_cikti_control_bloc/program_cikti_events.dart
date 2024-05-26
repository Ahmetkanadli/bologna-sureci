abstract class ProgramCiktiEvent {
  const ProgramCiktiEvent();
}

class CiktiEvent extends ProgramCiktiEvent {
  final bool program_cikti_var;
  const CiktiEvent(this.program_cikti_var);
}
