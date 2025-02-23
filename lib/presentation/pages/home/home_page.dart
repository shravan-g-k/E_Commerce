import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:e_commerce/presentation/pages/home/address_dialog.dart';
import 'package:e_commerce/presentation/pages/home/categories_widget.dart';
import 'package:e_commerce/presentation/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<AuthBloc>().user;
    return ListView(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 10,
        right: 10,
      ),
      shrinkWrap: true,
      children: [
        Center(
          child: Text(
            "Delivery Address",
            style: ShadTheme.of(context).textTheme.muted,
          ),
        ),
        InkWell(
          onTap: () {
            showShadDialog(
              context: context,
              builder: (context) {
                return const AddressDialog();
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                user.address == null ? "Add address" : user.address!,
                style: ShadTheme.of(context).textTheme.large,
              ),
            ),
          ),
        ),
        AppSearchBar(),
        const SizedBox(height: 10),
        CategoriesWidget(),
      ],
    );
  }
}
