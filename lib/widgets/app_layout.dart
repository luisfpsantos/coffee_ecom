import 'dart:ui';
import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/widgets/background_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

int bottomNavigationIndex = 0;

class AppLayout extends StatefulWidget {
  final Widget appBarTitle;
  final bool showUserIcon;
  final Widget body;

  const AppLayout({
    super.key,
    required this.appBarTitle,
    this.showUserIcon = false,
    required this.body,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: widget.appBarTitle,
        ),
        body: Container(
          color: Colors.black.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 500, sigmaY: 500),
            child: widget.body,
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ClipPath(
            clipper: const ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
            ),
            child: Theme(
              data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
              child: ListenableBuilder(
                listenable: cartController,
                builder: (context, child) => BottomNavigationBar(
                  currentIndex: bottomNavigationIndex,
                  backgroundColor: const Color(0xffD9D9D9).withOpacity(0.1),
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 40,
                  elevation: 50,
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  selectedIconTheme: const IconThemeData(color: Color.fromARGB(255, 164, 91, 39)),
                  unselectedIconTheme: const IconThemeData(color: Colors.white),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: '1',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined),
                      label: '2',
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(Icons.shopping_cart_outlined),
                          cartController.cartCoffes.isNotEmpty
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red, // Cor do fundo do badge
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${cartController.getCartTotalItems()}',
                                        style: const TextStyle(
                                          color: Colors.white, // Cor do texto do badge
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      label: '3',
                    ),
                  ],
                  onTap: (value) {
                    if (value != bottomNavigationIndex) {
                      setState(() {
                        bottomNavigationIndex = value;
                      });

                      if (context.canPop()) context.pop();

                      switch (bottomNavigationIndex) {
                        case 0:
                          context.pushReplacement('/');
                          break;
                        case 2:
                          context.pushReplacement('/cartCheckout');
                          break;
                        case 1:
                          context.pushReplacement('/user');
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
