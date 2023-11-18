class AddresModel {
  final String name;
  final String street;
  final int number;
  final String neighborhood;

  AddresModel({
    required this.name,
    required this.street,
    required this.number,
    required this.neighborhood,
  });

  static Map<String, dynamic> toMap(AddresModel address) => {
        'name': address.name,
        'neighborhood': address.neighborhood,
        'number': address.number,
        'street': address.street,
      };
}
