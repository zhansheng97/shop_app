import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  final String id;
  final String name;
  final String oriPrice;
  final String disPrice;
  final List<String> images;
  final List<String> size;
  final String details;

  ProductModel({
    required this.id,
    required this.name,
    required this.oriPrice,
    required this.disPrice,
    required this.images,
    required this.size,
    required this.details,
  }) : super(
          id: id,
          name: name,
          oriPrice: oriPrice,
          disPrice: disPrice,
          images: images,
          size: size,
          details: details,
        );

  factory ProductModel.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> map) {
    List<dynamic> sizeList = map["size"];
    List<String> size = sizeList.map((size) => size as String).toList();
    List<dynamic> imagesList = map["images"];
    List<String> images = imagesList.map((image) => image as String).toList();

    return ProductModel(
      id: map.id,
      name: map["name"],
      oriPrice: map["oriPrice"],
      disPrice: map["disPrice"],
      size: size,
      details: map["details"],
      images: images,
    );
  }
}

const String loremIpsum =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";

// final shirtModelList = [
//   ProductModel(
//     name: 'AE "SMALL POCKET" SHIRT',
//     oriPrice: "\$139.00",
//     disPrice: "\$78.30",
//     images: [
//       "assets/images/small_pocket.jpg",
//       "assets/images/small_pocket1.jpg",
//       "assets/images/small_pocket2.jpg",
//     ],
//   ),
//   ProductModel(
//     name: "Bowie Rouched Front Long Sleeve Top",
//     oriPrice: "\$99.00",
//     disPrice: "\$69.30",
//     images: [
//       "assets/images/long_sleeve.jpg",
//       "assets/images/long_sleeve1.jpg",
//       "assets/images/long_sleeve2.jpg",
//       "assets/images/long_sleeve3.jpg",
//     ],
//   ),
//   ProductModel(
//     name: "Samantha Seamless Rib Tube",
//     oriPrice: "\$49.00",
//     disPrice: "\$34.30",
//     images: [
//       "assets/images/rib_tube.jpg",
//       "assets/images/rib_tube1.jpg",
//       "assets/images/rib_tube2.jpg",
//       "assets/images/rib_tube3.jpg",
//     ],
//   ),
//   ProductModel(
//       name: "Ash Crop Tank",
//       oriPrice: "\$58.00",
//       disPrice: "\$34.30",
//       images: [
//         "assets/images/crop_tank.jpg",
//         "assets/images/crop_tank1.jpg",
//         "assets/images/crop_tank2.jpg",
//         "assets/images/crop_tank3.jpg",
//       ],
//       details:
//           "A cropped length and stretchy fabric makes the Ash Crop Tank the perfect match to your high waisted denim. The low scooped back is super cute while the wide straps mean all day comfort. We're calling it—this tank top is true love for your wardrobe."),
//   ProductModel(
//     name: "Samantha 2 Seamless Rib Tube ",
//     oriPrice: "\$78.00",
//     disPrice: "\$31.30",
//     images: [
//       "assets/images/samantha_tube.jpg",
//       "assets/images/samantha_tube1.jpg",
//       "assets/images/samantha_tube2.jpg",
//     ],
//   ),
// ];
