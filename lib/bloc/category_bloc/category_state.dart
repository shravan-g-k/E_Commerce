part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryProductsLoaded extends CategoryState {
  final List<ProductModel> products;

  CategoryProductsLoaded({required this.products});
}