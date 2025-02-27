import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/data/repository/products_repo.dart';
import 'package:meta/meta.dart';

part 'likes_event.dart';
part 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
  final ProductRepository productRepository;

  LikesBloc({required this.productRepository}) : super(LikesInitial()) {
    on<LoadLikedProducts>((event, emit) async {
      emit(LikedProductsLoading());

      await productRepository
          .getProductsFromIDs(event.productIDs)
          .then((value) {
        if (value.isEmpty) {
          emit(NoLikedProducts());
        } else {
          emit(LikedProductsLoaded(products: value));
        }
      });
    });
  }
}
