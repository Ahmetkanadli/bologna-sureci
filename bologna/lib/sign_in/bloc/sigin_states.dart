class SignInState {
  String email;
  String password;
  String name;
  String surname;
  String role;

  SignInState({
    required this.name,
    required this.surname,
    required this.role,
    required this.email,
    required this.password,
  });

  SignInState copyWith({String? email, String? password, String? name, String? surname, String? role}) {
    return SignInState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      role: role ?? this.role,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
