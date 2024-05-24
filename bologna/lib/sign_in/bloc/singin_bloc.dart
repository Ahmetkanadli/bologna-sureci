import 'package:bologna/sign_in/bloc/sigin_states.dart';
import 'package:bologna/sign_in/bloc/signin_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState(role: '', name: '', surname: '', email: '', password: '')) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<NameEvent>(_nameEvent);
    on<SurnameEvent>(_surnameEvent);
    on<RoleEvent>(_roleEvent);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _nameEvent(NameEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _surnameEvent(SurnameEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(surname: event.surname));
  }

  void _roleEvent(RoleEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(role: event.role));
  }
}
