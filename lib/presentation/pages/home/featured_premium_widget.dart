import 'package:e_commerce/bloc/home_bloc/home_bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/pages/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedPremiumWidget extends StatefulWidget {
  const FeaturedPremiumWidget({super.key});

  @override
  State<FeaturedPremiumWidget> createState() => _FeaturedPremiumWidgetState();
}

class _FeaturedPremiumWidgetState extends State<FeaturedPremiumWidget> {
  @override
  void initState() {
    context.read<HomeBloc>().add(LoadHomeProducts());
    super.initState();
  }

  Widget _buildShimmerCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 80,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Number of shimmer cards
        itemBuilder: (context, index) {
          return _buildShimmerCard(context);
        },
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
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
          width: 220,
          padding: EdgeInsets.all(15),
          title: Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: ShadTheme.of(context).textTheme.h4,
          ),
          footer: Text(
            "\$${product.price}",
            style: ShadTheme.of(context).textTheme.lead,
          ),
          child: Expanded(
            child: Center(
              child: Image.network(
                product.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: context.read<HomeBloc>(),
      builder: (context, state) {
        if (state is HomeLoaded) {
          List<ProductModel> featuredProducts = state.featuredProducts;
          List<ProductModel> premiumProducts = state.premiumProducts;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Featured",
                  style: ShadTheme.of(context).textTheme.h3,
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredProducts.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(featuredProducts[index]);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Premium",
                  style: ShadTheme.of(context).textTheme.h3,
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: premiumProducts.length,
                  itemBuilder: (context, index) {
                    return _buildProductCard(premiumProducts[index]);
                  },
                ),
              ),
            ],
          );
        } else if (state is HomeError) {
          return Center(
            child: Text("error"),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Featured",
                  style: ShadTheme.of(context).textTheme.h3,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.white12,
                child: _buildShimmerList(context),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Premium",
                  style: ShadTheme.of(context).textTheme.h3,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.black12,
                highlightColor: Colors.white12,
                child: _buildShimmerList(context),
              ),
            ],
          );
        }
      },
    );
  }
}
