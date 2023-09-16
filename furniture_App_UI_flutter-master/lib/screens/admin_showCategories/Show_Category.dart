import 'package:flutter/material.dart';
import 'package:furniture_app/components/background.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/Categories.dart';
import '../admin_addCategories/Add_categories.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _fetchCategories();
  }

  Future<List<Category>> _fetchCategories() async {
    const String apiUrl = "http://10.0.2.2:8000/categories/";

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      List<Category> categories = (json.decode(response.body) as List)
          .map((data) => Category.fromJson(data))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<void> _deleteCategory(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    // print(action);
    final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/categories/$id/delete/'),
        headers: {
          "Authorization": 'Token $action',
        });
    if (response.statusCode == 200) {
      setState(() {
        _categoriesFuture = _fetchCategories();
      });
    } else {
      throw Exception('Failed to delete category');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: FutureBuilder<List<Category>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final category = snapshot.data[index];
                  return ListTile(
                    leading: category.image_url != null
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/spinner.gif",
                            image: category.image_url,
                            fit: BoxFit.cover,
                          )
                        : Text('no img'),
                    title: Text(
                      category.name,
                      style: TextStyle(
                          color: Color.fromARGB(174, 121, 48, 0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      category.description,
                      maxLines: 3,
                      style: TextStyle(
                        color: Color.fromARGB(255, 82, 44, 0),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Category'),
                              content: Text(
                                  'Are you sure you want to delete this category?'),
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
                                    _deleteCategory(category.id);
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pop(); // Go back to the previous page (ProductsScreen)
                                    Navigator.push(
                                      context,
                                      // .pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoriesScreen()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
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
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 245, 167, 0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCategoryScreen(),
            ),
          );
        },
      ),
    );
  }
}
