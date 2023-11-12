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
  final double price;
  final String imagePath;
  final String title;
  final String type;
  final String discription;
  CoffeSize size;

  CoffeModel({
    required this.title,
    required this.price,
    required this.imagePath,
    required this.type,
    required this.discription,
    this.size = CoffeSize.small,
  });
}
