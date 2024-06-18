
import 'dart:async';

import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/item.dart';
import '../api/order.dart';
import 'order_Detail.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}


class _OrdersPageState extends State<OrdersPage> {
  late Future<List<Order>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commandes'),
      ),
      body: Center(
        child: FutureBuilder<List<Order>>(
          future: futureOrders, 
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(order.table, style: TextStyle(color: Colors.white)),
        ),
        title: Text('Table ${order.table}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${order.guests} invités'),
            Text('Total: ${calculateTotal(order.items)}€', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(order.date),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderDetailsPage(order: order)),
          );
        },
      ),
    );
  }

  double calculateTotal(List<Item> items) {
    return items.fold(0, (sum, item) => sum + item.price / 100);
  }
}