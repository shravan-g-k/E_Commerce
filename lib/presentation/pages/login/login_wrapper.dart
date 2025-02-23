import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/presentation/pages/home/home.dart';
import 'package:e_commerce/presentation/pages/login/login_page.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
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
    // context.read<AuthBloc>().add(LogoutButtonPressed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UserAuthenticated) {
          return Home();
        } else if (state is UserNotAuthenticated) {
          return const LoginPage();
        } else if (state is AuthError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: LoadingBar());
        }
      },
    );
  }
}
