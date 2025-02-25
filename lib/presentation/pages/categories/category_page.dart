import 'package:e_commerce/bloc/category_bloc/category_bloc.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
import 'package:e_commerce/presentation/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category, required this.title});
  final List<String> category;
  final String title;
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(LoadCategoryProducts(widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryProductsLoaded) {
            return ProductsGrid(products: state.products);
          } else {
            return const Center(child: LoadingBar());
          }
        },
      ),
    );
  }
}
