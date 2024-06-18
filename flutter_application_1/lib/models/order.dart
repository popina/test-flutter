import 'item.dart';

class Order {
  final int id;
  final String table;
  final int guests;
  final String date;
  final List<Item> items;

  Order({required this.id, required this.table, required this.guests, required this.date, required this.items});

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Item> itemsList = list.map((i) => Item.fromJson(i)).toList();

    return Order(
      id: json['id'],
      table: json['table'],
      guests: json['guests'],
      date: json['date'],
      items: itemsList,
    );
  }
}