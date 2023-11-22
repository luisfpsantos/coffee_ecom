import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_ecom/models/manager_model.dart';
import 'package:flutter/material.dart';

class ManagerController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<ManagerModel> _sales = [];
  bool _isLoading = false;
  String _errorMsg = '';

  List<ManagerModel> get sales => _sales;
  bool get isLoading => _isLoading;
  String get errorMsg => _errorMsg;

  set sales(List<ManagerModel> sales) {
    _sales = sales;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set errorMsg(String value) {
    _errorMsg = value;
    notifyListeners();
  }

  Future<void> getSales() async {
    isLoading = true;

    final result = await _db.collection('users').get();
    final docs = result.docs;

    final List<ManagerModel> allSales = [];

    for (var doc in docs) {
      final user = doc.data();
      final userSales = user['myRequests'] as List;
      allSales.addAll(userSales.map((e) => ManagerModel.fromMap(e)));
    }

    sales = allSales;

    isLoading = false;
  }
}
