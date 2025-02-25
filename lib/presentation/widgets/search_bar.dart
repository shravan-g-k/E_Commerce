import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key, required this.onSubmitted});
  final void Function(String) onSubmitted;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: controller,
      onSubmitted: widget.onSubmitted,
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
