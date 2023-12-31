import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_ecom/models/coffe_model.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  List<CoffeModel> _coffes = [];
  bool _isLoading = false;
  String _errorMsg = '';
  List<CoffeModel> _filteredCoffes = [];

  List<CoffeModel> get coffes => _coffes;
  bool get isLoading => _isLoading;
  String get errorMsg => _errorMsg;
  List<CoffeModel> get filteredCoffes => _filteredCoffes;

  set coffes(List<CoffeModel> coffes) {
    _coffes = coffes;
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

  set filteredCoffes(List<CoffeModel> coffes) {
    _filteredCoffes = coffes;
    notifyListeners();
  }

  Future<void> getCoffes(String type) async {
    try {
      isLoading = true;
      final result = await _db.collection('coffes').where('type', isEqualTo: type).get();
      final docs = result.docs;

      coffes = docs.map((e) {
        final coffe = e.data();
        coffe['id'] = e.id;
        return CoffeModel.fromMap(coffe);
      }).toList();

      isLoading = false;
    } catch (e) {
      errorMsg = e.toString();
    }
  }

  void searchCoffes(String value) {
    if (value.isEmpty) {
      filteredCoffes = [];
      return;
    }

    final filtered = coffes.where((e) => e.title.toLowerCase().contains(value)).toList();

    filteredCoffes = filtered;
  }
}
