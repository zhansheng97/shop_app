import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/data/model/cart_model.dart';
import 'package:shop_app/data/model/product_model.dart';
import 'package:shop_app/services/firestore.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ProductModel> cartProductList = [];

  Future<List<ProductModel>> getCart() async {
    List<ProductModel> allProduct = await FireStore().getAllProduct();
    cartProductList.addAll(allProduct);
    return cartProductList;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "My Cart",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "3 items",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 15,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //* ---------------------------
                //* List of cart Product
                //* ---------------------------
                FutureBuilder(
                  future: getCart(),
                  builder: (context, snapshot) {
                    return Container(
                      height: size.height * 0.5,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: cartProductList.length,
                        itemBuilder: (context, index) {
                          var product = cartProductList[index];

                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              height: 110,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: CachedNetworkImage(
                                          imageUrl: product.images.first,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        product.disPrice,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        product.oriPrice,
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationColor:
                                                              Colors.orange,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      CustomSmallButton(
                                                        icon: Icons.add,
                                                        onTap: () {},
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 15,
                                                        ),
                                                        child: Text("1"),
                                                      ),
                                                      CustomSmallButton(
                                                        icon: Icons.remove,
                                                        onTap: () {},
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  product.size.first,
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                                CustomSmallButton(
                                                  icon: Icons.delete,
                                                  onTap: () {
                                                    dottedLine(context);
                                                  },
                                                  withBorder: false,
                                                  size: 22,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CartTile(
                    //   totalPrice: totalBagPrice(cartProductList),
                    //   title: "Sub total",
                    // ),
                    CartTile(
                      totalPrice: 5,
                      title: "Shipping",
                    ),
                    Spacer(),
                    Container(
                      height: 5,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dottedLine(context),
                              itemBuilder: (context, index) {
                                if (index.isEven) {
                                  return SizedBox(
                                    width: 8,
                                    child: Divider(
                                      thickness: 2.5,
                                    ),
                                  );
                                }
                                return SizedBox(
                                  width: 8,
                                  child: Divider(
                                    thickness: 2.5,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    CartTile(totalPrice: totalCartPrice(), title: "Bag Total"),
                    Spacer(),
                    Material(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12.0),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int dottedLine(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    int totalAvailableSpaceforDot = (width ~/ 8);
    return totalAvailableSpaceforDot;
  }

  double totalPrice = 0.0;

  double totalBagPrice(List<CartModel> allProducts) {
    for (var product in allProducts) {
      var price = product.disPrice.substring(1);
      var productPrice = double.parse(price);
      totalPrice += productPrice;
    }
    return totalPrice;
  }

  double totalCartPrice() {
    totalPrice += 5.0;
    return totalPrice;
  }
}

class CartTile extends StatelessWidget {
  final double totalPrice;
  final String title;
  const CartTile({
    Key? key,
    required this.totalPrice,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title :",
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          Text(
            "\$${totalPrice.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double size;
  final bool withBorder;
  final Color color;

  const CustomSmallButton({
    Key? key,
    required this.icon,
    this.size = 15,
    this.withBorder = true,
    required this.onTap,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(
        50.0,
      ),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: withBorder ? Colors.grey : Colors.transparent,
          ),
        ),
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
