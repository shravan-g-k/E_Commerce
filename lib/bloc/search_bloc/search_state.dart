part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchingProducts extends SearchState {}

final class SearchProductsLoaded extends SearchState {
  final String query;
  final List<ProductModel> products;
  SearchProductsLoaded({required this.query, required this.products});
}

final class SearchProductsNotFound extends SearchState{}
