import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class GrapeLeaf extends StatefulWidget {
  const GrapeLeaf({Key? key}) : super(key: key);

  @override
  _GrapeLeafState createState() => _GrapeLeafState();
}

class _GrapeLeafState extends State<GrapeLeaf> {
  XFile? image;
  bool isLoading = true;
  List? _outputs;

  Future<void> pickImage(ImageSource source) async {
    XFile? imagePicked = await ImagePicker().pickImage(source: source);

    if (imagePicked != null) {
      isLoading = false;
      image = imagePicked;
      setState(() {});
      await detectImage(image);
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
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/models/grape/grape.tflite',
      labels: 'assets/models/grape/labels.txt',
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
        title: const Text('Grape Leaf'),
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
                      'assets/images/grape.png',
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
                isLoading == true
                    ? const Text('Grape')
                    : Text('${_outputs![0]['label']}'),
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
                isLoading == true
                    ? const Text('Grape')
                    : Text('${_outputs![0]['confidence']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
