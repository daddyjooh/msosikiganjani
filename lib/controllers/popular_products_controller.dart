import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msosikiganjani/controllers/cart_controllers.dart';
import 'package:msosikiganjani/utils/colors.dart';
import '../data/repository/popular_products_repository.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class PopularProductsControllers extends GetxController {
  final PopularProductsRepository popularProductsRepository;

  PopularProductsControllers({required this.popularProductsRepository});

  List<dynamic> _popularProductsList = [];
  List<dynamic> get popularProductsList => _popularProductsList;
  late CartController _cartController;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductsList() async {
    Response response =
        await popularProductsRepository.getPopularProductsList();
    if (response.statusCode == 200) {
      _popularProductsList = [];
      _popularProductsList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

// for increasing and decreasing values in cart
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "You can't reduce more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "You can't add more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel productModel, CartController cartController) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.existInCart(productModel);
    if (exist) {
      _inCartItems = _cartController.getQuantity(productModel);
    }
  }

  void addItem(ProductModel productModel) {
    _cartController.addItem(productModel, _quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(productModel);

    _cartController.items.forEach((key, value) {});

    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
