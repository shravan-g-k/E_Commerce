import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/data/repository/products_repo.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ProductRepository productRepository;
  CartBloc({required this.productRepository}) : super(CartInitial()) {
    on<LoadCartProducts>((event, emit) async {
      emit(LoadingCartProducts());
      await productRepository
          .getProductsFromIDs(event.productIds)
          .then((value) {
        if (value.isEmpty) {
          emit(CartIsEmpty());
        } else {
          emit(CartProductsLoaded(products: value));
        }
      });
    });
  }
}
