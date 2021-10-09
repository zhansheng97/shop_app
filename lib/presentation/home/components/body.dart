import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop_app/di/get_it.dart';
import 'package:shop_app/domain/usecases/get_all_product.dart';
import 'package:shop_app/presentation/bloc/product_list/productlist_bloc.dart';
import 'package:shop_app/presentation/detail/detail_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ProductlistBloc productlistBloc;

  @override
  void initState() {
    productlistBloc =
        ProductlistBloc(getAllProduct: getItInstance<GetAllProduct>());
    Future.delayed(Duration(milliseconds: 1500))
        .then((value) => productlistBloc.add(ProductListLoadEvent()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
          child: Container(
            width: double.infinity,
            height: size.height * .77,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* -----------------------------
                //* Header of the home screen
                //* -----------------------------
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Find your",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 2,
                            right: 0,
                            child: CustomPaint(
                              painter: CurveLineBelow(),
                              child: Container(
                                height: 70,
                                width: 70,
                              ),
                            ),
                          ),
                          Text(
                            "match style!",
                            style: TextStyle(fontSize: 26),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //* -----------------------
                //* List of Categories
                //* -----------------------
                CategoriesList(),
                const SizedBox(height: 10),
                //* -------------------
                //* Shirt GridView
                //* -------------------
                ProductGridView(productlistBloc: productlistBloc),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProductGridView extends StatefulWidget {
  final ProductlistBloc productlistBloc;

  const ProductGridView({
    Key? key,
    required this.productlistBloc,
  }) : super(key: key);

  @override
  _ProductGridViewState createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  bool isFavourite = false;
  List<int> favouriteIndex = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductlistBloc, ProductlistState>(
        bloc: widget.productlistBloc,
        builder: (context, state) {
          if (state is ProductlistLoaded) {
            var productList = state.products;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return FadeTransition(
                                opacity: animation,
                                child: DetailScreen(
                                  product: productList[index],
                                  isFavourtiteProduct:
                                      favouriteIndex.contains(index),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            productList[index].images.first,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: FavouriteButton(
                                      onTap: () {
                                        setState(() {
                                          if (!favouriteIndex.contains(index)) {
                                            favouriteIndex.add(index);
                                            isFavourite = true;
                                            print(favouriteIndex);
                                          } else {
                                            favouriteIndex.remove(index);
                                            isFavourite = false;
                                            print(favouriteIndex);
                                          }
                                        });
                                      },
                                      isFavourite:
                                          favouriteIndex.contains(index),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productList[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        productList[index].oriPrice,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        productList[index].disPrice,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[400],
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.orange[400],
                                          decorationThickness: 2.0,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index.isEven ? 3.5 : 2.5),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  static const List<String> categoryList = [
    "Trending Now",
    "2021 New In",
    "Tiktok Trending",
    "Special Customize "
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 55,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          padding: const EdgeInsets.only(left: 20.0),
          itemBuilder: (context, index) {
            return CategoryItem(
              title: categoryList[index],
              onTap: () {
                setState(() {
                  currentIndex = index;
                });
              },
              isSelected: currentIndex == index,
            );
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItem({
    Key? key,
    required this.title,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Material(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 10,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[800],
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CurveLineBelow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.orange[500]!;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;

    var startPoint = Offset(0, size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 2.5);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 2.5);
    var endPoint = Offset(size.width, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class FavouriteButton extends StatelessWidget {
  final double size;
  final bool isFavourite;
  final VoidCallback? onTap;

  const FavouriteButton({
    Key? key,
    this.size = 20,
    this.isFavourite = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            isFavourite ? Icons.favorite : Icons.favorite_border,
            size: 20,
            color: isFavourite ? Colors.red[400] : Colors.black,
          ),
        ),
      ),
    );
  }
}
