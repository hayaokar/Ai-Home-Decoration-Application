import 'package:flutter/material.dart';
import 'package:furniture_app/components/background_admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Login/login_screen.dart';
import '../admin_ShowCustomer/admin_showCustomer.dart';
import '../admin_order_detail/order_details.dart';
import '../admin_showCategories/Show_Category.dart';
import '../admin_showProduct/adminShowProduct.dart';
import 'package:http/http.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Order>> _ordersFuture;
  Future<int> _productsCountFuture;
  Future<int> _visitorsCountFuture;
  Future<int> _fetchOrdersCountFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchOrders();
    _productsCountFuture = _fetchProductsCount();
    _visitorsCountFuture = _fetchVisitorsCount();
    _fetchOrdersCountFuture = _fetchOrdersCount();
  }

  void logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String action = prefs.getString("Authorization");
      Response respone = await get(
        Uri.parse('http://10.0.2.2:8000/api/logout/'),
        headers: {
        "Authorization": 'Token $action',
      }
      );

      if (respone.statusCode == 200) {
        prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Order>> _fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/orders/'), headers: {
      "Authorization": 'Token $action',
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  Future<int> _fetchProductsCount() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/count-product/'),
        headers: {"Authorization": 'Token $action'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as int;
      return data;
    } else {
      throw Exception('Failed to load products count');
    }
  }

  Future<int> _fetchVisitorsCount() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/count-users/'),
        headers: {"Authorization": 'Token $action'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as int;
      return data;
    } else {
      throw Exception('Failed to load visitors count');
    }
  }
  // http://127.0.0.1:8000/

  Future<int> _fetchOrdersCount() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/count-orders/'),
        headers: {"Authorization": 'Token $action'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as int;
      return data;
    } else {
      throw Exception('Failed to load categories count');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            'FURNITURE STORE',
            style: TextStyle(color: Color.fromARGB(200, 255, 237, 213)),
          ),
        ),
        backgroundColor: Color.fromARGB(148, 156, 89, 2),
      ),
      body: Background_admin(
        child: Container(
          color: Color.fromARGB(24, 255, 145, 0),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Center(
                  child: FutureBuilder<int>(
                    future: _productsCountFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatBox('Products', snapshot.data.toString()
                                // '22'
                                ),
                            FutureBuilder<int>(
                              future: _visitorsCountFuture,
                              builder: (context, snapshot2) {
                                if (snapshot2.hasData) {
                                  return _buildStatBox(
                                      'Users', snapshot2.data.toString()
                                      // '70'
                                      );
                                } else if (snapshot2.hasError) {
                                  return _buildStatBox('Visitors', 'N/A');
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                            FutureBuilder<int>(
                              future: _fetchOrdersCountFuture,
                              builder: (context, snapshot3) {
                                if (snapshot3.hasData) {
                                  return _buildStatBox(
                                      'Orders', snapshot3.data.toString()
                                      // '90'
                                      );
                                } else if (snapshot3.hasError) {
                                  return _buildStatBox('Categories', 'N/A');
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('N/A'),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Order>>(
                  future: _ordersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          final order = snapshot.data[index];
                          return ListTile(
                            leading: Icon(
                              Icons.shopping_cart,
                              color: Color.fromARGB(255, 160, 91, 0),
                            ),
                            title: Text('Order ${order.id}'),
                            subtitle: Text('Order date: ${order.date}'),
                            trailing: Text('\$${order.total_price}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetailsScreen(order: order),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 243, 130, 1).withOpacity(0.1),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Color.fromARGB(143, 124, 56, 0),
                      size: 40,
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(143, 83, 38, 0),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(104, 150, 94, 20),
                ),
              ),
              ListTile(
                title: Text(
                  'Products',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(206, 65, 37, 0)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductsScreen()),
                  );
                },
              ),
              ListTile(
                title: Text(
                  'Customers',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(206, 65, 37, 0),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomersScreen(),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(206, 65, 37, 0),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoriesScreen(),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'LogOut',
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(206, 65, 37, 0)),
                ),
                onTap: () async {
                  logout();

                  // Log out logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String title, String count) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromARGB(207, 252, 248, 243),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color.fromARGB(206, 146, 81, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(200, 158, 115, 74),
            ),
          ),
        ],
      ),
    );
  }
}

class Order {
  final int id;
  final String date;
  final int total_price;
  final String user_name;

  Order({
    this.id,
    this.date,
    this.total_price,
    this.user_name,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      date: json["date"],
      total_price: json["total_price"],
      user_name: json["user_name"],
    );
  }
}
