import 'package:get/get.dart';
import 'package:msosikiganjani/pages/Splash/splash_screen.dart';
import 'package:msosikiganjani/pages/authentication/sign_in_page.dart';
import 'package:msosikiganjani/pages/cart_page/cart_view.dart';
import 'package:msosikiganjani/pages/food/popular_food_details.dart';
import 'package:msosikiganjani/pages/food/recomended_food_details.dart';

import '../pages/home/home_view.dart';

class RouteHelper {
  static const String splashScreen = "/splashScreen";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommended = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";

  static String getSplashScreen() => "$splashScreen";
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommended?pageId=$pageId&page=$page';
  static String getInitial() => '$initial';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return HomeView();
        }),
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fade),
    GetPage(
        name: recommended,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(
              pageId: int.parse(pageId!), page: page!);
        }),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetails(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
