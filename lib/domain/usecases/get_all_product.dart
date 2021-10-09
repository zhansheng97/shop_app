import 'package:dartz/dartz.dart';
import 'package:shop_app/domain/entity/app_error.dart';
import 'package:shop_app/domain/entity/no_params.dart';
import 'package:shop_app/domain/entity/product_entity.dart';
import 'package:shop_app/domain/repository/product_repository_interface.dart';
import 'package:shop_app/domain/usecases/usecases_interface.dart';

class GetAllProduct extends IUseCase<List<ProductEntity>, NoParams> {
  final IProductRepository productRepository;

  GetAllProduct(this.productRepository);

  @override
  Future<Either<AppError, List<ProductEntity>>> call(NoParams params) async {
    return await productRepository.getAllProduct();
  }
}
