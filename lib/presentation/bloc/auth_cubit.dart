import 'package:demo_registration/entity/demo_registration_request_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
    : super(
        AuthState(
          user: DemoRegistrationRequestEntity(
            id: "",
            password: "",
            number: "",
            email: "",
          ),
          isAuthenticating: false,
        ),
      );

  void updateID(String value) =>
      emit(state.copyWith(user: state.user.copyWith(id: value)));

  void updatePassword(String value) =>
      emit(state.copyWith(user: state.user.copyWith(password: value)));

  void updatePhoneNumber(String value) =>
      emit(state.copyWith(user: state.user.copyWith(number: value)));

  void updateEmail(String value) =>
      emit(state.copyWith(user: state.user.copyWith(email: value)));

  Future<void> submit() async {
    emit(state.copyWith(isAuthenticating: true));
    await Future.delayed(const Duration(seconds: 2));
    print(state.user.id);
    print(state.user.password);
    print(state.user.email);
    print(state.user.number);
    emit(state.copyWith(isAuthenticating: false));
  }
}
