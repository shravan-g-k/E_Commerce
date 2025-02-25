import 'package:e_commerce/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository {
  final supabase = Supabase.instance.client;
  String get productTable => 'products';

  Future<List<ProductModel>> getProductsOfCategories(
      List<String> categories) async {
    final data = await supabase
        .from(productTable)
        .select()
        .inFilter('category', categories);
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getFeaturedProducts() async {
    final data = await supabase
        .from(productTable)
        .select()
        .or('category.eq.home-decoration,category.eq.womens-bags');

    return data.map((e) => ProductModel.fromJson(e)).toList()..shuffle();
  }

  Future<List<ProductModel>> getPremiumProducts() async {
    final data = await supabase.from(productTable).select().gt('price', 1000);

    return data.map((e) => ProductModel.fromJson(e)).toList()..shuffle();
  }

  Future<List<ProductModel>> queryProducts(String query) async {
    final data = await supabase.from(productTable).select().textSearch(
          'description',
          query,
          type: TextSearchType.websearch,
        );
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
