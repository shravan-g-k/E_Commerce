import 'package:e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce/bloc/payment_bloc/payment_bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/presentation/widgets/loading_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
  }

  void _showSnackAndPop(BuildContext context, String message,
      {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = context.read<CartBloc>().cartProducts;
    return Scaffold(
      body: BlocConsumer<PaymentBloc, PaymentBlocState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            _showSnackAndPop(context, "Payment successful!");
          }
          if (state is PaymentError) {
            _showSnackAndPop(context, state.message, error: true);
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: LoadingBar());
          }
          final totalSum =
              products.fold<double>(0, (sum, product) => sum + product.price);

          return Column(
            children: [
              // Header with Order title
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: ShadTheme.of(context).colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Order",
                      style: ShadTheme.of(context).textTheme.h2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),

              // Cart products list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ShadTheme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ShadTheme.of(context)
                              .colorScheme
                              .secondary
                              .withAlpha(51),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Product image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.thumbnail,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 80,
                                  height: 80,
                                  color: ShadTheme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withAlpha(25),
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: ShadTheme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Product details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: ShadTheme.of(context)
                                      .textTheme
                                      .large
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.brand,
                                  style: ShadTheme.of(context)
                                      .textTheme
                                      .muted
                                      .copyWith(
                                        color: ShadTheme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: ShadTheme.of(context)
                                      .textTheme
                                      .large
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ShadTheme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Total sum and checkout button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ShadTheme.of(context).colorScheme.background,
                  border: Border(
                    top: BorderSide(
                      color: ShadTheme.of(context)
                          .colorScheme
                          .secondary
                          .withAlpha(51),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // Total sum
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: ShadTheme.of(context).textTheme.h4.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          '\$${totalSum.toStringAsFixed(2)}',
                          style: ShadTheme.of(context).textTheme.h4.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    ShadTheme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Checkout button
                    Center(
                      child: SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<PaymentBloc>().add(PaymentInitiated(
                                  totalSum,
                                  "USD",
                                  "order",
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ShadTheme.of(context).colorScheme.primary,
                            foregroundColor:
                                ShadTheme.of(context).colorScheme.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Checkout',
                            style:
                                ShadTheme.of(context).textTheme.large.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ShadTheme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
