import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/bloc/likes_bloc/likes_bloc.dart';
import 'package:e_commerce/data/repository/products_repo.dart';
import 'package:e_commerce/presentation/pages/cart/cart_page.dart';
import 'package:e_commerce/presentation/pages/home/home_page.dart';
import 'package:e_commerce/presentation/pages/likes/likes_page.dart';
import 'package:e_commerce/utils/home_pages_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomePagesEnum homePagesEnum;

  @override
  void initState() {
    homePagesEnum = HomePagesEnum.home;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().user;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homePagesEnum.index,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: ShadTheme.of(context).colorScheme.primary,
        onTap: (index) {
          setState(() {
            homePagesEnum = HomePagesEnum.values[index];
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(MingCute.home_4_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MingCute.shopping_cart_2_fill),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(MingCute.heart_fill),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(MingCute.badge_fill),
            label: 'Profile',
          ),
        ],
      ),
      body: Builder(builder: (context) {
        switch (homePagesEnum) {
          case HomePagesEnum.home:
            return const HomePage();
          case HomePagesEnum.cart:
            return BlocProvider<CartBloc>(
              create: (context) => CartBloc(
                productRepository: context.read<ProductRepository>(),
              ),
              child: CartPage(
                ids: user.cart,
              ),
            );
          case HomePagesEnum.likes:
            return BlocProvider(
              create: (context) => LikesBloc(
                productRepository: context.read<ProductRepository>(),
              ),
              child: LikesPage(
                ids: user.likes,
              ),
            );
          case HomePagesEnum.profile:
            return const Center(
              child: Text('Profile'),
            );
        }
      }),
    );
  }
}
