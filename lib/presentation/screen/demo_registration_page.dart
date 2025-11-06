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
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Color(0xFFEDEDED),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08,
                  vertical: 24,
                ),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: _buildInputForms(context)
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  another(){
    return Column(children: [
      TextFormField(),
      SizedBox(height: 10,),
      TextFormField(),
      SizedBox(height: 10,),
      ElevatedButton(onPressed: (){}, child: Text("GPPpp"))
    ],);
  }

  Widget _buildInputForms(BuildContext context) {
    return Column(
      children: [
        CustomTextField(hintText: "id"),
        SizedBox(height: 10),
        CustomTextField(hintText: "password"),
        SizedBox(height: 10),
        CustomTextField(hintText: "number"),
        SizedBox(height: 10),
        CustomTextField(hintText: "email"),
        SizedBox(height: 10),
        CustomRegisterButton(
          onSubmit: () {
            context.read<AuthCubit>().submit(_form);
          },
        ),
      ],
    );
  }
}
