import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/services/firestore.dart';

abstract class IProductRemoteDataSources {
  Future<List<ProductModel>> getAllProducts();
  // Future<void> addToCart();
}

class ProductRemoteDataSourcesImpl extends IProductRemoteDataSources {
  final FireStore fireStore;

  ProductRemoteDataSourcesImpl(this.fireStore);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    List<ProductModel> allProduct = await FireStore().getAllProduct();
    return allProduct;
  }

  // @override
  // Future<void> addToCart() {
  //   // TODO: implement addToCart
  //   throw UnimplementedError();
  // }
}
