class ManagerModel {
  final int saledQuantity;
  final double saledValue;
  final DateTime date;

  ManagerModel({
    required this.saledQuantity,
    required this.saledValue,
    required this.date,
  });

  factory ManagerModel.fromMap(map) => ManagerModel(
        saledQuantity: map['quantity'],
        saledValue: double.parse(map['total'].toString()),
        date: map['date'].toDate(),
      );
}
