import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/utils.dart';
import '../../../../constant/sns_type.dart';
import '../../../../exception/error_code.dart';
import '../../../../routes/routes.dart';
import '../../../../view_model/auth/login_view_model.dart';
import '../../../../view_model/auth/sns_login_info_provider.dart';
import '../login_result.dart';
import 'oauth_login_button.dart';

class OauthLoginButtons extends ConsumerWidget {
  const OauthLoginButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginViewModel = ref.read(loginViewModelProvider);

    void handleNaverButtonClick() async{
    }

    void handleKakaoButtonClick() async {
      LoginResult loginResult = await loginViewModel.loginKakao();

      if (!loginResult.isSuccess){
        if (loginResult.errorCode == ErrorCode.UserNotFoundError) {
          ref.read(snsLoginInfoProvider.notifier).updateSnsLoginInfo(loginResult.accessToken!, SnsType.Kakao);
          Navigator.of(context).popAndPushNamed(RoutesName.signup);
          return;
        } else {
          print(loginResult.errorCode?.message);
          Utils.toastMessage("예상치 못한 오류가 발생하였습니다");
          return;
        }
      }

      Navigator.of(context).popAndPushNamed(RoutesName.home);
      return;
    }

    return Column(
      children: [
        OauthLoginButton(onTap: handleNaverButtonClick, snsType: SnsType.Naver),
        SizedBox(height: 14),
        OauthLoginButton(onTap: handleKakaoButtonClick, snsType: SnsType.Kakao),
      ],
    );
  }
}
