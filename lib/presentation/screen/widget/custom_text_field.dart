import 'package:demo_registration/presentation/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final String hint = hintText.toLowerCase();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: hint == "password",
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: hint == "id"
                  ? "Enter User ID"
                  : hint == "password"
                  ? "Enter Password"
                  : hint == "number"
                  ? "Enter Phone Number"
                  : hint == "email"
                  ? "Enter Email"
                  : "Invalid Form",
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  hint == "id"
                      ? Icons.person_outline
                      : hint == "password"
                      ? Icons.lock_outline
                      : hint == "number"
                      ? Icons.phone_outlined
                      : hint == "email"
                      ? Icons.email_outlined
                      : Icons.disabled_by_default_outlined,
                  color: const Color(0xFF020202),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
            ),
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            keyboardType: hint == "number"
                ? TextInputType.number
                : hint == "email"
                ? TextInputType.emailAddress
                : TextInputType.text,
            validator: (value) {
              final input = value?.trim() ?? '';

              if (input.isEmpty) {
                return "This field can't be empty";
              }

              if (hint == "id") {
                if (input.length < 4) {
                  return "User ID must be at least 4 characters";
                }
                if (int.tryParse(input) == null) {
                  return "User ID must be numeric";
                }
              }

              if (hint == "password") {
                if (input.length < 6) {
                  return "Password must be at least 6 characters";
                }
              }

              if (hint == "number") {
                if (int.tryParse(input) == null) {
                  return "Phone number must contain digits only";
                }
                if (input.length < 10 || input.length > 15) {
                  return "Phone number must be between 10 and 15 digits";
                }
              }

              if (hint == "email") {
                if (!input.contains("@") ||
                    !input.contains(".") ||
                    input.contains(" ") ||
                    input.indexOf("@") > input.indexOf(".")) {
                  return "Enter a valid email address";
                }
              }

              return null;
            },
            onSaved: (newValue) {
              final cubit = context.read<AuthCubit>();
              final text = newValue ?? "";
              if (hint == "id") cubit.updateID(text);
              if (hint == "password") cubit.updatePassword(text);
              if (hint == "number") cubit.updatePhoneNumber(text);
              if (hint == "email") cubit.updateEmail(text);
            },
          );
        },
      ),
    );
  }
}
