import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecase/get_products.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;

  /// 🔥 Category-wise cache
  final Map<String, List<Product>> _cache = {};

  ProductCubit(this.getProducts) : super(ProductInitial());

  Future<void> fetchProducts(String category) async {
    /// If already cached → emit directly
    if (_cache.containsKey(category)) {
      emit(ProductLoaded(_cache[category]!));
      return;
    }

    emit(ProductLoading());

    try {
      final products = await getProducts(category: category);

      /// store in cache
      _cache[category] = products;

      emit(ProductLoaded(products));
    } catch (_) {
      emit(ProductError());
    }
  }

  /// Pull to refresh force reload
  Future<void> refresh(String category) async {
    try {
      final products = await getProducts(category: category);
      _cache[category] = products;
      emit(ProductLoaded(products));
    } catch (_) {
      emit(ProductError());
    }
  }
}