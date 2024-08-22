import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planti/utils/app_colors.dart';
import 'package:planti/views/auth/forgot_screen.dart';
import 'package:planti/views/auth/sign_up_screen.dart';
import 'package:planti/views/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _logKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isObscurePass = true;
  final _firebaseAuth = FirebaseAuth.instance;

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
                        key: _logKey,
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
                            SizedBox(height: Get.height * 0.04),
                            TextFormField(
                              controller: _passwordController,
                              cursorColor: AppColors.kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: AppColors.kPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscurePass = !isObscurePass;
                                    });
                                  },
                                  icon: Icon(
                                    isObscurePass == false
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ),
                              obscureText: isObscurePass,
                              validator: (value) {
                                if (value != null && value.length < 8) {
                                  return 'password must be 8 characters long';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: Get.height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      Get.to(() => const ForgotScreen()),
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: Get.height * 0.04),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.kPrimaryColor,
                              ),
                              onPressed: () async {
                                if (_logKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await _firebaseAuth
                                        .signInWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    )
                                        .then((value) {
                                      isLoading = false;
                                      return Get.offAll(
                                          () => const HomeScreen());
                                    });
                                    setState(() {});
                                  } on FirebaseException catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.snackbar(e.code, '${e.message}');
                                  }
                                }
                              },
                              child: const Text('LOGIN'),
                            ),
                            SizedBox(height: Get.height * 0.15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have in Account '),
                                InkWell(
                                  onTap: () =>
                                      Get.to(() => const SignUpScreen()),
                                  child: const Text(
                                    'SignUp',
                                    style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
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
