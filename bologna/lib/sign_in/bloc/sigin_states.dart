class SignInState {
  String email;
  String password;
  String name;
  String surname;
  String role;
  String gorevli_oldugu_fakulte;

  SignInState({
    required this.name,
    required this.surname,
    required this.role,
    required this.email,
    required this.password,
    required this.gorevli_oldugu_fakulte
  });

  SignInState copyWith({
    String? email,
    String? password,
    String? name,
    String? surname,
    String? role,
    String? gorevli_oldugu_fakulte
  }) {
    return SignInState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
      gorevli_oldugu_fakulte: gorevli_oldugu_fakulte ?? this.gorevli_oldugu_fakulte
    );
  }
}
