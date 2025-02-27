part of 'likes_bloc.dart';

@immutable
sealed class LikesEvent {}

class LoadLikedProducts extends LikesEvent {
  final List<int> productIDs;

  LoadLikedProducts({required this.productIDs});
}
