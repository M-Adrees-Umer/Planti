import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planti/firebase_options.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:planti/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Plante',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.kPrimaryColor,
        scaffoldBackgroundColor: AppColors.kWhiteColor,
      ),
      home: const SplashScreen(),
    );
  }
}
