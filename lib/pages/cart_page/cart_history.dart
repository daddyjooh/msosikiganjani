import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:msosikiganjani/utils/colors.dart';
import 'package:msosikiganjani/widgets/big_text.dart';

import '../../base/no_data.dart';
import '../../controllers/cart_controllers.dart';
import '../../models/cart_model.dart';
import '../../route_helper/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> cartItemsPerOrder = {};
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    for (var i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time.toString(), (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(
            getCartHistoryList[i].time.toString(), () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parsedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parsedDate.toString());
        var outputFormat = DateFormat('MMM/dd/yyyy hh:mm a');
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().length > 0
                ? Expanded(
                    child: Container(
                      //margin: EdgeInsets.all(Dimensions.size20),
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView(
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                //height: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(listCounter),
                                    // BigText(
                                    // text: getCartHistoryList[listCounter].time!),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                getCartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index < 2
                                                ? Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 10,
                                                      right: 5,
                                                      bottom: 10,
                                                    ),
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOAD_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                          }),
                                        ),
                                        SizedBox(
                                          height: 80,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SmallText(
                                                text: 'Total:',
                                              ),
                                              BigText(
                                                text: itemsPerOrder[i]
                                                        .toString() +
                                                    ' items',
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  var orderTime =
                                                      cartOrderTimeToList();
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          getCartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (getCartHistoryList[j]
                                                            .time ==
                                                        orderTime[i]) {
                                                      moreOrder.putIfAbsent(
                                                        getCartHistoryList[j]
                                                            .id!,
                                                        () =>
                                                            CartModel.fromJson(
                                                          jsonDecode(
                                                            jsonEncode(
                                                                getCartHistoryList[
                                                                    j]),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                    border: Border.all(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                  ),
                                                  child: SmallText(
                                                    text: 'One more',
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: NoDataPage(
                        text: 'You did not buy anything',
                        imgPath: 'assets/image/empty_box.png',
                      ),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
