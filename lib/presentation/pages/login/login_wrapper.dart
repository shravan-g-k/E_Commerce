import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWrapper extends StatefulWidget {
  const LoginWrapper({super.key});

  @override
  State<LoginWrapper> createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckAuthStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return Center(
            child: GestureDetector(
              onDoubleTap: () {
                context.read<AuthBloc>().add(LogoutButtonPressed());
              },
              child: Text('Logged in as ${state.userModel.email}'),
            ),
          );
        } else if (state is UserNotAuthenticated) {
          return const LoginPage();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
