import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class AppleLeaf extends StatefulWidget {
  const AppleLeaf({
    Key? key,
  }) : super(key: key);

  @override
  _AppleLeafState createState() => _AppleLeafState();
}

class _AppleLeafState extends State<AppleLeaf> {
  XFile? image;
  bool isLoading = true;
  List? _outputs;
  double _confidence = 0.0;

  Future<void> pickImage(ImageSource source) async {
    XFile? imagePicked = await ImagePicker().pickImage(source: source);

    if (imagePicked != null) {
      isLoading = false;
      image = imagePicked;
      setState(() {});
      detectImage(image);
    } else {
      return;
    }
  }

  Future<void> detectImage(XFile? image) async {
    var outPut = await Tflite.runModelOnImage(
      path: image!.path,
      numResults: 4,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _outputs = outPut;
      isLoading = false;
      print("Hi $_outputs");
      _confidence = _outputs != null
          ? (_outputs![0]['confidence'] * 100.0).substring(0, 2) + '%'
          : '';
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/models/apple/apple.tflite',
      labels: 'assets/models/apple/labels.txt',
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apple Leaf'),
        backgroundColor: AppColors.kPrimaryColor,
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.01),
            SizedBox(
              height: Get.height * 0.35,
              width: double.infinity,
              child: image != null
                  ? Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/apple.jpg',
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
            ),
            SizedBox(height: Get.height * 0.04),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
              ),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            SizedBox(height: Get.height * 0.01),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
              ),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
            SizedBox(height: Get.height * 0.1),
            const Text(
              'Result',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Disease',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _outputs != null
                    ? Text('${_outputs![0]['label']}')
                    : const Text('label'),
              ],
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Confidence',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _outputs != null
                    ? Text('${_outputs![0]['confidence']}')
                    : const Text('confidence'),
                // Text(_confidence.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
