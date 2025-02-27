part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class LoadingCartProducts extends CartState {}

final class CartProductsLoaded extends CartState {
  final List<ProductModel> products;
  CartProductsLoaded({required this.products});
}

final class CartIsEmpty extends CartState {}