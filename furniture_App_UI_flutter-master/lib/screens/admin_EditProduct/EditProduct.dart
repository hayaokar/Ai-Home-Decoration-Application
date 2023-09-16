import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/background.dart';
import '../../models/Product.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  EditProductPage({this.product});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _priceController;
  String imagePath = "";
  String filename = "";

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product.name);
    _descriptionController =
        TextEditingController(text: widget.product.description);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    final int id = widget.product.id;
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final double price = double.tryParse(_priceController.text) ?? 0.0;
    final prefs = await SharedPreferences.getInstance();
    final String action = prefs.getString("Authorization");

    var dio = Dio();
    dio.options.headers["authorization"] = 'token ${action}';

    FormData data = FormData.fromMap({
      'name': title,
      'description': description,
      'price': price.toString(),
    });

    if (imagePath.isNotEmpty) {
      data.files.add(
        MapEntry(
          'image_url',
          await MultipartFile.fromFile(imagePath, filename: filename),
        ),
      );
    }

    var response = await dio.put(
      'http://10.0.2.2:8000/products/$id/update/',
      data: data,
    );

    if (response.statusCode == 200) {
      print('Changes saved successfully');
      Navigator.pop(context);
    } else {
      print('Failed to save changes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                TextField(
                  controller: _titleController,
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
                  height: 20,
                ),
                FlatButton(
                  onPressed: () async {
                    FilePickerResult result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File file = File(result.files.single.path ?? "");

                      setState(() {
                        imagePath = file.path;
                        filename = file.path.split('/').last;
                      });
                    }
                  },
                  child: Text('Upload Image'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  onPressed: _saveChanges,
                  color: Color.fromARGB(176, 158, 86, 4),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Color.fromARGB(175, 255, 255, 255),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
