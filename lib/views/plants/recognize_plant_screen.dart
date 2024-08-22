import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';

class RecognizePlantScreen extends StatefulWidget {
  final String? title;
  final String? imageUrl;

  const RecognizePlantScreen({Key? key, this.title, this.imageUrl})
      : super(key: key);

  @override
  State<RecognizePlantScreen> createState() => _RecognizePlantScreenState();
}

class _RecognizePlantScreenState extends State<RecognizePlantScreen> {
  XFile? image;
  bool isLoading = true;

  Future<void> pickImageFromCamera() async {
    XFile? imagePicked =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imagePicked != null) {
      isLoading = false;
      image = imagePicked;
      setState(() {});
    } else {
      return;
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      isLoading = false;
      image = imagePicked;
      setState(() {});
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: AppColors.kPrimaryColor,
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
                      widget.imageUrl!,
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
                pickImageFromCamera();
              },
              child: const Text('Camera'),
            ),
            SizedBox(height: Get.height * 0.01),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
              ),
              onPressed: () {
                pickImageFromGallery();
              },
              child: const Text('Gallery'),
            ),
            SizedBox(height: Get.height * 0.01),
            const Text(
              'Result',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Disease',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('...'),
              ],
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text(
                  'Confidence',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('...'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
