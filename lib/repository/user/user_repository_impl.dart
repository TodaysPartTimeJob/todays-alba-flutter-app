import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/api_url.dart';
import '../../model/api/user/user_info_response_model.dart';
import '../../service/api_service.dart';
import '../../service/authentication_network_api_service.dart';
import 'user_repository.dart';

final userRepositoryImplProvider = Provider<UserRepository>(
      (ref) {
    final apiService = ref.watch(authenticationNetworkApiServiceProvider);
    return UserRepositoryImpl(apiService);
  },
);

class UserRepositoryImpl extends UserRepository {
  final ApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<UserInfoResponseModel> getUserInfo() async {
    var response = await _apiService.getGetApiResponse(ApiUrl.userInfoGet);
    return UserInfoResponseModel.fromJson(response.data);
  }
}