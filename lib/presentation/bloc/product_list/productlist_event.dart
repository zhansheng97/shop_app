part of 'productlist_bloc.dart';

abstract class ProductlistEvent extends Equatable {
  const ProductlistEvent();

  @override
  List<Object> get props => [];
}

class ProductListLoadEvent extends ProductlistEvent {}
