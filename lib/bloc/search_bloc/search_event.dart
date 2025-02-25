part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchProducts extends SearchEvent {
  final String query;
  SearchProducts(this.query);
}