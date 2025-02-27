import 'package:e_commerce/bloc/likes_bloc/likes_bloc.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
import 'package:e_commerce/presentation/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({super.key, required this.ids});
  final List<int> ids;
  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  void initState() {
    context.read<LikesBloc>().add(LoadLikedProducts(productIDs: widget.ids));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikesBloc, LikesState>(
        builder: (context, state) {
          if (state is LikedProductsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Your Likes",
                    style: ShadTheme.of(context).textTheme.h3,
                  ),
                ),
                ProductsGrid(products: state.products),
              ],
            );
          } else if (state is NoLikedProducts) {
            return Center(
              child: Text(
                "No Liked Products",
                style: ShadTheme.of(context).textTheme.h2,
              ),
            );
          } else {
            return const Center(child: LoadingBar());
          }
        },
    );
  }
}
