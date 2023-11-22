class RegisterModel {
  final String name;
  final String password;
  final String user;

  RegisterModel({
    required this.name,
    required this.password,
    required this.user,
  });
}

extension RegisterModelExtension on RegisterModel {
  Map<String, dynamic> toMap() {
    return {
      'addresses': [],
      'name': name,
      'password': password,
      'payments': [],
      'user': user,
      'myRequests': []
    };
  }
}
