import 'package:get_it/get_it.dart';
import 'package:shop_app/data/data_sources/product_remote_data_sources.dart';
import 'package:shop_app/data/repositories/product_repository.dart';
import 'package:shop_app/domain/repository/product_repository_interface.dart';
import 'package:shop_app/domain/usecases/get_all_product.dart';
import 'package:shop_app/services/firestore.dart';

final GetIt getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<FireStore>(() => FireStore());

  getItInstance.registerLazySingleton<IProductRemoteDataSources>(
      () => ProductRemoteDataSourcesImpl(getItInstance()));

  getItInstance.registerLazySingleton<IProductRepository>(
      () => ProductRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<GetAllProduct>(
      () => GetAllProduct(getItInstance()));
}
