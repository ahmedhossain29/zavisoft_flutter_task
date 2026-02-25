import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_products.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts getProducts;

  ProductCubit(this.getProducts) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());

    try {
      final products = await getProducts();
      emit(ProductLoaded(products));
    } catch (_) {
      emit(ProductError());
    }
  }
}