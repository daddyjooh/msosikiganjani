import 'package:flutter/material.dart';
import 'package:msosikiganjani/utils/colors.dart';
import 'package:msosikiganjani/utils/dimensions.dart';
import 'package:msosikiganjani/widgets/big_text.dart';
import 'package:msosikiganjani/widgets/small_text.dart';

import 'food_page.dart';

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({Key? key}) : super(key: key);

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        //topSection
        Container(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'Tanzania',
                      color: AppColors.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(text: 'Dodoma', color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSize15),
                        color: AppColors.mainColor),
                  ),
                )
              ],
            ),
          ),
        ),
        //body
        Expanded(
            child: SingleChildScrollView(
          child: FoodPage(),
        ))
      ],
    ));
  }
}
