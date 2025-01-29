import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 300, width: 300, child: Placeholder()),
              const SizedBox(height: 20),
              ShadButton(
                child: const Text('Sign in with Google'),
                onPressed: () {
                  context.read<AuthBloc>().add(LoginButtonPressed());
                },
              ),
            ],
          ),
        ));
  }
}
