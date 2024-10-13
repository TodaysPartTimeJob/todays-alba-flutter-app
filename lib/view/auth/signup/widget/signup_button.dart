import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../exception/custom_exception.dart';
import '../../../../exception/error_code.dart';
import '../../../../routes/routes.dart';
import '../../../../view_model/auth/signup_view_model.dart';
import '../../../../widget/button/big_rounded_large_button.dart';
import '../../../error/api_error_view_resolver.dart';

class SignupButton extends ConsumerWidget {
  const SignupButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void moveSignupSuccessPage() {
      Navigator.of(context).popAndPushNamed(RoutesName.signupSuccess);
    }

    void handleApiError(ErrorCode errorCode) {
      ApiErrorViewResolver(context).resolve(errorCode);
    }

    return BigRoundedLargeButton(
      buttonName: "확인",
      isActivate: true,
      onTap: () async {
        try {
          if (await ref
              .read(signupViewModelProvider.notifier)
              .submitAdditionalInfo()) {
            moveSignupSuccessPage();
          }
        } on CustomException catch (e) {
          handleApiError(e.errorCode);
        } catch (e) {
          handleApiError(ErrorCode.UnknownError);
        }
      },
    );
  }
}
