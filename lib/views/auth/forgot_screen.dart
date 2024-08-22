import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:planti/views/auth/login_screen.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _emailController = TextEditingController();
  bool isLoading = false;
  final _forgotKey = GlobalKey<FormState>();
  // final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading == false
            ? SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.height * 0.04,
                        vertical: Get.height * 0.1),
                    child: Form(
                      key: _forgotKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.height * 0.2,
                            width: Get.height * 0.2,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          SizedBox(height: Get.height * 0.04),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: AppColors.kPrimaryColor,
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.kPrimaryColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value != null &&
                                  !EmailValidator.validate(value)) {
                                return 'please provide a valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: Get.height * 0.05),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.kPrimaryColor,
                            ),
                            onPressed: () async {
                              if (_forgotKey.currentState!.validate()) {
                                // isLoading = true;
                                // await _firebaseAuth
                                //     .sendPasswordResetEmail(
                                //         email: _emailController.text.trim())
                                //     .then((value) {
                                //   isLoading = false;
                                //   return Get.offAll(() => const LoginScreen());
                                // }).catchError((e) {
                                //   isLoading = false;
                                // });
                                // setState(() {});
                              }
                            },
                            child: const Text('RESET PASSWORD'),
                          ),
                          SizedBox(height: Get.height * 0.05),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.kPrimaryColor,
                            ),
                            onPressed: () {
                              Get.offAll(() => const LoginScreen());
                            },
                            child: const Text('goto Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              ),
      ),
    );
  }
}
