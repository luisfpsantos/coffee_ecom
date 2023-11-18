import 'package:coffe_ecom/models/addres_model.dart';
import 'package:coffe_ecom/models/payment_model.dart';

class UserModel {
  final String id;
  final String name;
  final List<AddresModel> addresses;
  final List<PaymentModel> payments;

  UserModel({
    required this.id,
    required this.name,
    required this.addresses,
    required this.payments,
  });
}
