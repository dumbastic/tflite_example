import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bangkit Final Project'),
          backgroundColor: Colors.red
        ),
        body: Center(
          child: MyImagePicker()
        )
      )
    );
  }
}
class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}
class MyImagePickerState extends State {
  File imageURI;
  String result;
  String path;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
      path = image.path;
    });
  }
  
  Future classifyImage() async {
    await Tflite.loadModel(model: "assets/model_unquant.tflite",labels: "assets/labels.txt");
    var output = await Tflite.runModelOnImage(path: path);
    var outputString = output.toString().replaceAll("[{", "").replaceAll("}]", "")
                       .replaceAll("label", "LABEL").replaceAll("confidence", "CONFIDENCE");
    setState(() {
      result = outputString.split(",")[2] + "\n" + outputString.split(",")[0];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Text(
                'Rice Disease Classification\nusing CNN on TensorFlow Lite', 
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),

            imageURI == null
              ? Image.asset('assets/placeholder.png', width: 300, height: 200, fit: BoxFit.cover,)
              : Image.file(imageURI, width: 300, height: 200, fit: BoxFit.cover),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: RaisedButton(
                    onPressed: () => getImageFromCamera(),
                    child: Text('From Camera'),
                    textColor: Colors.white,
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: RaisedButton(
                    onPressed: () => getImageFromGallery(),
                    child: Text('From Gallery'),
                    textColor: Colors.white,
                    color: Colors.blue,
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  )
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: RaisedButton(
                onPressed: () => classifyImage(),
                child: Text('Classify Image'),
                textColor: Colors.white,
                color: Colors.red,
                padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              )
            ),

            result == null
              ? Text('\n', textAlign: TextAlign.center,)
              : Text(result, textAlign: TextAlign.center,),

            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text('Developed by JKT5-A Team', textAlign: TextAlign.center,)
            ),
            
          ]
        )
      )
    );
  }
}