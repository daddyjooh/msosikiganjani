// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:msosikiganjani/data/api/api_client.dart';
import 'package:msosikiganjani/utils/app_constants.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository({
    required this.apiClient,
  });

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }
}
