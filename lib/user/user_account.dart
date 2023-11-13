import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msosikiganjani/base/custom_loader.dart';
import 'package:msosikiganjani/controllers/auth_controller.dart';
import 'package:msosikiganjani/controllers/cart_controllers.dart';
import 'package:msosikiganjani/controllers/user_controller.dart';
import 'package:msosikiganjani/route_helper/route_helper.dart';
import 'package:msosikiganjani/utils/colors.dart';
import 'package:msosikiganjani/utils/dimensions.dart';
import 'package:msosikiganjani/widgets/app_icons.dart';
import 'package:msosikiganjani/widgets/big_text.dart';
import 'package:msosikiganjani/widgets/user_acc_wid.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userIsLoggedIn();

    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: 'Profile',
            size: 24,
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            //printInfo(info: 'is loin ${userController.isLoading}');
            return userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: Dimensions.height10),
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            AppIcon(
                              icon: Icons.person,
                              iconSize: Dimensions.height20 * 4,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.height15 * 10,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    UserAccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.person,
                                          iconColor: Colors.white,
                                          backgroundColor: AppColors.mainColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text:
                                                userController.userModel.name)),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    UserAccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.phone,
                                          iconColor: Colors.white,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel.phone)),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    UserAccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.email,
                                          iconColor: Colors.white,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel.email)),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    UserAccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.location_city,
                                          iconColor: Colors.white,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: 'Address')),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    UserAccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message,
                                          iconColor: Colors.white,
                                          backgroundColor: Colors.redAccent,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: 'Messages')),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userIsLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();

                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        } else {}
                                      },
                                      child: UserAccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.logout,
                                            iconColor: Colors.white,
                                            backgroundColor: Colors.red,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(text: 'Logout')),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSize20),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/image/signintocontinue.png",
                                  ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 8,
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSize20),
                            ),
                            child: Center(
                                child: BigText(
                              text: "Sign in to continue",
                              color: Colors.white,
                              size: Dimensions.fontSize26,
                            )),
                          ),
                        )
                      ],
                    )),
                  );
          },
        ));
  }
}
