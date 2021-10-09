import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/cart/cart_screen.dart';
import 'package:shop_app/presentation/home/components/body.dart';
import 'package:shop_app/services/firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: buildBottomNavigationBar(currentIndex),
    );
  }

  Container buildBottomNavigationBar(int index) {
    const List<IconData> navBarItem = [
      Icons.home,
      Icons.explore,
      Icons.shopping_bag,
      Icons.settings,
    ];

    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            navBarItem.length,
            (index) {
              return CustomIconButton(
                onTap: () async {
                  if (currentIndex != index) {
                    setState(() {
                      currentIndex = index;
                    });

                    switch (index) {
                      case 0:
                        {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                          await Future.delayed(Duration(milliseconds: 500))
                              .then((value) {
                            currentIndex = 0;
                          });
                        }
                        break;
                      case 1:
                        {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Scaffold();
                            },
                          ));
                          await Future.delayed(Duration(milliseconds: 500))
                              .then((value) {
                            setState(() {
                              currentIndex = 0;
                            });
                          });
                        }
                        break;
                      case 2:
                        {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return CartScreen();
                            },
                          ));
                          await Future.delayed(Duration(milliseconds: 500))
                              .then((value) {
                            setState(() {
                              currentIndex = 0;
                            });
                          });
                        }
                        break;
                      default:
                        {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Scaffold();
                            },
                          ));
                          await Future.delayed(Duration(milliseconds: 500))
                              .then((value) {
                            setState(() {
                              currentIndex = 0;
                            });
                          });
                        }
                    }
                  }
                },
                icon: navBarItem[index],
                isSelected: index == currentIndex,
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await FireStore().getAllCart();
          },
          icon: Icon(CupertinoIcons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final bool isSelected;

  const CustomIconButton({
    Key? key,
    required this.onTap,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Colors.orange[400] : Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[500],
            size: 34,
          ),
        ),
      ),
    );
  }
}
