part of 'productlist_bloc.dart';

abstract class ProductlistState extends Equatable {
  const ProductlistState();

  @override
  List<Object> get props => [];
}

class ProductlistInitial extends ProductlistState {}

class ProductlistLoading extends ProductlistState {}

class ProductlistError extends ProductlistState {
  final AppError message;

  ProductlistError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductlistLoaded extends ProductlistState {
  final List<ProductEntity> products;

  ProductlistLoaded({required this.products});

  @override
  List<Object> get props => [products];
}
