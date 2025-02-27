import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
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
              SizedBox(
                height: 300,
                width: 300,
                child: AppLogo(),
              ),
              const SizedBox(height: 20),
              ShadButton.secondary(
                size: ShadButtonSize.lg,
                icon: Icon(
                  MingCute.google_fill,
                  color: ShadTheme.of(context).colorScheme.primary,
                  size: 25,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Sign in with',
                    ),
                    Text(
                      ' Google',
                      style: TextStyle(
                        color: ShadTheme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(LoginButtonPressed());
                },
              ),
            ],
          ),
        ));
  }
}
