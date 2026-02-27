import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';


class ProductRemoteDataSource {

  Future<List<ProductModel>> getProducts({String? category}) async {
    final String url;

    if (category == null || category == "all") {
      url = 'https://fakestoreapi.com/products';
    } else {
      url =
      'https://fakestoreapi.com/products/category/${Uri.encodeComponent(category)}';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}