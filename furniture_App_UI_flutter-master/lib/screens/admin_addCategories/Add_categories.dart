import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/background.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../admin_showCategories/Show_Category.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String imagePath = "";
  String filename = "";
  Future<void> _addCategory() async {
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");

    var dio = Dio();
    dio.options.headers["authorization"] = 'token ${action}';
    
  

    FormData data = FormData.fromMap({
      'image_url': await MultipartFile.fromFile(imagePath),
      'name':_nameController.text,
      'description':_descriptionController.text,
      
    });

    var response = await dio.post('http://10.0.2.2:8000/categories/create/',
    data:data);

    print(response.statusCode);

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Category added successfully.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pop(); // Go back to the previous page (ProductsScreen)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CategoriesScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add category.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 60,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(
                height: 60,
              ),
              FlatButton(
                onPressed: () async {
                    FilePickerResult result = await FilePicker.platform.pickFiles();

                    File file = File(result.files.single.path ?? " ");
                    
                    setState(() {
                    imagePath = file.path;
                    filename = file.path.split('/').last;
                  });
                    
                  },
                child: Text('Upload Image'),
              ),
              RaisedButton(
                onPressed: _addCategory,
                color: Color.fromARGB(176, 158, 86, 4),
                child: Text(
                  'Add Category',
                  style: TextStyle(
                      color: Color.fromARGB(175, 255, 255, 255),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
