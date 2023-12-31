import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageViewContainer = screenHeight / 3.84;
  static double cardView = screenHeight / 2.64;
  static double pageViewTextContainer = screenHeight / 7.03;

  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;
  static double height15 = screenHeight / 56.27;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  static double width10 = screenHeight / 84.4;
  static double width20 = screenHeight / 42.2;
  static double width15 = screenHeight / 56.27;
  static double width30 = screenHeight / 28.13;
  static double width45 = screenHeight / 18.76;

//fontSize
  static double fontSize16 = screenHeight / 52.75;
  static double fontSize20 = screenHeight / 42.2;
  static double fontSize26 = screenHeight / 32.46;

  static double radiusSize20 = screenHeight / 42.2;
  static double radiusSize30 = screenHeight / 28.13;
  static double radiusSize15 = screenHeight / 56.27;

  //Icon Size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  //listView Size 390
  static double listViewImageSize = screenWidth / 3.25;
  static double listViewTextContainer = screenWidth / 3.9;

  //popular foods
  static double popularFoodsImageSize = screenHeight / 2.41;

  //bottom height
  static double bottomHeightBar = screenHeight / 7.0;

  //splashScreen Image
  static double splashImage = screenHeight / 3.375;
}
