import 'package:dartz/dartz.dart';
import 'package:shop_app/domain/entity/app_error.dart';
import 'package:shop_app/domain/entity/product_entity.dart';

abstract class IProductRepository {
  Future<Either<AppError, List<ProductEntity>>> getAllProduct();
}
