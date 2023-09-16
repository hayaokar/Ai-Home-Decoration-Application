// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:furniture_app/components/background.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:http/http.dart' as http;

// class Enhance extends StatefulWidget {
//   Enhance({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _EnhanceState createState() => _EnhanceState();
// }

// class _EnhanceState extends State<Enhance> {
//   String imagePath = "";
//   String filename = "";
//   String imagePath1 = "";
//   String filename1 = "";
//   bool isImageLoading = false;
//   List<String> objectList = ['wall', 'floor', 'bed'];
//   List<String> colorList = ['red', 'blue', 'green'];
//   String selectedObject = "";
//   String selectedColor = "";

//   Future<void> _Decorate() async {
//     setState(() {
//       isImageLoading = true;
//     });
//     var request = http.MultipartRequest(
//         "POST", Uri.parse("http://abed.pythonanywhere.com/modify_image"));
//     request.fields["object"] = "wall";
//     request.fields["color"] = "red";
//     var pic = await http.MultipartFile.fromPath("image", imagePath);
//     request.files.add(pic);
//     var response = await request.send();

//     print("loaaddddinngg");
//     if (response.statusCode == 200) {
//       print("ssucceeess");
//       var responseBytes = await response.stream.toBytes();
//       Directory tempDir = await getTemporaryDirectory();
//       String tempPath = '${tempDir.path}/image.jpg';

//       File file = File(tempPath);
//       await file.writeAsBytes(responseBytes);
//       setState(() {
//         imagePath = file.path;
//         filename = file.path.split('/').last;
//         isImageLoading = false;
//       });

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => DecoratedImagePage(imagePath: imagePath),
//         ),
//       );
//     } else {
//       print("error");
//     }
//     //    Directory tempDir = await getTemporaryDirectory();
//     //   String tempPath = '${tempDir.path}/image.jpg';

//     //    File file = File(tempPath);
//     //    await file.writeAsBytes(response.data);

//     //    setState(() {
//     //      imagePath = file.path;
//     //      filename = file.path.split('/').last;
//     //      isImageLoading = false;
//     //    });

//     //    Navigator.push(
//     //      context,
//     //      MaterialPageRoute(
//     //        builder: (context) => DecoratedImagePage(imagePath: imagePath),
//     //      ),
//     //    );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Background(
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: <Widget>[
//               SizedBox(height: 40),
//               isImageLoading
//                   ? CircularProgressIndicator()
//                   : imagePath.isNotEmpty
//                       ? Image.file(
//                           File(imagePath),
//                           width: 200,
//                           height: 200,
//                         )
//                       : Text('No image selected'),
//               SizedBox(height: 40),
//               FlatButton(
//                 onPressed: () async {
//                   FilePickerResult result =
//                       await FilePicker.platform.pickFiles();

//                   File file = File(result.files.single.path ?? "");

//                   setState(() {
//                     imagePath = file.path;
//                   });
//                 },
//                 child: Text('Select Image'),
//               ),
//               SizedBox(height: 20),
//               SizedBox(height: 20),
//               Text('Select an object:'),
//               DropdownButton<String>(g
//                 value: objectList.isNotEmpty ? objectList[0] : null,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedObject = newValue;
//                     objectList.remove(newValue);
//                     objectList.insert(0, newValue);
//                   });
//                 },
//                 items: objectList.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               Text('Select a color:'),
//               DropdownButton<String>(
//                 value: colorList.isNotEmpty ? colorList[0] : null,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedColor = newValue;
//                     colorList.remove(newValue);
//                     colorList.insert(0, newValue);
//                   });
//                 },
//                 items: colorList.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 40),
//               RaisedButton(
//                 onPressed: _Decorate,
//                 child: Text('Decorate'),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DecoratedImagePage extends StatelessWidget {
//   const DecoratedImagePage({Key key, this.imagePath}) : super(key: key);

//   final String imagePath;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Decorated Image'),
//       ),
//       body: Center(
//         child: Image.file(
//           File(imagePath),
//           width: 300,
//           height: 300,
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/background.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class Enhance extends StatefulWidget {
  Enhance({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EnhanceState createState() => _EnhanceState();
}

class _EnhanceState extends State<Enhance> {
  String imagePath = "";
  String filename = "";
  String imagePath1 = "";
  String filename1 = "";
  bool isImageLoading = false;
  List<String> objectList = ['wall', 'floor', 'bed'];
  List<String> colorList = ['red', 'blue', 'green'];
  String selectedObject = "";
  String selectedColor = "";

  Future<void> _Decorate() async {
    setState(() {
      isImageLoading = true;
    });

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("http://abed.pythonanywhere.com/modify_image"),
    );
    request.fields["object"] = selectedObject;
    request.fields["color"] = selectedColor;

    var pic = await http.MultipartFile.fromPath("image", imagePath);
    request.files.add(pic);

    var response = await request.send();

    print("loaaddddinngg");
    if (response.statusCode == 200) {
      print("ssucceeess");
      var responseBytes = await response.stream.toBytes();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/image.jpg';

      File file = File(tempPath);
      await file.writeAsBytes(responseBytes);
      setState(() {
        imagePath = file.path;
        filename = file.path.split('/').last;
        isImageLoading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DecoratedImagePage(imagePath: imagePath),
        ),
      );
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              isImageLoading
                  ? CircularProgressIndicator()
                  : imagePath.isNotEmpty
                      ? Image.file(
                          File(imagePath),
                          width: 200,
                          height: 200,
                        )
                      : Text('No image selected'),
              SizedBox(height: 40),
              FlatButton(
                onPressed: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles();

                  File file = File(result.files.single.path ?? "");

                  setState(() {
                    imagePath = file.path;
                  });
                },
                child: Text('Select Image'),
              ),
              SizedBox(height: 20),
              Text('Select an object:'),
              DropdownButton<String>(
                value: selectedObject.isNotEmpty ? selectedObject : null,
                onChanged: (newValue) {
                  setState(() {
                    selectedObject = newValue;
                  });
                },
                items: objectList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text('Select a color:'),
              DropdownButton<String>(
                value: selectedColor.isNotEmpty ? selectedColor : null,
                onChanged: (newValue) {
                  setState(() {
                    selectedColor = newValue;
                  });
                },
                items: colorList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: _Decorate,
                color: Color.fromARGB(176, 158, 86, 4),
                child: Text(
                  'enhance',
                  style: TextStyle(
                      color: Color.fromARGB(175, 255, 255, 255),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DecoratedImagePage extends StatelessWidget {
  const DecoratedImagePage({Key key, this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Image.file(
            File(imagePath),
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
