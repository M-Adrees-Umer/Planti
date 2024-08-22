import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:planti/views/auth/login_screen.dart';
import 'package:planti/views/result/apple_leaf_result.dart';
import 'package:planti/views/result/corn_leaf_result.dart';
import 'package:planti/views/result/grape_leaf_result.dart';
import 'package:planti/views/result/potato_leaf_result.dart';
import 'package:planti/views/result/tomato_leaf_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plante'),
        backgroundColor: AppColors.kPrimaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                isLoading = true;
                await firebaseAuth.signOut();
                isLoading = false;
                Get.offAll(const LoginScreen());
              },
              icon: const Icon(
                Icons.logout,
                // color: AppColors.kPrimaryColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: Get.height * 0.04,
                backgroundImage: const AssetImage('assets/images/apple.jpg'),
              ),
              title: const Text('Apple Leaf',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: const Text('tap to recognize'),
              trailing: IconButton(
                onPressed: () {
                  Get.to(() => const AppleLeaf());
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: Get.height * 0.04,
                backgroundImage: const AssetImage('assets/images/corn.png'),
              ),
              title: const Text('Corn Leaf',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: const Text('tap to recognize'),
              trailing: IconButton(
                onPressed: () {
                  Get.to(() => const CornLeaf());
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: Get.height * 0.04,
                backgroundImage: const AssetImage('assets/images/grape.png'),
              ),
              title: const Text('Grapes Leaf',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: const Text('tap to recognize'),
              trailing: IconButton(
                onPressed: () {
                  Get.to(() => const GrapeLeaf());
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: Get.height * 0.04,
                backgroundImage: const AssetImage('assets/images/potato.png'),
              ),
              title: const Text('Potato Leaf',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: const Text('tap to recognize'),
              trailing: IconButton(
                onPressed: () {
                  Get.to(() => const PotatoLeaf());
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                radius: Get.height * 0.04,
                backgroundImage: const AssetImage('assets/images/tomato.png'),
              ),
              title: const Text('Tomato Leaf',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              subtitle: const Text('tap to recognize'),
              trailing: IconButton(
                onPressed: () {
                  Get.to(() => const TomatoLeaf());
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
