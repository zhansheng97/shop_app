import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/domain/entity/product_entity.dart';
import 'package:shop_app/presentation/cart/cart_screen.dart';
import 'package:shop_app/presentation/home/components/body.dart';
import 'package:shop_app/services/firestore.dart';

class DetailScreen extends StatefulWidget {
  final ProductEntity product;
  final bool isFavourtiteProduct;

  const DetailScreen({
    Key? key,
    required this.product,
    required this.isFavourtiteProduct,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentSelectedIndex = 0;
  int currentSelectedSizeIndex = 0;
  double initialOffset = 0.0;
  double screenHeight = .85;
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * .85,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0.0,
                  left: 20.0,
                  right: 20.0,
                  height: 180,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          widget.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.product.details,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 50,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Size",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: widget.product.size.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return SizeButton(
                                        title: widget.product.size[index],
                                        onTap: () {
                                          setState(() {
                                            currentSelectedSizeIndex = index;
                                          });
                                        },
                                        isSelected:
                                            currentSelectedSizeIndex == index,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onVerticalDragStart: (details) {
                    print("start scrolling");
                    print("start at ${details.globalPosition.dy}");
                    initialOffset = details.globalPosition.dy;
                  },
                  onVerticalDragUpdate: (details) {
                    double factorChange =
                        (initialOffset - details.globalPosition.dy) /
                            initialOffset;

                    setState(() {
                      percentage = (factorChange * 10).clamp(0, 1.0);

                      screenHeight = lerpDouble(.85, .6, percentage)!;
                    });
                  },
                  onTap: () {
                    print("haha");
                  },
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(50.0)),
                    child: Container(
                      height: size.height * screenHeight,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.85,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl:
                                  widget.product.images[currentSelectedIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: size.height * 0.85,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(50.0)),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black38,
                                  Colors.black26,
                                  Colors.transparent
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0, 0.15, 0.3],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(
                                    Icons.double_arrow_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Swipe up for detail",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 20,
                            bottom: lerpDouble(120, 20, percentage),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                height: size.height * .45,
                                width: 70,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 8,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: ListView.builder(
                                            padding: EdgeInsets.all(0),
                                            itemCount:
                                                widget.product.images.length,
                                            itemBuilder: (context, index) {
                                              return ProductSmallImage(
                                                image: widget
                                                    .product.images[index],
                                                onTap: () {
                                                  setState(() {
                                                    currentSelectedIndex =
                                                        index;
                                                  });
                                                },
                                                isSelected:
                                                    currentSelectedIndex ==
                                                        index,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      padding: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        FavouriteButton(
                          onTap: () {},
                          isFavourite: widget.isFavourtiteProduct,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Sub Total",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            widget.product.oriPrice,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(14.0),
                        child: InkWell(
                          onTap: () {
                            // FireStore().addToCart(widget.product,
                            //     widget.product.size[currentSelectedSizeIndex]);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: CartScreen(),
                                  );
                                },
                              ),
                            );
                          },
                          splashColor: Colors.orange[300],
                          borderRadius: BorderRadius.circular(14.0),
                          child: Container(
                            height: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 35.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SizeButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeButton({
    Key? key,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Material(
        color: isSelected ? Colors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductSmallImage extends StatelessWidget {
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const ProductSmallImage({
    Key? key,
    required this.image,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.orange[400]! : Colors.transparent,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 65,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
}
