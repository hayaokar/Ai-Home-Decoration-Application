import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/background.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Product.dart';
import '../../size_config.dart';
import '../admin/admin.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;

  OrderDetailsScreen({this.order});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  Future<List<Product>> _productsFuture;

  Future<List<Product>> fetchOrderProducts(int orderId) async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/orders/$orderId/'), headers: {
      "Authorization": 'Token $action',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['order_items'] is List) {
        final products = data['order_items']
            .map<Product>((item) => Product.fromJson(item['product']))
            .toList();
        return products;
      } else {
        throw Exception('Invalid order items format');
      }
    } else {
      throw Exception('Failed to load order products');
    }
  }

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchOrderProducts(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('Order Number: ${widget.order.id}'),
                    Text(
                        'Buyer Name: ${widget.order.user_name != null ? widget.order.user_name : ''}'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final products = snapshot.data;

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          leading: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              // padding: EdgeInsets.all(
                              //     getProportionateScreenWidth(10)),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: product.image_url != null
                                  ? Image.network(
                                      product.image_url,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(),
                            ),
                          ),
                          title: Text(product.name != null ? product.name : ''),
                          subtitle: Text('\$${product.price?.toString()}'),
                          // subtitle: Text(product.quantity ?? ''),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  } else {
                    // return Center(
                    //   child: CircularProgressIndicator(),

                    return Center(
                      child: Text('No products available'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
