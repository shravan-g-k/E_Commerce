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
}
