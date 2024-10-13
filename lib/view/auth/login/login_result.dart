import '../../../exception/error_code.dart';

class LoginResult {
  final bool isSuccess;
  ErrorCode? errorCode;
  String? accessToken;

  LoginResult.success() : isSuccess = true;

  LoginResult.failure(this.errorCode, this.accessToken) : isSuccess = false;
}
