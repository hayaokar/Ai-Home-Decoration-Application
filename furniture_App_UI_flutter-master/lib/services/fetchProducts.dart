import 'dart:convert';
import 'package:furniture_app/models/Product.dart';
import 'package:http/http.dart' as http;

// import '../screens/admin_showProduct/adminShowProduct.dart';

// Fetch our Products from API
Future<List<Product>> fetchProducts() async {
  const String apiUrl = "http://10.0.2.2:8000/products/";

  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Product> products = (json.decode(response.body) as List)
        .map((data) => Product.fromJson(data))
        .toList();
    // Return list of products
    return products;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
