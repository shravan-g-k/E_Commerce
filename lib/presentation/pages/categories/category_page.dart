import 'package:e_commerce/bloc/category_bloc/category_bloc.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 9 / 15,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShadCard(
                      height: 500,
                      padding: EdgeInsets.all(10),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color:
                                    ShadTheme.of(context).colorScheme.secondary,
                              ),
                              child: Image.network(
                                product.thumbnail,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              product.title,
                              style: ShadTheme.of(context)
                                  .textTheme
                                  .muted
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Divider(
                              color: ShadTheme.of(context).colorScheme.primary,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    product.brand,
                                    style: ShadTheme.of(context)
                                        .textTheme
                                        .muted
                                        .copyWith(
                                          fontSize: 12,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  MingCute.star_fill,
                                  color: Colors.yellow.shade700,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  product.reviews.length.toString(),
                                  style: ShadTheme.of(context).textTheme.muted,
                                ),
                              ],
                            ),
                            Text(
                              "\$ ${product.price.toString()}",
                              style: ShadTheme.of(context).textTheme.muted,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: LoadingBar());
          }
        },
      ),
    );
  }
}
