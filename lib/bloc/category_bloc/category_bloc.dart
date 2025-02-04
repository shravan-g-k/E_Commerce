import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/data/repository/products_repo.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRepository productRepository;
  CategoryBloc(this.productRepository) : super(CategoryLoading()) {
    on<LoadCategoryProducts>((event, emit) async {
      emit(CategoryLoading());
      final value =
          await productRepository.getProductsOfCategories(event.category);
      emit(CategoryProductsLoaded(products: value));
    });
  }
}
