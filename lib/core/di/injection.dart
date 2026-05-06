import 'package:get_it/get_it.dart';
import '../../features/products/data/datasources/product_remote_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/add_product.dart';
import '../../features/products/domain/usecases/delete_product.dart';
import '../../features/products/domain/usecases/get_product.dart';
import '../../features/products/presentation/state/product_cubit.dart';
import '../networks/api_service.dart';
import '../networks/dio_client.dart';

final sl = GetIt.instance;

void setupDependencies() {
  sl.registerLazySingleton(() => DioClient.create());
  sl.registerLazySingleton(() => ApiService(sl()));

  sl.registerLazySingleton<ProductRemoteDatasource>(
        () => ProductRemoteDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => AddProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));

  sl.registerFactory(
        () => ProductCubit(
      getProducts: sl(),
      addProduct: sl(),
      deleteProduct: sl(),
    ),
  );
}