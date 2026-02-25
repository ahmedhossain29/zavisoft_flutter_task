import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';


class ProductRemoteDataSource {

  Future<List<ProductModel>> getProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}