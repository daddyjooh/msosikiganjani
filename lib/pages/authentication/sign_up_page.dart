import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msosikiganjani/base/custom_loader.dart';
import 'package:msosikiganjani/base/show_custom_message.dart';
import 'package:msosikiganjani/controllers/auth_controller.dart';
import 'package:msosikiganjani/models/signup_body_model.dart';
import 'package:msosikiganjani/utils/colors.dart';
import 'package:msosikiganjani/utils/dimensions.dart';
import 'package:msosikiganjani/widgets/app_text_field.dart';
import 'package:msosikiganjani/widgets/big_text.dart';

import '../../route_helper/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Enter your name please!", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Enter your phone number please!",
            title: "Phone number");
      } else if (email.isEmpty) {
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
        SignUpBody signUpBody = SignUpBody(
            name: name, email: email, password: password, phone: phone);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
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
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                          textEditingController: nameController,
                          hintText: "Name",
                          iconData: Icons.person),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextField(
                          textEditingController: phoneController,
                          hintText: "Phone",
                          iconData: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                              text: "Sing up",
                              size: Dimensions.fontSize20 +
                                  Dimensions.fontSize20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      RichText(
                          text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.fontSize20),
                      )),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      RichText(
                          text: TextSpan(
                        text: "Sign up using the following methods?",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.fontSize20),
                      )),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radiusSize30,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + signUpImages[index]),
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
