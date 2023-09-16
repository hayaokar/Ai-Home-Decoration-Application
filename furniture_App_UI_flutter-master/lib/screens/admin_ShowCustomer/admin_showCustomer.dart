import 'package:flutter/material.dart';
import 'package:furniture_app/components/background.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../profile2/profile_screen.dart';

class CustomersScreen extends StatefulWidget {
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  Future<List<Data>> _customersFuture;

  @override
  void initState() {
    super.initState();
    _customersFuture = _fetchCustomers();
  }
  // 'http://127.0.0.1:8000/'

  Future<List<Data>> _fetchCustomers() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/get-users/'), headers: {
      "Authorization": 'Token $action',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((json) => Data.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: FutureBuilder<List<Data>>(
          future: _customersFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final customer = snapshot.data[index];
                  final username = customer.username ?? '';
                  final email = customer.email ?? '';

                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(username),
                    subtitle: Text(email),
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
    );
  }
}
