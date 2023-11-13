import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msosikiganjani/base/custom_loader.dart';
import 'package:msosikiganjani/pages/authentication/sign_up_page.dart';
import 'package:msosikiganjani/route_helper/route_helper.dart';
import 'package:msosikiganjani/utils/colors.dart';
import 'package:msosikiganjani/utils/dimensions.dart';
import 'package:msosikiganjani/widgets/app_text_field.dart';
import 'package:msosikiganjani/widgets/big_text.dart';

import '../../base/show_custom_message.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Enter your email address please!",
            title: "Email Adress");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Enter  a valid email please!",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Enter your password please!", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than six characters!",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 80,
                            backgroundImage:
                                AssetImage("assets/image/logo part 1.png"),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.width20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                  color: AppColors.mainBlackColor,
                                  fontSize: Dimensions.fontSize20 * 3 +
                                      Dimensions.fontSize20 / 2,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Sign into your account",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.fontSize20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      AppTextField(
                          textEditingController: emailController,
                          hintText: "Email",
                          iconData: Icons.email),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                          textEditingController: passwordController,
                          hintText: "Password",
                          isObscure: true,
                          iconData: Icons.password),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusSize30,
                              ),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign in",
                              size: Dimensions.fontSize20 +
                                  Dimensions.fontSize20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Don\'t have an account?",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.fontSize20),
                            children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => SignUpPage(),
                                        transition: Transition.fade),
                                  text: "Create here",
                                  style: TextStyle(
                                      color: AppColors.mainBlackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.fontSize20),
                                  children: [])
                            ]),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
