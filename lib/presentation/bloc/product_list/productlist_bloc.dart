import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/domain/entity/app_error.dart';
import 'package:shop_app/domain/entity/no_params.dart';
import 'package:shop_app/domain/entity/product_entity.dart';
import 'package:shop_app/domain/usecases/get_all_product.dart';

part 'productlist_event.dart';
part 'productlist_state.dart';

class ProductlistBloc extends Bloc<ProductlistEvent, ProductlistState> {
  final GetAllProduct getAllProduct;

  ProductlistBloc({required this.getAllProduct}) : super(ProductlistInitial());

  @override
  Stream<ProductlistState> mapEventToState(
    ProductlistEvent event,
  ) async* {
    if (event is ProductListLoadEvent) {
      Either<AppError, List<ProductEntity>> eitherReponse =
          await getAllProduct(NoParams());
      yield eitherReponse.fold(
        (l) => ProductlistError(l),
        (products) => ProductlistLoaded(products: products),
      );
    }
  }
}
