import 'package:coffe_ecom/models/coffe_model.dart';

class MyRequestModel {
  final DateTime date;
  final CoffeModel coffe;
  final int quantity;
  final CoffeSize coffeSize;
  final double total;

  MyRequestModel({
    required this.date,
    required this.coffe,
    required this.quantity,
    required this.coffeSize,
    required this.total,
  });

  factory MyRequestModel.fromMap(map) => MyRequestModel(
        date: map['date'].toDate(),
        coffe: CoffeModel.fromMap(map['coffe']),
        quantity: map['quantity'],
        coffeSize: CoffeSize.values.firstWhere((e) => e.name == map['size']),
        total: double.parse(map['total'].toString()),
      );
}
