enum CoffeSize {
  small,
  medium,
  large;

  String get name {
    switch (this) {
      case CoffeSize.small:
        return 'Pequeno';
      case CoffeSize.medium:
        return 'Médio';
      case CoffeSize.large:
        return 'Grande';
    }
  }
}

class CoffeModel {
  final String id;
  final double price;
  final String imagePath;
  final String title;
  final String type;
  final String discription;
  CoffeSize size;

  CoffeModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imagePath,
    required this.type,
    required this.discription,
    this.size = CoffeSize.small,
  });

  factory CoffeModel.fromMap(map) => CoffeModel(
        id: map['id'],
        title: map['title'],
        price: double.parse(map['price'].toString()),
        imagePath: map['imagePath'],
        type: map['type'],
        discription: map['description'],
      );
}
