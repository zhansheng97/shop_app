import 'package:dartz/dartz.dart';
import 'package:shop_app/domain/entity/app_error.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}
