import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/models/addres_model.dart';
import 'package:coffe_ecom/models/payment_model.dart';
import 'package:coffe_ecom/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  String _errorMsg = '';
  bool _isLoading = false;

  String get errorMsg => _errorMsg;
  bool get isLoading => _isLoading;

  set errorMsg(String value) {
    _errorMsg = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> doLogin(String user, String password) async {
    errorMsg = '';

    if (user.isEmpty || user.length <= 3 || password.length <= 3 || password.isEmpty) {
      errorMsg = 'Usuário e/ou senha invalidos!';
      return;
    }

    isLoading = true;
    final result = await _db
        .collection('users')
        .where('user', isEqualTo: user)
        .where('password', isEqualTo: password)
        .get();

    final doc = result.docs;

    if (doc.isEmpty) {
      errorMsg = 'Usuário e/ou senha invalidos!';
      isLoading = false;
      return;
    }

    final loggedUser = doc.first.data();

    userController.loggedUser = UserModel(
      id: doc.first.id,
      name: loggedUser['name'],
      addresses: loggedUser['addresses']
          .map<AddresModel>(
            (e) => AddresModel(
              name: e['name'],
              street: e['street'],
              number: e['number'],
              neighborhood: e['neighborhood'],
            ),
          )
          .toList(),
      payments: loggedUser['payments']
          .map<PaymentModel>(
            (e) => PaymentModel(
              name: e['name'],
              cardValue: e['cardValue'],
              dueDate: e['dueDate'],
              securityCode: e['securityCode'],
            ),
          )
          .toList(),
    );

    isLoading = false;
  }
}
