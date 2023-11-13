import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msosikiganjani/controllers/popular_products_controller.dart';
import 'package:msosikiganjani/route_helper/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/cart_controllers.dart';
import 'controllers/recommended_products_controller.dart';
import 'data/repository/cart_repository.dart';
import 'helper/dependencies.dart' as dependency;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency.init();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  Get.put(CartController(
      cartRepository: CartRepository(sharedPreferences: sharedPreferences)));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductsControllers>(builder: (_) {
      return GetBuilder<RecommendedProductsControllers>(
        builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            //home: FoodHomePage(),
            initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
          );
        },
      );
    });
  }
}
