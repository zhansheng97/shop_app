import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String oriPrice;
  final String disPrice;
  final List<String> images;
  final List<String> size;
  final String details;

  ProductEntity({
    required this.id,
    required this.name,
    required this.oriPrice,
    required this.disPrice,
    required this.images,
    required this.size,
    required this.details,
  });

  @override
  List<Object?> get props => [id, name];
}
