import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String description = '';
  var _imageFile;
  bool isFormValid = false;

  Future<void> _requestCameraPermission() async {
    final PermissionStatus cameraStatus = await Permission.camera.request();
    final PermissionStatus galleryStatus = await Permission.photos.request();

    if (cameraStatus.isGranted || galleryStatus.isGranted) {
      _showImageSourceDialog();
    } else if (cameraStatus.isDenied || galleryStatus.isDenied) {
      print("Camera or gallery permission denied");
    } else if (cameraStatus.isPermanentlyDenied ||
        galleryStatus.isPermanentlyDenied) {
      print("Camera or gallery permission permanently denied");
    }
  }

  Future<void> performTextRecognition() async {
    if (_imageFile == null) {
      // Handle the case where no image is selected.
      return;
    }

    final inputImage = InputImage.fromFilePath(_imageFile.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      String text = recognisedText.text;
      setState(() {
        description = text;
      });
    } catch (e) {
      print('Error during text recognition: $e');
    } finally {
      textDetector.close();
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Camera"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Gallery"),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  performImageLabelling() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white24,
        flexibleSpace: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_app_img2text.png',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 8.0),
              Text(
                'ImageConverter',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade200,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Add Image of your Diseased Crop',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w200,
                    color: Colors.black),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              if (_imageFile == null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: _requestCameraPermission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade200,
                    ),
                    child: Icon(Icons.add),
                  ),
                )
              else
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.file(_imageFile),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Description:',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w200,
                    color: Colors.black),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.9,
                child: SingleChildScrollView(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: description,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter Description of your crop:',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    maxLines: null,
                    scrollPadding: EdgeInsets.all(
                        16.0), // Optional padding for scroll view
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _imageFile != null ? performTextRecognition : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _imageFile != null && isFormValid
                        ? Colors.red
                        : Colors.green,
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'Send for Analysis',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
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
