import 'package:coffe_ecom/models/cart_model.dart';
import 'package:coffe_ecom/models/coffe_model.dart';
import 'package:flutter/foundation.dart';

class CartController extends ChangeNotifier {
  List<CartModel> _cartCoffes = [];

  List<CartModel> get cartCoffes => _cartCoffes;

  set cartCoffes(List<CartModel> coffes) {
    _cartCoffes = coffes;
    notifyListeners();
  }

  void addCoffeToCart(CoffeModel coffe) {
    final haveCoffe = _cartCoffes.indexWhere(
      (element) => element.coffe.title == coffe.title && element.coffe.size == coffe.size,
    );

    if (haveCoffe != -1) {
      _cartCoffes[haveCoffe].quantity += 1;
    }

    if (haveCoffe == -1) {
      _cartCoffes.add(CartModel(coffe: coffe));
    }

    notifyListeners();
  }

  void removeCoffeFromCart(CartModel cart) {
    if (cart.quantity > 1) {
      cart.quantity -= 1;
    } else {
      _cartCoffes.remove(cart);
    }

    notifyListeners();
  }

  int getCartTotalItems() {
    return _cartCoffes.fold(0, (previousValue, element) => previousValue + element.quantity);
  }

  double getCartTotalValue() {
    return _cartCoffes.fold(
      0,
      (previousValue, element) => previousValue + (element.quantity * element.coffe.price),
    );
  }
}
