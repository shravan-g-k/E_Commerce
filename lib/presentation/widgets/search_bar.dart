import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  ShadInput(
          placeholder: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MingCute.search_3_fill,
                  color: ShadTheme.of(context).colorScheme.secondaryForeground,
                  size: 25,
                ),
                const SizedBox(width: 5),
                Text(
                  "Search...",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          decoration: ShadDecoration(
            color: ShadTheme.of(context).colorScheme.secondary,
          ),
        );
  }
}