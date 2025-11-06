import 'package:demo_registration/presentation/bloc/auth_cubit.dart';
import 'package:demo_registration/presentation/screen/demo_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoRegistration extends StatelessWidget {
  const DemoRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Demo Registration',
        home: BlocProvider(
          create: (context) => AuthCubit(),
          child: DemoRegistrationPage(),
        )
    );
  }
}
