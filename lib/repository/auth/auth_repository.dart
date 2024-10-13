
import '../../model/api/login/login_request_model.dart';
import '../../model/api/login/login_response_model.dart';
import '../../model/api/signup/nickname_duplication_check_request_model.dart';
import '../../model/api/signup/nickname_duplication_check_response_model.dart';
import '../../model/api/signup/signup_request_model.dart';
import '../../model/api/signup/signup_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel requestModel);

  Future<NicknameDuplicationCheckResponseModel> checkNicknameDuplication(NicknameDuplicationCheckRequestModel requestModel);

  Future<SignupResponseModel> signup(SignupRequestModel requestModel);

  Future<void> saveToken(String accessToken, String refreshToken);
}