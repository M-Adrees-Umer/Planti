import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:planti/views/auth/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final List<PageViewModel> listPageViewModel = <PageViewModel>[
    PageViewModel(
      title: 'Easy to Use',
      body:
          'Ease of use is a basic concept that describes how easily users can use a product.',
      image: Container(
          padding: EdgeInsets.only(top: Get.size.height * 0.04),
          child: Center(
              child: Image.asset(
            'assets/onboarding/easytouse.png',
          ))),
    ),
    PageViewModel(
      title: 'Fast Processing',
      body:
          'Processing speed implies a greater ability to easily do simple or previously-learned tasks.',
      image: Container(
          padding: EdgeInsets.only(top: Get.size.height * 0.04),
          child: Center(
              child: Image.asset('assets/onboarding/fastprocessing.png'))),
    ),
    PageViewModel(
      title: 'Quick Tool to Recognize Diseases',
      body:
          'We use Google Teachable Machine to recognize diseases which is quick and easy to use.',
      image: Container(
          padding: EdgeInsets.only(top: Get.size.height * 0.04),

          //SvgPicture.asset('assets/onBoardingImage.svg')
          child: Center(
              child: Image.asset('assets/onboarding/smartprocessing.png'))),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: listPageViewModel,
        showSkipButton: true,
        skip: const Text(
          'SkIP',
          style: TextStyle(
            color: AppColors.kButtonColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // skipStyle: ButtonStyle(
        //   backgroundColor:
        //       MaterialStateProperty.all<Color>(AppColors.kPrimaryColor),
        //   foregroundColor:
        //       MaterialStateProperty.all<Color>(AppColors.kWhiteColor),
        // ),
        onSkip: () => Get.offAll(const LoginScreen()),
        skipOrBackFlex: 0,
        done: const Text(
          'Get Started',
          style: TextStyle(
            color: AppColors.kButtonColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        // doneStyle: ButtonStyle(
        //   backgroundColor:
        //       MaterialStateProperty.all<Color>(AppColors.kPrimaryColor),
        //   foregroundColor:
        //       MaterialStateProperty.all<Color>(AppColors.kWhiteColor),
        // ),
        onDone: () => Get.offAll(const LoginScreen()),
        next: const Text(
          'Next',
          style: TextStyle(
            color: AppColors.kButtonColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // nextColor: Colors.amber,
        nextFlex: 0,
        dotsDecorator: DotsDecorator(
          color: const Color(0xFFD3D3D3),
          activeSize: const Size(23, 10),
          activeColor: AppColors.kPrimaryColor,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        globalBackgroundColor: Colors.white,
        isProgressTap: false,
      ),
    );
  }
}
