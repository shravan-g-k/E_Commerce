part of 'likes_bloc.dart';

@immutable
sealed class LikesState {}

class LikesInitial extends LikesState {}

class LikedProductsLoading extends LikesState {}

class LikedProductsLoaded extends LikesState {
  final List<ProductModel> products;

  LikedProductsLoaded({required this.products});

}

class NoLikedProducts extends LikesState {}