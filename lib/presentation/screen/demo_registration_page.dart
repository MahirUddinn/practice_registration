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
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.08,
                  ),
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
      const CustomTextField(hintText: "id"),
      const SizedBox(height: 10),
      const CustomTextField(hintText: "password"),
      const SizedBox(height: 10),
      const CustomTextField(hintText: "number"),
      const SizedBox(height: 10),
      const CustomTextField(hintText: "email"),
      const SizedBox(height: 10),
      CustomRegisterButton(
        onSubmit: () {
          context.read<AuthCubit>().submit(_form);
        },
      ),
    ];
  }
}
