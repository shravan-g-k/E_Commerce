import 'package:e_commerce/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: ShadTheme.of(context).colorScheme.primary,
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
      body: HomePage(),
    );
  }
}
