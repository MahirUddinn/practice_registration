class DemoRegistrationRequestEntity {
  final String id;
  final String password;
  final String number;
  final String email;

  DemoRegistrationRequestEntity({
    required this.id,
    required this.password,
    required this.number,
    required this.email,
  });

  DemoRegistrationRequestEntity copyWith({
    String? id,
    String? password,
    String? number,
    String? email,
  }) {
    return DemoRegistrationRequestEntity(
      id: id ?? this.id,
      password: password ?? this.password,
      number: number ?? this.number,
      email: email ?? this.email,
    );
  }
}
