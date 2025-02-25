import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/pages/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9 / 15,
        ),
        itemCount: products.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      product: product,
                    ),
                  ),
                );
              },
              child: ShadCard(
                height: 500,
                padding: EdgeInsets.all(10),
                border: Border.all(
                  color: ShadTheme.of(context).colorScheme.background,
                ),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: ShadTheme.of(context).colorScheme.secondary,
                        ),
                        child: Image.network(
                          product.thumbnail,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        product.title,
                        style: ShadTheme.of(context).textTheme.muted.copyWith(
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
            ),
          );
        });
  }
}
