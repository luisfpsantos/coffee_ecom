class PaymentModel {
  final String name;
  final String cardValue;
  final String dueDate;
  final String securityCode;

  PaymentModel({
    required this.name,
    required this.cardValue,
    required this.dueDate,
    required this.securityCode,
  });

  static Map<String, dynamic> toMap(PaymentModel payment) => {
        'name': payment.name,
        'cardValue': payment.cardValue,
        'dueDate': payment.dueDate,
        'securityCode': payment.securityCode,
      };
}
