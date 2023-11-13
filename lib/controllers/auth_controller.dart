// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:msosikiganjani/data/repository/auth_repository.dart';
import 'package:msosikiganjani/models/response_model.dart';

import '../models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepository authRepository;

  AuthController({
    required this.authRepository,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepository.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepository.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepository.login(email, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepository.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepository.saveUserNumberAndPassword(number, password);
  }

  bool userIsLoggedIn() {
    return authRepository.userIsLoggedIn();
  }

  bool clearSharedData() {
    return authRepository.clearSharedData();
  }
}
