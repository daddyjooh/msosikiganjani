import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:msosikiganjani/route_helper/route_helper.dart';
import 'package:msosikiganjani/utils/dimensions.dart';

import '../../controllers/popular_products_controller.dart';
import '../../controllers/recommended_products_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  Future<void> _loadResource() async {
    await Get.find<PopularProductsControllers>().getPopularProductsList();
    await Get.find<RecommendedProductsControllers>()
        .getRecommendedProductsList();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);

    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));

    _loadResource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
            child: Image.asset(
          "assets/image/logo part 1.png",
          width: Dimensions.splashImage,
        )),
        Center(
            child: Image.asset(
          "assets/image/logo part 2.png",
          width: Dimensions.splashImage,
        ))
      ]),
    );
  }
}
