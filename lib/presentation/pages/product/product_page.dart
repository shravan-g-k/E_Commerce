import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:e_commerce/presentation/pages/product/review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late bool liked;
  late bool inCart;

  @override
  void initState() {
    super.initState();
    liked = context.read<AuthBloc>().user.likes.contains(widget.product.id);
    inCart = context.read<AuthBloc>().user.cart.contains(widget.product.id);
  }

  void toggleLike() {
    UserModel user = context.read<AuthBloc>().user;
    if (user.likes.contains(widget.product.id)) {
      context.read<AuthBloc>().add(
            UpdateUser(
              user: user.copyWith(likes: user.likes..remove(widget.product.id)),
            ),
          );
    } else {
      context.read<AuthBloc>().add(
            UpdateUser(
              user: user.copyWith(likes: [...user.likes, widget.product.id]),
            ),
          );
    }
    setState(() {
      liked = !liked;
    });
  }

  void toggleCart() {
    UserModel user = context.read<AuthBloc>().user;
    if (user.cart.contains(widget.product.id)) {
      context.read<AuthBloc>().add(
            UpdateUser(
              user: user.copyWith(cart: user.cart..remove(widget.product.id)),
            ),
          );
    } else {
      context.read<AuthBloc>().add(
            UpdateUser(
              user: user.copyWith(cart: [...user.cart, widget.product.id]),
            ),
          );
    }
    setState(() {
      inCart = !inCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 10,
          right: 10,
        ),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 200,
            child: CarouselView(
              itemExtent: widget.product.images.length != 1
                  ? MediaQuery.of(context).size.width - 50
                  : MediaQuery.of(context).size.width,
              children: widget.product.images
                  .map(
                    (e) => Container(
                      color: ShadTheme.of(context).colorScheme.secondary,
                      child: CachedNetworkImage(
                        imageUrl: e,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.product.title,
            style: ShadTheme.of(context).textTheme.h3,
          ),
          Row(
            children: [
              Text(
                'by',
                style: ShadTheme.of(context).textTheme.muted,
              ),
              const SizedBox(width: 10),
              Text(
                widget.product.brand,
                style: ShadTheme.of(context).textTheme.lead,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "\$ ${widget.product.price}",
            style: ShadTheme.of(context).textTheme.h4,
          ),
          Divider(
            color: ShadTheme.of(context).colorScheme.primary,
          ),
          Text(
            widget.product.description,
            style: ShadTheme.of(context).textTheme.list,
          ),
          const SizedBox(height: 10),
          Text("Reviews", style: ShadTheme.of(context).textTheme.h3),
          const SizedBox(height: 10),
          Column(
            children: widget.product.reviews
                .map(
                  (e) => ReviewWidget(review: e),
                )
                .toList(),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 0,
        ),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ShadTheme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: ShadTheme.of(context).colorScheme.primary,
              spreadRadius: 0.1,
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ShadButton(
                onPressed: toggleCart,
                backgroundColor: ShadTheme.of(context).colorScheme.accent,
                size: ShadButtonSize.lg,
                icon: Icon(
                  MingCute.shopping_cart_2_fill,
                  color: ShadTheme.of(context).colorScheme.primary,
                  size: 25,
                ),
                child: Text(
                  inCart ? "Remove from cart" : "Add to cart",
                  style: ShadTheme.of(context).textTheme.small,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                toggleLike();
              },
              style: IconButton.styleFrom(
                backgroundColor: ShadTheme.of(context).colorScheme.secondary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              icon: Icon(
                liked ? MingCute.heart_fill : MingCute.heart_line,
                color: ShadTheme.of(context).colorScheme.primary,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
