import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_ecom/models/my_request_model.dart';
import 'package:flutter/foundation.dart';

class MyRequestsController extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<MyRequestModel> _myRequests = [];
  String _errorMsg = '';
  bool _isLoading = false;

  String get errorMsg => _errorMsg;
  bool get isLoading => _isLoading;
  List<MyRequestModel> get myRequests => _myRequests;

  set errorMsg(String value) {
    _errorMsg = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set myRequests(List<MyRequestModel> myRequests) {
    _myRequests = myRequests;
    notifyListeners();
  }

  Future<void> getMyRequests(String userId) async {
    isLoading = true;

    final result = await _db.collection('users').doc(userId).get();
    final doc = result.data();
    final List requests = doc!['myRequests'];

    if (requests.isEmpty) {
      errorMsg = 'Você ainda não efetuou nenhum pedido!.';
    }

    final List<MyRequestModel> list = [];

    for (var request in requests) {
      final DocumentReference coffeRef = request['coffe'];
      final coffeDoc = await coffeRef.get();
      final coffe = coffeDoc.data() as Map;
      coffe['id'] = coffeDoc.id;
      request['coffe'] = coffe;
      list.add(MyRequestModel.fromMap(request));
    }

    myRequests = list;
    isLoading = false;
  }
}
