import 'package:get/get.dart';
import 'package:msosikiganjani/controllers/auth_controller.dart';
import 'package:msosikiganjani/controllers/cart_controllers.dart';
import 'package:msosikiganjani/controllers/user_controller.dart';
import 'package:msosikiganjani/data/repository/auth_repository.dart';
import 'package:msosikiganjani/data/repository/cart_repository.dart';
import 'package:msosikiganjani/data/repository/user_repository.dart';
import 'package:msosikiganjani/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/popular_products_controller.dart';
import '../controllers/recommended_products_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/popular_products_repository.dart';
import '../data/repository/recommended_products_repository.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepository(
        apiClient: Get.find(),
      ));

  //repo
  Get.lazyPut(() => PopularProductsRepository(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductsRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepository(sharedPreferences: Get.find()));

  //controller
  Get.lazyPut(
      () => PopularProductsControllers(popularProductsRepository: Get.find()));
  Get.lazyPut(() => UserController(userRepository: Get.find()));
  Get.lazyPut(() => RecommendedProductsControllers(
      recommendedProductsRepository: Get.find()));
  Get.lazyPut(() => CartController(cartRepository: Get.find()));
  Get.lazyPut(() => AuthController(authRepository: Get.find()));
}
