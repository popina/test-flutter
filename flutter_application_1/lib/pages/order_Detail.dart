import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/item.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    final groupedItems = _groupItems(order.items);

    return Scaffold(
      appBar: AppBar(
        title: Text('Table ${order.table}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${groupedItems.length} produits', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Total: ${calculateTotal(order.items)}€', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: groupedItems.length,
                itemBuilder: (context, index) {
                  final item = groupedItems[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(int.parse('0xFF' + item.color.substring(1))),
                      child: Text(item.quantity.toString(), style: TextStyle(color: Colors.white)),
                    ),
                    title: Text(item.name, style: TextStyle(color: Color(int.parse('0xFF' + item.color.substring(1))))),
                    trailing: Text('${item.price / 100 * item.quantity}€', style: TextStyle(color: Color(int.parse('0xFF' + item.color.substring(1))))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<GroupedItem> _groupItems(List<Item> items) {
    final Map<String, GroupedItem> itemMap = {};

    for (var item in items) {
      if (itemMap.containsKey(item.name)) {
        itemMap[item.name]!.quantity += 1;
      } else {
        itemMap[item.name] = GroupedItem(
          id: item.id,
          name: item.name,
          price: item.price,
          currency: item.currency,
          color: item.color,
          quantity: 1,
        );
      }
    }

    return itemMap.values.toList();
  }

  double calculateTotal(List<Item> items) {
    return items.fold(0, (sum, item) => sum + item.price / 100);
  }
}

class GroupedItem {
  final int id;
  final String name;
  final int price;
  final String currency;
  final String color;
  int quantity;

  GroupedItem({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.color,
    required this.quantity,
  });
}
