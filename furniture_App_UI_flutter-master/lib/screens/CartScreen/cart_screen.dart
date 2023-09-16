import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:furniture_app/screens/choice/choice_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/background.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../../size_config.dart';
import 'package:http/http.dart' as http;

import '../home/home_screen.dart';
import '../shopping/shopping_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> cartProducts = [];

  @override
  void initState() {
    super.initState();
    fetchCartProducts();
  }

  void deleteProduct(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    var url = Uri.parse('http://10.0.2.2:8000/delete-item-cart/$id/');
    var response = await http.delete(url, headers: {
      "Authorization": 'Token $action',
    });
    if (response.statusCode == 200) {
      setState(() {
        cartProducts.removeWhere((product) => product.id == id);
      });
    } else {
      print('Failed to delete product. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetchCartProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/view-cart/'),
      headers: {"Authorization": 'Token $action'},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Product> fetchedProducts = List<Product>.from(
        data['cart_items'].map((item) {
          Map<String, dynamic> productData = item['products'];
          productData['quantity'] =
              item['quantity']; // Assign the quantity value

          return Product.fromJson(productData);
        }),
      );
      setState(() {
        cartProducts = fetchedProducts;
      });
    } else {
      print(
          'Failed to fetch cart products. Status code: ${response.statusCode}');
    }
  }

  Future<double> fetchTotalPrice() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/view-cart/'),
      headers: {"Authorization": 'Token $action'},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      double totalPrice = double.parse(data['total_price'].toString());

      print(totalPrice);
      return totalPrice;
    } else {
      throw Exception('Failed to fetch total price');
    }
  }

  Future<bool> createOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    var response = await http.post(
      Uri.parse('http://10.0.2.2:8000/create-order/'),
      headers: {"Authorization": 'Token $action'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          child: ListView.builder(
            itemCount: cartProducts.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  leading: AspectRatio(
                    aspectRatio: 0.88,
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: cartProducts[i].image_url != null
                          ? Image.network(
                              cartProducts[i].image_url,
                              // "https://i.imgur.com/sI4GvE6.png",
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${cartProducts[i].name}",
                          ),
                          Text(
                            "Quantity: ${cartProducts[i].quantity}", // Display quantity
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      Text("\$ ${cartProducts[i].price}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteProduct(cartProducts[i].id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(
        cartProducts: cartProducts,
        fetchTotalPrice: fetchTotalPrice,
        createOrder: createOrder,
      ),
    );
  }
}

class CheckoutCard extends StatelessWidget {
  final List<Product> cartProducts;
  final Future<double> Function() fetchTotalPrice;
  final Future<bool> Function() createOrder;

  const CheckoutCard({
    Key key,
    this.cartProducts,
    this.fetchTotalPrice,
    this.createOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(96, 241, 137, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -30),
            blurRadius: 35,
            color: Color.fromARGB(255, 160, 92, 4).withOpacity(0.20),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total :\n",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                FutureBuilder<double>(
                  future: fetchTotalPrice(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "\$ ${snapshot.data}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 95, 62, 25),
                            fontWeight: FontWeight.bold),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CircularProgressIndicator();
                  },
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: RaisedButton(
                    color: Color.fromARGB(176, 158, 86, 4),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Order'),
                            content: Text(
                                'Are you sure you want to place the order?'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  createOrder().then((success) {
                                    if (success) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Order placed successfully'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Failed to place order'),
                                        ),
                                      );
                                    }
                                  });

                                  Navigator.of(context).pop();
                                  // Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                  // Navigator.of(context).pop();
                                  // Navigator.of(context)
                                  //     .pop(); // Go back to the previous page (CartScreen)
                                  // Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ShoppingScreen()),
                                  // );
                                },
                              ),
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Check Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
