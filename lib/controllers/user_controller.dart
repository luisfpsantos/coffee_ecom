import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_ecom/models/addres_model.dart';
import 'package:coffe_ecom/models/payment_model.dart';
import 'package:coffe_ecom/models/user_model.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  UserModel? loggedUser;
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

  void logout() {
    loggedUser = null;
  }

  Future<void> addNewAddress(AddresModel address) async {
    isLoading = true;
    errorMsg = '';

    final userId = loggedUser!.id;
    final doc = _db.collection('users').doc(userId);

    loggedUser!.addresses.add(address);

    await doc.set(
      {
        'addresses': FieldValue.arrayUnion([AddresModel.toMap(address)])
      },
      SetOptions(merge: true),
    ).onError((error, stackTrace) => errorMsg = 'Não foi possivel adicionar um novo endereço!');

    isLoading = false;
  }

  Future<void> removeAddress(AddresModel address) async {
    isLoading = true;
    errorMsg = '';

    final userId = loggedUser!.id;
    final doc = _db.collection('users').doc(userId);

    loggedUser!.addresses.remove(address);

    await doc.update(
      {
        'addresses': FieldValue.arrayRemove([AddresModel.toMap(address)])
      },
    ).onError((error, stackTrace) => errorMsg = 'Não foi possivel adicionar um novo endereço!');

    isLoading = false;
  }

  Future<void> addNewPayment(PaymentModel payment) async {
    isLoading = true;
    errorMsg = '';

    final userId = loggedUser!.id;
    final doc = _db.collection('users').doc(userId);

    loggedUser!.payments.add(payment);

    await doc.set(
      {
        'payments': FieldValue.arrayUnion([PaymentModel.toMap(payment)])
      },
      SetOptions(merge: true),
    ).onError((error, stackTrace) =>
        errorMsg = 'Não foi possivel adicionar um novo metodo de pagamento!');

    isLoading = false;
  }

  Future<void> removePayment(PaymentModel payment) async {
    isLoading = true;
    errorMsg = '';

    final userId = loggedUser!.id;
    final doc = _db.collection('users').doc(userId);

    loggedUser!.payments.remove(payment);

    await doc.update(
      {
        'payments': FieldValue.arrayRemove([PaymentModel.toMap(payment)])
      },
    ).onError((error, stackTrace) =>
        errorMsg = 'Não foi possivel adicionar um novo metodo de pagamento!');

    isLoading = false;
  }
}
