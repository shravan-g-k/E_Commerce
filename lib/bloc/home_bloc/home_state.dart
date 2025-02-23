part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<ProductModel> featuredProducts;
  final List<ProductModel> premiumProducts;

  HomeLoaded({required this.premiumProducts, required this.featuredProducts});
}

final class HomeError extends HomeState {}
