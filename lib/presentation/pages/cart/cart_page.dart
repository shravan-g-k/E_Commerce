import 'package:e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
import 'package:e_commerce/presentation/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.ids});
  final List<int> ids;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(LoadCartProducts(productIds: widget.ids));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartProductsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Your Cart",
                    style: ShadTheme.of(context).textTheme.h3,
                  ),
                ),
                ProductsGrid(products: state.products),
              ],
            );
          } else if (state is CartIsEmpty) {
            return Center(
              child: Text(
                "Cart is empty",
                style: ShadTheme.of(context).textTheme.h2,
              ),
            );
          } else {
            return const Center(child: LoadingBar());
          }
        },
      ),
    );
  }
}
