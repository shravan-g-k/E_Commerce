import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/bloc/category_bloc/category_bloc.dart';
import 'package:e_commerce/bloc/payment_bloc/payment_bloc.dart';
import 'package:e_commerce/bloc/search_bloc/search_bloc.dart';
import 'package:e_commerce/data/repository/auth_repo.dart';
import 'package:e_commerce/data/repository/payment_repo.dart';
import 'package:e_commerce/data/repository/products_repo.dart';
import 'package:e_commerce/presentation/pages/login/login_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const ECommerce());
}

class ECommerce extends StatelessWidget {
  const ECommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => ProductRepository()),
        RepositoryProvider(create: (context) => PaymentRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(context.read<ProductRepository>()),
          ),
          BlocProvider(
            create: (context) => SearchBloc(context.read<ProductRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                PaymentBloc(context.read<PaymentRepository>()),
          ),
          BlocProvider(
            create: (context) => CartBloc(
              productRepository: context.read<ProductRepository>(),
            ),
          ),
        ],
        child: ShadApp.material(
          darkTheme: ShadThemeData(
            brightness: Brightness.dark,
            colorScheme: const ShadBlueColorScheme.dark(),
          ),
          home: LoginWrapper(),
        ),
      ),
    );
  }
}
