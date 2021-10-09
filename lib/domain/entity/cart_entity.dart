import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final String id;
  final String name;
  final String oriPrice;
  final String disPrice;
  final String images;
  final String size;
  final int quantity;

  CartEntity({
    required this.id,
    required this.name,
    required this.oriPrice,
    required this.disPrice,
    required this.images,
    required this.size,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, name];
}
