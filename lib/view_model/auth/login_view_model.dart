import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../../constant/sns_type.dart';
import '../../exception/custom_exception.dart';
import '../../exception/error_code.dart';
import '../../model/api/login/login_request_model.dart';
import '../../model/api/login/login_response_model.dart';
import '../../repository/auth/auth_repository.dart';
import '../../repository/auth/auth_repository_Impl.dart';
import '../../view/auth/login/login_result.dart';

final loginViewModelProvider = Provider<LoginViewModel>((ref) {
  final authRepository = ref.watch(authRepositoryImplProvider);
  return LoginViewModel(authRepository);
});

class LoginViewModel {
  final AuthRepository authRepository;

  LoginViewModel(this.authRepository);

  Future<LoginResult> loginKakao() async {
    String kakaoAccessToken;

    // 카카오 로그인
    if (await isKakaoTalkInstalled()) {
      kakaoAccessToken = await _loginKakaoWithKakaoTalk();
    } else {
      kakaoAccessToken = await _loginKakaoWithKakaoAccount();
    }

    return await _loginServiceServer(kakaoAccessToken, SnsType.Kakao);
  }


  Future<LoginResult> _loginServiceServer(
      String snsAccessToken, SnsType snsType) async {
    // 서비스 로그인
    try {
      var loginRequestModel = LoginRequestModel(
          accessToken: "Bearer $snsAccessToken", snsType: snsType.name);

      LoginResponseModel responseModel =
          await authRepository.login(loginRequestModel);

      // 서비스 토큰 저장
      authRepository.saveToken(
          responseModel.token.accessToken, responseModel.token.refreshToken);

      // 서비스 로그인 성공
      return LoginResult.success();
    } on CustomException catch (e) {
      return LoginResult.failure(e.errorCode, snsAccessToken);
    }
  }

  Future<String> _loginKakaoWithKakaoTalk() async {
    try {
      OAuthToken oAuthToken = await UserApi.instance.loginWithKakaoTalk();
      return oAuthToken.accessToken;
    } catch (error) {
      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우, 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        throw CustomException(ErrorCode.KakaoLoginCancelByUserError);
      }

      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      return await _loginKakaoWithKakaoAccount();
    }
  }

  Future<String> _loginKakaoWithKakaoAccount() async {
    try {
      OAuthToken oAuthToken = await UserApi.instance.loginWithKakaoAccount();
      return oAuthToken.accessToken;
    } catch (error) {
      throw CustomException(ErrorCode.KakaoLoginFailError);
    }
  }
}
