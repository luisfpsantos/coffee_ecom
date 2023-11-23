import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_ecom/main.dart';
import 'package:coffe_ecom/models/cart_model.dart';
import 'package:flutter/foundation.dart';

class PaymentController extends ChangeNotifier {
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

  Future<void> savePaymentItems(List<CartModel> cartCoffes) async {
    isLoading = true;
    errorMsg = '';

    final userId = userController.loggedUser!.id;
    final doc = _db.collection('users').doc(userId);
    final batch = _db.batch();

    for (var cart in cartCoffes) {
      final coffe = cart.coffe;
      final quantity = cart.quantity;
      final total = cartController.getCartTotalValue();
      final data = {
        'myRequests': FieldValue.arrayUnion([
          {
            'coffe': _db.doc('coffes/${coffe.id}'),
            'quantity': quantity,
            'size': coffe.size.name,
            'total': total,
            'date': DateTime.now()
          },
        ])
      };

      batch.set(doc, data, SetOptions(merge: true));
    }

    await batch
        .commit()
        .onError((error, stackTrace) => errorMsg = 'Não foi possivel salvar pedido');

    isLoading = false;
    success = true;
  }
}
