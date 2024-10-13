import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/api_url.dart';
import '../../constant/token_type.dart';
import '../../model/api/login/login_request_model.dart';
import '../../model/api/login/login_response_model.dart';
import '../../model/api/signup/nickname_duplication_check_request_model.dart';
import '../../model/api/signup/nickname_duplication_check_response_model.dart';
import '../../model/api/signup/signup_request_model.dart';
import '../../model/api/signup/signup_response_model.dart';
import '../../service/api_service.dart';
import '../../service/local_service.dart';
import '../../service/network_api_service.dart';
import '../../service/secure_local_service_impl.dart';
import 'auth_repository.dart';

final authRepositoryImplProvider = Provider<AuthRepository>(
  (ref) {
    final localService = ref.watch(secureLocalServiceImplProvider);
    final apiService = ref.watch(networkApiServiceProvider);
    return AuthRepositoryImpl(apiService, localService);
  },
);

class AuthRepositoryImpl extends AuthRepository {
  final ApiService _apiService;
  final LocalService _localService;

  AuthRepositoryImpl(this._apiService, this._localService);

  @override
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Response<dynamic> response = await _apiService.getPostApiResponse(
        ApiUrl.login,
        data: requestModel,
        headers: {'content-Type': 'application/json'});
    return LoginResponseModel.fromJson(response.data);
  }

  @override
  Future<NicknameDuplicationCheckResponseModel> checkNicknameDuplication(
      NicknameDuplicationCheckRequestModel requestModel) async {
    var response = await _apiService.getPostApiResponse(
      ApiUrl.nicknameDuplicationCheck,
      headers: {'content-Type': 'application/json'},
      data: requestModel,
    );

    return NicknameDuplicationCheckResponseModel.fromJson(response.data);
  }

  @override
  Future<SignupResponseModel> signup(SignupRequestModel requestModel) async {
    var response = await _apiService.getPostApiResponse(
      ApiUrl.signup,
      data: requestModel,
      headers: {'content-Type': 'application/json'},
    );

    return SignupResponseModel.fromJson(response.data);
  }

  @override
  Future<void> saveToken(String accessToken, String refreshToken) async {
    await _localService.save(TokenType.accessToken.name, accessToken);
    await _localService.save(TokenType.refreshToken.name, refreshToken);
  }
}
