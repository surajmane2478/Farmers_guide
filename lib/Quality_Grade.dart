import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class QualityGradeAnalysisPage extends StatefulWidget {
  @override
  _QualityGradeAnalysisPageState createState() =>
      _QualityGradeAnalysisPageState();
}

class _QualityGradeAnalysisPageState extends State<QualityGradeAnalysisPage> {
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void analyzeImage() {
    // Add your image analysis logic here
    // This function will be triggered when the user wants to analyze the image
    // You can use image processing libraries or machine learning models for analysis
    // For the sake of this example, let's just print a message
    print('Analyzing image...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quality Grade Analysis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.image,
                size: 80,
                color: Colors.grey,
              ),
            )
                : Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: FileImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImageFromGallery,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Select Image'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: getImageFromCamera,
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Take Picture'),
            ),
            SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: _image != null ? analyzeImage : null,
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.blue,
            //     onPrimary: Colors.white,
            //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   ),
            //   child: Text('Analyze Image'),
            // ),
          ],
        ),
      ),
    );
  }
}
