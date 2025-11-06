part of 'auth_cubit.dart';

class AuthState {
  DemoRegistrationRequestEntity user;
  bool isAuthenticating;

  AuthState({required this.user, required this.isAuthenticating});

  AuthState copyWith({DemoRegistrationRequestEntity? user, bool? isAuthenticating}) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
    );
  }
}
