import 'package:bologna/bloc/program_cikti_control_bloc/program_cikti_events.dart';
import 'package:bologna/bloc/program_cikti_control_bloc/program_control_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramCiktiInBloc extends Bloc<ProgramCiktiEvent, ProgramCiktiState> {
  ProgramCiktiInBloc() : super(ProgramCiktiState(program_cikti_var: false)) {
    on<CiktiEvent>(_programCiktiEvent);

  }

  void _programCiktiEvent(CiktiEvent event, Emitter<ProgramCiktiState> emit) {
    emit(state.copyWith(program_cikti_var: event.program_cikti_var));
  }

}
