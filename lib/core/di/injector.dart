import 'package:get_it/get_it.dart';
import '../../features/Home/data/datasource/product_remote_datasource.dart';
import '../../features/Home/data/repositories/product_repository_impl.dart';
import '../../features/Home/domain/repositories/product_repository.dart';
import '../../features/Home/domain/usecase/get_products.dart';
import '../../features/Home/presentation/cubit/product_cubit.dart';
import '../../features/auth/data/datasource/auth_local_storage.dart';
import '../../features/auth/data/datasource/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';



final sl = GetIt.instance;

Future<void> init() async {

  /// DataSource
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSource(),
  );

  /// Repository
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
  );

  /// UseCase
  sl.registerLazySingleton<GetProducts>(
        () => GetProducts(sl()),
  );

  /// Cubit  ✅ VERY IMPORTANT
  sl.registerFactory<ProductCubit>(
        () => ProductCubit(sl()),
  );



  /// DATA SOURCE
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSource(),
  );

  /// REPOSITORY
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  /// USECASE
  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(sl()),
  );

  /// CUBIT
  sl.registerFactory<AuthCubit>(
        () => AuthCubit(sl(), sl()),
  );

  sl.registerLazySingleton<AuthLocalStorage>(
        () => AuthLocalStorage(),
  );
}