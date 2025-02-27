import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:e_commerce/presentation/pages/home/address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        UserModel user = context.read<AuthBloc>().user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Profile",
                style: ShadTheme.of(context).textTheme.h3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Your email address",
                style: ShadTheme.of(context).textTheme.muted,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                user.email,
                style: ShadTheme.of(context).textTheme.h4,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Your address",
                    style: ShadTheme.of(context).textTheme.lead,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10),
                  child: ShadButton.ghost(
                    icon: Icon(
                      MingCute.edit_line,
                      size: 25,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AddressDialog();
                        },
                      );
                    },
                    child: const Text("Edit"),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                user.address == null ? "Add address" : user.address!,
                style: ShadTheme.of(context).textTheme.large,
              ),
            ),
            Spacer(),
            ShadButton.ghost(
              icon: Icon(
                Icons.logout,
                size: 25,
              ),
              child: const Text("Logout"),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutButtonPressed());
              },
            ),
          ],
        );
      },
    );
  }
}
