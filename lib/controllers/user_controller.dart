import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:msosikiganjani/data/repository/user_repository.dart';
import 'package:msosikiganjani/models/user_model.dart';

import '../models/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepository userRepository;

  UserController({
    required this.userRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late UserModel _userModel;

  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepository.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _isLoading = true;
      _userModel = UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, 'successfully');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    
    _isLoading = true;
    update();
    return responseModel;
  }
}
