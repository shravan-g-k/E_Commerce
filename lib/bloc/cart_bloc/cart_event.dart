part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class LoadCartProducts extends CartEvent {
  final List<int> productIds;
  LoadCartProducts({required this.productIds});
}

class ClearCart extends CartEvent {}
