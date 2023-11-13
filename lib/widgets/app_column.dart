import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msosikiganjani/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_text_wigdet.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text , size: Dimensions.fontSize26,),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15,)),
            ),
            SizedBox(width: 10,),
            SmallText(text: "5.0"),
            SizedBox(width: 20,),
            SmallText(text: "2345"),
            SizedBox(width: 10,),
            SmallText(text: "Comments")
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),

            IconAndText(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),

            IconAndText(
                icon: Icons.access_time_rounded,
                text: "34Mins",
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
