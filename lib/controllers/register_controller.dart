import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_ecom/models/register_model.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  String _errorMsg = '';
  bool _isLoading = false;
  bool _success = false;

  String get errorMsg => _errorMsg;
  bool get isLoading => _isLoading;
  bool get success => _success;

  set errorMsg(String value) {
    _errorMsg = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set success(bool value) {
    _success = value;
    notifyListeners();
  }

  Future<void> register(RegisterModel register) async {
    isLoading = true;
    errorMsg = '';

    final result = await _db.collection('users').where('user', isEqualTo: register.user).get();
    final docs = result.docs;

    if (docs.isNotEmpty) {
      isLoading = false;
      errorMsg = 'Este usuário já existe, tente outro';
      return;
    }

    await _db.collection('users').add(register.toMap());

    success = true;
    isLoading = false;
  }
}
