import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/domain/entity/cart_entity.dart';

class CartModel extends CartEntity {
  final String id;
  final String name;
  final String oriPrice;
  final String disPrice;
  final String images;
  final String size;
  final int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.oriPrice,
    required this.disPrice,
    required this.images,
    required this.size,
    required this.quantity,
  }) : super(
          id: id,
          name: name,
          oriPrice: oriPrice,
          disPrice: disPrice,
          images: images,
          size: size,
          quantity: quantity,
        );

  Map<String, dynamic> cartModelToMap(CartModel cartModel) {
    return {
      "name": cartModel.name,
      "oriPrice": cartModel.oriPrice,
      "disPrice": cartModel.disPrice,
      "images": cartModel.images,
      "size": cartModel.size,
      "quantity": cartModel.quantity,
    };
  }

  factory CartModel.fromMap(QueryDocumentSnapshot map) {
    return CartModel(
      id: map["id"],
      name: map["name"],
      oriPrice: map["oriPrice"],
      disPrice: map["disPrice"],
      images: map["images"],
      size: map["size"],
      quantity: map["quantity"],
    );
  }
}
