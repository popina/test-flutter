class Item {
  final int id;
  final String name;
  final int price;
  final String currency;
  final String color;

  Item({required this.id, required this.name, required this.price, required this.currency, required this.color});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      currency: json['currency'],
      color: json['color'],
    );
  }
}