import 'package:flutter/material.dart';
import 'package:furniture_app/components/background.dart';
import 'package:furniture_app/screens/profile2/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String username = prefs.getString('username');
    final String email = prefs.getString('email');

    _usernameController.text = username;
    _emailController.text = email;
  }

  // Future<void> _updateUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final String action = prefs.getString('Authorization');
  //   final String url = 'http://10.0.2.2:8000/api/user/update/';

  //   final Map<String, dynamic> userData = {
  //     'username': _usernameController.text,
  //     'email': _emailController.text,
  //   };

  //   final String jsonData = json.encode(userData);

  //   final response = await http.put(
  //     Uri.parse(url),
  //     headers: {
  //       'Authorization': 'Token $action',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonData,
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);

  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Update Done'),
  //           content: Text('Update Successful'),
  //           actions: [
  //             TextButton(
  //               child: Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );

  //     print('Done update $data');
  //   } else {
  //     print('Failed');
  //   }
  // }
  Future<void> _updateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString('Authorization');
    final String url = 'http://10.0.2.2:8000/api/user/update/';

    final String username = _usernameController.text;
    final String email = _emailController.text;

    if (username.isEmpty) {
      _usernameController.text = prefs.getString('username');
    }
    if (email.isEmpty) {
      _emailController.text = prefs.getString('email');
    }

    if (username.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Validation Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {},
              ),
            ],
          );
        },
      );
      return; // Stop further execution
    }

    final Map<String, dynamic> userData = {
      'username': username,
      'email': email,
    };

    final String jsonData = json.encode(userData);

    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $action',
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Done'),
            content: Text('Update Successful'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                  // Navigator.of(context)
                  //     .pop(); // Go back to the previous page (ProductsScreen)
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
            ],
          );
        },
      );

      print('Done update $data');
    } else {
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.all(26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'User Name'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 60.0),
              Center(
                child: RaisedButton(
                  onPressed: _updateUser,
                  color: Color.fromARGB(176, 158, 86, 4),
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
