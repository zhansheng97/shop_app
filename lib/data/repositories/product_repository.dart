import 'package:shop_app/data/data_sources/product_remote_data_sources.dart';
import 'package:shop_app/domain/entity/product_entity.dart';
import 'package:shop_app/domain/entity/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/domain/repository/product_repository_interface.dart';

class ProductRepositoryImpl extends IProductRepository {
  final IProductRemoteDataSources productRemoteDataSources;

  ProductRepositoryImpl(this.productRemoteDataSources);

  @override
  Future<Either<AppError, List<ProductEntity>>> getAllProduct() async {
    try {
      List<ProductEntity> allProduct =
          await productRemoteDataSources.getAllProducts();
      // print(allProduct);
      return Right(allProduct);
    } catch (e) {
      // print("Error dude");
      return Left(AppError("Something went wrong"));
    }
  }
}
