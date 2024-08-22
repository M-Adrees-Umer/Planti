import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:planti/views/home/home_screen.dart';
import 'package:planti/views/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashTime() {
    Timer(const Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser != null
          ? Get.offAll(const HomeScreen())
          : Get.offAll(OnBoardingScreen());
    });
  }

  @override
  initState() {
    super.initState();
    splashTime();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: size.height * 0.6,
          width: size.width * 0.6,
        ),
      ),
    );
  }
}
// EasySplashScreen(
// logo: Image.asset('assets/images/logo.png'),
// title: const Text(""),
// backgroundColor: Colors.grey.shade400,
// showLoader: true,
// loadingText: const Text(""),
// navigator: OnBoardingScreen(),
// firebaseAuth.currentUser != null
//     ? const HomeScreen()
//     : OnBoardingScreen(),
// durationInSeconds: 3,
// )
