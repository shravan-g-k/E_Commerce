import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/data/repository/products_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository productRepository;
  HomeBloc(this.productRepository) : super(HomeLoading()) {
    on<LoadHomeProducts>((event, emit) async {
      emit(HomeLoading());
      List<ProductModel> featuredProducts = [];
      List<ProductModel> premiumProducts = [];
      await productRepository.getFeaturedProducts().then((value) {
        featuredProducts = value;
      });
      await productRepository.getPremiumProducts().then((value) {
        premiumProducts = value;
      });
      emit(
        HomeLoaded(
          premiumProducts: premiumProducts,
          featuredProducts: featuredProducts,
        ),
      );
    });
  }
}
