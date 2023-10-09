import 'package:coffe_ecom/widgets/background_container.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final userIcon = showUserIcon
        ? IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle))
        : Container();

    return BackgroundContainer(
      child: Scaffold(
        drawer: const Drawer(
          backgroundColor: Color(0xff8C4D21),
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: appBarTitle,
          actions: [userIcon],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: body,
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
              child: BottomNavigationBar(
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
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: '1',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined),
                    label: '2',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_outlined),
                    label: '3',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: '4',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
