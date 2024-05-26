abstract class SignInEvent {
  const SignInEvent();
}

class EmailEvent extends SignInEvent {
  final String email;
  const EmailEvent(this.email);
}

class PasswordEvent extends SignInEvent {
  final String password;
  const PasswordEvent(this.password);
}

class NameEvent extends SignInEvent {
  final String name;
  const NameEvent(this.name);
}

class SurnameEvent extends SignInEvent {
  final String surname;
  const SurnameEvent(this.surname);
}

class RoleEvent extends SignInEvent {
  final String role;
  const RoleEvent(this.role);
}

class GorevliOlduguFakulteEvent extends SignInEvent {
  final String gorevli_oldugu_fakulte;
  const GorevliOlduguFakulteEvent(this.gorevli_oldugu_fakulte);
}
