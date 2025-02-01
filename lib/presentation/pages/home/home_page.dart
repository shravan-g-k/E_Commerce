import 'package:e_commerce/presentation/constants/categories_data.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 10,
        right: 10,
      ),
      shrinkWrap: true,
      children: [
        ShadInput(
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
        ),
        const SizedBox(height: 10),
        Text(
          "Categories",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: 18,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final category = CategoriesData.categories[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ShadTheme.of(context).colorScheme.secondary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset(
                        category['icon'],
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${category['name']}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// m
