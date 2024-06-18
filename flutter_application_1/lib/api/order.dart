import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';

Future<List<Order>> fetchOrders() async {
  final response = await http.get(Uri.parse('https://raw.githubusercontent.com/popina/test-flutter/main/data.json'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['orders'];
    return jsonResponse.map((order) => Order.fromJson(order)).toList();
  } else {
    throw Exception('Failed to load orders');
  }
}
