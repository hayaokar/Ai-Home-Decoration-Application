import 'dart:io';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/background.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Decorate extends StatefulWidget {
  Decorate({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DecorateState createState() => _DecorateState();
}

class _DecorateState extends State<Decorate> {
  String imagePath = "";
  String filename = "";
  String imageUrl = ""; // Add this line
  //String imagePath1 = "";
  //tring filename1 = "";
  bool isImageLoading = false;

  Future<void> _Decrorate() async {
    var dio = Dio();

    //String downloadUrl =
    //    'http://10.0.2.2:8000/media/generated_scenes/Bedroom-18759_115_000.png'; // استبدله برابط التحميل الفعلي

    FormData data = FormData.fromMap({
      'image_url': await MultipartFile.fromFile(imagePath, filename: filename),
    });

    setState(() {
      isImageLoading = true;
    });

    var response1 = await dio.post('http://10.0.2.2:8000/model/', data: data);

    if (response1.statusCode == 200) {
      var responseData = response1.data;
      var imageUrl = responseData['generated_image'];

      try {
        var response = await dio.get(
          // imageUrl,
          imageUrl,
          options: Options(responseType: ResponseType.bytes),
          onReceiveProgress: (receivedBytes, totalBytes) {
            if (mounted) {
              setState(() {});
            }
          },
        );

        Directory tempDir = await getTemporaryDirectory();
        String tempPath = '${tempDir.path}/image.jpg';

        File file = File(tempPath);
        await file.writeAsBytes(response.data);

        setState(() {
          imagePath = file.path;
          filename = file.path.split('/').last;
          isImageLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImagePage(imagePath: imagePath),
          ),
        );
      } catch (error) {
        print('fail to download img $error');
        setState(() {
          isImageLoading = false;
        });
      }
    } else {
      print('faild in POST: ${response1.statusCode}');
      setState(() {
        isImageLoading = false;
      });
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
                  //FilePickerResult result1 =
                   //   await FilePicker.platform.pickFiles();
                  File file = File(result.files.single.path ?? " ");
                  //File file1 = File(result1.files.single.path ?? " ");

                  setState(() {
                    imagePath = file.path;
                    filename = file.path.split('/').last;
                    //imagePath1 = file1.path;
                    //filename1 = file1.path.split('/').last;
                  });
                },
                child: Text('Upload Image'),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: _Decrorate,
                color: Color.fromARGB(176, 158, 86, 4),
                child: Text(
                  'Generate scene',
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

class ImagePage extends StatelessWidget {
  final String imagePath;

  const ImagePage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Image.file(
            File(imagePath),
            width: 350,
            height: 350,
          ),
        ),
      ),
    );
  }
}
