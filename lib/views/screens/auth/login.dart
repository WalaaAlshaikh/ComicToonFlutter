import 'package:comic_toon_flutter/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/controllers/auth_controllers.dart';
import '../../../routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/theme.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_form_field.dart';
import '../../widgets/auth/container_under.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 28.65.w,
              child: Image.asset(
                "assets/images/Colors.png",
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.27,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: TextUtils(
                                  text: "LOGIN",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.5.sp)),
                          SizedBox(
                            height: 2.34.h,
                          ),
                          AuthTextFromField(
                            controller: emailController,
                            obscureText: false,
                            validator: (value) {
                              if (!RegExp(validationEmail).hasMatch(value)) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            prefixIcon: Image.asset(
                              "assets/images/email.png",
                              color: mainColor,
                            ),
                            suffixIcon: const Text(""),
                            hintText: 'Email',
                          ),
                          SizedBox(
                            height: 2.34.h,
                          ),
                          GetBuilder<AuthController>(builder: (_) {
                            return AuthTextFromField(
                              maxLines: 1,
                              controller: passwordController,
                              obscureText:
                                  controller.isVisibilty ? false : true,
                              validator: (value) {
                                if (value.toString().length < 6) {
                                  return 'Password should be longer than 6 characters';
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: Image.asset(
                                "assets/images/lock.png",
                                color: mainColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.Visibilty();
                                },
                                icon: controller.isVisibilty
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.black54,
                                      )
                                    : const Icon(
                                        Icons.visibility,
                                        color: Colors.black54,
                                      ),
                              ),
                              hintText: 'Password',
                            );
                          }),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.forgotPasswordScreen);
                                },
                                child: TextUtils(
                                    text: "Forgot password?",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 9.5.sp,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.grey)),
                          ),
                          SizedBox(
                            height: 1.07.h,
                          ),
                          GetBuilder<AuthController>(builder: (_) {
                            return AuthButton(
                              text: "LOG IN",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String email = emailController.text.trim();
                                  String password = passwordController.text;
                                  controller.displayUserEmail.value = email;

                                  controller.loginUsingFierbase(
                                      email: email, password: password);
                                }
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                );
                              },
                            );
                          }),
                          SizedBox(
                            height: 0.54.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container_Under(
                              text: "Don't have an account? ",
                              onPressed: () {
                                Get.offNamed(Routes.signUpScreen);
                              },
                              typetext: 'Register',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
