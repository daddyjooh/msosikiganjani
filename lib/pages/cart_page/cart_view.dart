import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:msosikiganjani/base/no_data.dart';
import 'package:msosikiganjani/controllers/auth_controller.dart';
import 'package:msosikiganjani/controllers/cart_controllers.dart';
import 'package:msosikiganjani/controllers/popular_products_controller.dart';
import 'package:msosikiganjani/controllers/recommended_products_controller.dart';
import 'package:msosikiganjani/pages/home/home_page.dart';
import 'package:msosikiganjani/utils/app_constants.dart';
import 'package:msosikiganjani/utils/colors.dart';
import 'package:msosikiganjani/utils/dimensions.dart';
import 'package:msosikiganjani/widgets/app_icons.dart';
import 'package:msosikiganjani/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../route_helper/route_helper.dart';
import '../../widgets/big_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.cartPage);
                    },
                    child: AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  )
                ],
              )),
          GetBuilder<CartController>(builder: (
            _cartController,
          ) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(top: Dimensions.height15),
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (cartController) {
                              var _cartList = cartController.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      width: double.maxFinite,
                                      height: Dimensions.height20 * 5,
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductsControllers>()
                                                  .popularProductsList
                                                  .indexOf(_cartList[index]
                                                      .productModel!);

                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cart-page"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductsControllers>()
                                                    .recommendedProductsList
                                                    .indexOf(_cartList[index]
                                                        .productModel!);

                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "History Product",
                                                      "Product review is not available for history products",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cart-page"));
                                                }
                                              }
                                            },
                                            child: Container(
                                                width: Dimensions.height20 * 5,
                                                height: Dimensions.height20 * 5,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            AppConstants
                                                                    .BASE_URL +
                                                                AppConstants
                                                                    .UPLOAD_URL +
                                                                cartController
                                                                    .getItems[
                                                                        index]
                                                                    .img!)),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      Dimensions.radiusSize20,
                                                    ))),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          Expanded(
                                              child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  color: Colors.black,
                                                ),
                                                SmallText(text: 'Spycy'),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: cartController
                                                          .getItems[index].price
                                                          .toString(),
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions
                                                              .height20,
                                                          bottom: Dimensions
                                                              .height10,
                                                          right: Dimensions
                                                              .width20,
                                                          left: Dimensions
                                                              .width20),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .radiusSize20),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .productModel!,
                                                                    -1);
                                                                //popularProduct.setQuantity(false);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor,
                                                              )),
                                                          SizedBox(
                                                            width: Dimensions
                                                                .width10,
                                                          ),
                                                          BigText(
                                                              text: _cartList[
                                                                      index]
                                                                  .quantity
                                                                  .toString()), //popularProduct.inCartItems.toString()),
                                                          SizedBox(
                                                            width: Dimensions
                                                                .width10,
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .productModel!,
                                                                    1);
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    );
                                  });
                            },
                          )),
                    ))
                : NoDataPage(text: 'Your cart is empty.');
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (CartController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiusSize20 * 2),
                    topRight: Radius.circular(Dimensions.radiusSize20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      right: Dimensions.width20,
                      left: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radiusSize20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      BigText(
                          text: "\$" +
                              " " +
                              CartController.totalAmount.toString()),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Get.find<AuthController>().userIsLoggedIn()) {
                      CartController.addToHistory();
                    } else {
                      Get.toNamed(RouteHelper.getSignInPage());
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        right: Dimensions.width20,
                        left: Dimensions.width20),
                    child: BigText(
                      text: "Check out",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSize20),
                        color: AppColors.mainColor),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
