import 'dart:convert';

import 'dart:math';

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;
final random = Random();
final coffees = List.generate(
    _names.length,
    (index) => Coffee(
        name: _names[index],
        image: 'assets/coffee/${index + 1}.png',
        price: _doubleInRange(random, 3, 7)));

final _names = [
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Caramel Macchiato',
  'Vietnamese-Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte'
];

class Coffee {
  final String name;
  final String image;
  final double price;
  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });

  Coffee copyWith({
    String? name,
    String? image,
    double? price,
  }) {
    return Coffee(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
    };
  }

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: map['price'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Coffee.fromJson(String source) => Coffee.fromMap(json.decode(source));

  @override
  String toString() => 'Coffee(name: $name, image: $image, price: $price)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coffee &&
        other.name == name &&
        other.image == image &&
        other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ price.hashCode;
}
