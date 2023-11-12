import 'package:coffe_ecom/controllers/cart_controller.dart';
import 'package:coffe_ecom/firebase_options.dart';
import 'package:coffe_ecom/models/coffe_model.dart';
import 'package:coffe_ecom/views/cart_checkout_page.dart';
import 'package:coffe_ecom/views/description_page.dart';
import 'package:coffe_ecom/views/home_page.dart';
import 'package:coffe_ecom/views/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final cartController = CartController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppWidget());
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/coffeDetails',
        builder: (context, state) => DescriptionPage(coffe: state.extra as CoffeModel),
      ),
      GoRoute(
        path: '/cartCheckout',
        builder: (context, state) => const CartCheckoutPage(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CoffeEcom',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
