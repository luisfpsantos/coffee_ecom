import 'package:coffe_ecom/models/coffe_model.dart';

class CartModel {
  final CoffeModel coffe;
  int quantity;

  CartModel({required this.coffe, this.quantity = 1});
}
