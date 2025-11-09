import 'package:demo_registration/presentation/bloc/auth_cubit.dart';
import 'package:demo_registration/presentation/screen/widget/custom_register_button.dart';
import 'package:demo_registration/presentation/screen/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoRegistrationPage extends StatelessWidget {
  DemoRegistrationPage({super.key});

  final _form = GlobalKey<FormState>();

  void onSaved(BuildContext context, String? newValue, String type) {
    if (newValue == null) return;
    switch (type) {
      case "id":
        context.read<AuthCubit>().updateID(newValue);
        break;
      case "password":
        context.read<AuthCubit>().updatePassword(newValue);
        break;
      case "number":
        context.read<AuthCubit>().updatePhoneNumber(newValue);
        break;
      case "email":
        context.read<AuthCubit>().updateEmail(newValue);
        break;
    }
  }

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
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildInputForms(context, state),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildInputForms(BuildContext context, AuthState state) {
    return [
      CustomTextField(
        hintText: "Enter User ID",
        iconData: Icons.person_outline,
        isObscure: false,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
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
          onSaved(context, newValue, "id");
        },
      ),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: "Enter Password",
        iconData: Icons.lock_outline,
        isObscure: true,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          if (input.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
        onSaved: (newValue) {
          onSaved(context, newValue, "password");
        },
      ),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: "Enter Phone Number",
        iconData: Icons.phone_outlined,
        isObscure: false,
        keyboardType: TextInputType.number,
        validator: (input) {
          if (input == null || input.isEmpty) {
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
          onSaved(context, newValue, "number");
        },
      ),
      const SizedBox(height: 10),
      CustomTextField(
        hintText: "Enter Email",
        iconData: Icons.email_outlined,
        isObscure: false,
        keyboardType: TextInputType.emailAddress,
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "This field can't be empty";
          }
          if (!input.contains("@") ||
              !input.contains(".") ||
              input.contains(" ") ||
              input.indexOf("@") > input.lastIndexOf(".")) {
            return "Enter a valid email address";
          }
          return null;
        },
        onSaved: (newValue) {
          onSaved(context, newValue, "email");
        },
      ),
      const SizedBox(height: 20),

      if (state.isAuthenticating)
        Center(child: CircularProgressIndicator())
      else
        CustomRegisterButton(
          text: "Register",
          onSubmit: () {
            final isValid = _form.currentState?.validate() ?? false;
            if (!isValid) return;
            _form.currentState?.save();
            context.read<AuthCubit>().submit();
          },
        ),
    ];
  }
}
