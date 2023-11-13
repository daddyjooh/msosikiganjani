import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:msosikiganjani/data/api/api_client.dart';
import 'package:msosikiganjani/utils/app_constants.dart';

class RecommendedProductsRepository extends GetxService{
  final ApiClient apiClient;

  RecommendedProductsRepository({required this.apiClient});

  Future<Response> getRecommendedProductsList()async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCTS_URI);
  }
}