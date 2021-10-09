import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/data/model/cart_model.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/domain/entity/product_entity.dart';
import 'package:shop_app/services/firebase_storage.dart';

class FireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference products =
      FirebaseFirestore.instance.collection("products");

  Future<void> addProduct(ProductModel product) async {
    List<String> imageList = List<String>.empty(growable: true);

    for (var productImage in product.images) {
      String imageUri = await FireBaseStorage().uploadImage(productImage);
      imageList.add(imageUri);
    }

    Map<String, dynamic> productDetail = {
      'name': product.name,
      'oriPrice': product.oriPrice,
      'disPrice': product.disPrice,
      'images': imageList,
      'size': product.size,
      'details': product.details,
    };

    return products
        .add(productDetail)
        .then((value) => print('Product is added'))
        .catchError((error) => print("Failed to add product: $error"));
  }

  Future<void> addToCart(ProductEntity product, String size) async {
    // CollectionReference<Map<String, dynamic>> carts =
    //     FirebaseFirestore.instance.collection("carts");

    // Map<String, dynamic> cartDetail = {
    //   "id": product.id,
    //   "name": product.name,
    //   "oriPrice": product.oriPrice,
    //   "disPrice": product.disPrice,
    //   "images": product.images[0],
    //   "size": size,
    //   "quantity": 1,
    // };
  }

  Future<void> getAllCart() async {
    //TODO: get all cart
  }

  Future<List<ProductModel>> getAllProduct() async {
    //* Snapshot of the documents in collection(Products)
    //* To See whether have documents in the collection
    var querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    //* List<QueryDocumentSnapshot<Map<String,dynamic>>
    //* show that have 5 documents in the collection
    var allDocument = querySnapshot.docs;

    List<ProductModel> allProduct = [];

    for (var document in allDocument) {
      //* for each document unique id
      // print(document.id);
      var product = ProductModel.fromMap(document);
      allProduct.add(product);
    }
    return allProduct;
  }
}
