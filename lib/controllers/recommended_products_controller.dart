import 'package:get/get.dart';
import '../data/repository/popular_products_repository.dart';
import '../data/repository/recommended_products_repository.dart';
import '../models/product_model.dart';


class RecommendedProductsControllers extends GetxController {
  final RecommendedProductsRepository recommendedProductsRepository;

  RecommendedProductsControllers({required this.recommendedProductsRepository});

  List<dynamic> _recommendedProductsList = [];
  List<dynamic> get recommendedProductsList => _recommendedProductsList;

  bool _isLoaded = false;
  bool  get isLoaded => _isLoaded;

  Future<void> getRecommendedProductsList()async {
    Response response = await recommendedProductsRepository.getRecommendedProductsList();
    if(response.statusCode == 200){
      _recommendedProductsList = [];
      _recommendedProductsList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
    else{

    }
  }

}