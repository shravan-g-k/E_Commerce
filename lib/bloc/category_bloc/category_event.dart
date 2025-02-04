part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class LoadCategoryProducts extends CategoryEvent {
  final List<String> category;
  LoadCategoryProducts(this.category);
} 
