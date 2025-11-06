import 'package:demo_registration/presentation/entity/demo_registration_request_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
    : super(
        AuthState(
          user: DemoRegistrationRequestEntity(id: "", password: "", number: "", email: ""),
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

  Future<void> submit(GlobalKey<FormState> form) async {
    final isValid = form.currentState!.validate();
    if (!isValid) return;

    form.currentState!.save();

    emit(state.copyWith(isAuthenticating: true));

    await Future.delayed(const Duration(seconds: 1));

    print("ID: ${state.user.id}");
    print("Password: ${state.user.password}");
    print("Number: ${state.user.number}");
    print("Email: ${state.user.email}");

    emit(state.copyWith(isAuthenticating: false));
  }
}
