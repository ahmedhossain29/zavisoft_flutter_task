import 'package:get_it/get_it.dart';

import '../../features/Home/data/datasource/product_remote_datasource.dart';
import '../../features/Home/data/repositories/product_repository_impl.dart';
import '../../features/Home/domain/repositories/product_repository.dart';
import '../../features/Home/domain/usecase/get_products.dart';
import '../../features/Home/presentation/cubit/product_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => ProductRemoteDataSource());

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProducts(sl()));

  sl.registerFactory(
        () => ProductCubit(sl()),
  );
}