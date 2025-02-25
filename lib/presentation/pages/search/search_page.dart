import 'package:e_commerce/bloc/search_bloc/search_bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
import 'package:e_commerce/presentation/widgets/products_grid.dart';
import 'package:e_commerce/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.query});
  final String query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    context.read<SearchBloc>().add(SearchProducts(widget.query));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchProductsLoaded) {
            List<ProductModel> products = state.products;
            String query = state.query;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppSearchBar(
                    onSubmitted: (query) {
                      context.read<SearchBloc>().add(
                            SearchProducts(query),
                          );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    query.toUpperCase(),
                    style: ShadTheme.of(context).textTheme.h3,
                  ),
                ),
                Expanded(
                  child: ProductsGrid(products: products),
                ),
              ],
            );
          } else if (state is SearchProductsNotFound) {
            return Center(
              child: Text(
                "No products",
                style: ShadTheme.of(context).textTheme.h1,
              ),
            );
          } else {
            return Center(
              child: LoadingBar(),
            );
          }
        },
      ),
    );
  }
}
