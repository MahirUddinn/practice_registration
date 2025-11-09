import 'package:demo_registration/presentation/bloc/auth_cubit.dart';
import 'package:demo_registration/presentation/screen/widget/custom_register_button.dart';
import 'package:demo_registration/presentation/screen/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoRegistrationPage extends StatelessWidget {
  DemoRegistrationPage({super.key});

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Center(
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildInputForms(context),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildInputForms(BuildContext context) {
    return [
      CustomTextField(
        hintText: "Enter User ID",
        iconData: Icons.person_outline,
        isObscure: false,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input!.isEmpty) {
            return "This field can't be empty";
          }
          if (input.length < 4) {
            return "User ID must be at least 4 characters";
          }
          if (int.tryParse(input) == null) {
            return "User ID must be numeric";
          }
          return null;
        },
        onSaved: (newValue) {
          context.read<AuthCubit>().updateID(newValue ?? "");
        },
      ),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: "Enter Password",
        iconData: Icons.lock_outline,
        isObscure: true,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input!.isEmpty) {
            return "This field can't be empty";
          }
          if (input.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
        onSaved: (newValue) {
          context.read<AuthCubit>().updatePassword(newValue ?? "");
        },
      ),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: "Enter Phone Number",
        iconData: Icons.phone_outlined,
        isObscure: false,
        keyboardType: TextInputType.number,
        validator: (input) {
          if (input!.isEmpty) {
            return "This field can't be empty";
          }
          if (int.tryParse(input) == null) {
            return "Phone number must contain digits only";
          }
          if (input.length < 10 || input.length > 15) {
            return "Phone number must be between 10 and 15 digits";
          }
          return null;
        },
        onSaved: (newValue) {
          context.read<AuthCubit>().updatePhoneNumber(newValue ?? "");
        },
      ),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: "Enter Email",
        iconData: Icons.email_outlined,
        isObscure: false,
        keyboardType: TextInputType.emailAddress,
        validator: (input) {
          if (input!.isEmpty) {
            return "This field can't be empty";
          }
          if (!input.contains("@") ||
              !input.contains(".") ||
              input.contains(" ") ||
              input.indexOf("@") > input.indexOf(".")) {
            return "Enter a valid email address";
          }
          return null;
        },
        onSaved: (newValue) {
          context.read<AuthCubit>().updateEmail(newValue ?? "");
        },
      ),
      const SizedBox(height: 10),
      CustomRegisterButton(
        onSubmit: () {
          context.read<AuthCubit>().submit(_form);
        },
      ),
    ];
  }
}
