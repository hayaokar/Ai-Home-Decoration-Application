import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../components/background.dart';
import '../../../models/Product.dart';
import '../admin_AddProduct/AddProduct.dart';
import '../admin_EditProduct/EditProduct.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/products/'));
    if (response.statusCode == 200) {
      List<Product> products = (json.decode(response.body) as List)
          .map((data) => Product.fromJson(data))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> _deleteProduct(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/products/$id/delete/'),
      headers: {
        "Authorization": 'Token $action',
      },
    );
    if (response.statusCode == 200) {
      print('Product deleted successfully');
      setState(() {
        _productsFuture = _fetchProducts();
      });
    } else {
      throw Exception('Failed to delete product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: FutureBuilder<List<Product>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data[index];

                  return Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        color:
                            Color.fromARGB(255, 255, 145, 0).withOpacity(0.3),
                        child: ListTile(
                          leading: product.image_url != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: "assets/spinner.gif",
                                  image: product.image_url,
                                  fit: BoxFit.cover,
                                )
                              : Text('no img'),
                          title: Text(
                            product.name ?? '',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 228, 207),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            product.description ?? '',
                            maxLines: 3,
                            style: TextStyle(
                              color: Color.fromARGB(255, 82, 44, 0),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditProductPage(product: product),
                                    ),
                                  ).then((_) {
                                    setState(() {
                                      _productsFuture = _fetchProducts();
                                    });
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Product'),
                                        content: Text(
                                            'Are you sure you want to delete this product?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              _deleteProduct(product.id);
                                              Navigator.of(context).pop();
                                              Navigator.of(context)
                                                  .pop(); // Go back to the previous page (ProductsScreen)
                                              Navigator.push(
                                                context,
                                                // .pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductsScreen()),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 245, 167, 0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(),
            ),
          ).then((_) {
            setState(() {
              _productsFuture = _fetchProducts();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
