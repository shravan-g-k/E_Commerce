import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/data/repository/products_repo.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository productRepository;
  SearchBloc(this.productRepository) : super(SearchInitial()) {
    on<SearchProducts>((event, emit) async {
      emit(SearchingProducts());
      await productRepository.queryProducts(event.query).then((value) {
        if (value.isEmpty) {
          emit(SearchProductsNotFound());
        } else {
          emit(
            SearchProductsLoaded(
              products: value,
              query: event.query,
            ),
          );
        }
      });
    });
  }
}
