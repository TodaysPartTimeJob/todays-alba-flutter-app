import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../exception/custom_exception.dart';
import '../../exception/error_code.dart';
import '../../model/api/user/user_info_response_model.dart';
import '../../routes/routes.dart';
import '../../view_model/splash/splash_view_model.dart';
import '../error/api_error_view_resolver.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserInfoResponseModel> userInfo =
        ref.watch(splashViewModelProvider);

    // 에러 처리 함수
    void handleApiError(ErrorCode errorCode) {
      var apiErrorViewResolver = ApiErrorViewResolver(context);
      apiErrorViewResolver.updateHandler(
        ErrorCode.NoTokenError,
        () {
          Navigator.of(context).pushReplacementNamed(RoutesName.login);
        },
      );
      apiErrorViewResolver.updateHandler(
        ErrorCode.TokenReissueError,
        () {
          Navigator.of(context).pushReplacementNamed(RoutesName.login);
        },
      );
      apiErrorViewResolver.resolve(errorCode);
    }

    return Scaffold(
      body: userInfo.when(
        data: (user) {
          // 기존에 로그인을 한 경우 홈화면 이동
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(RoutesName.home);
          });
          return const Center(child: CircularProgressIndicator());
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (error is CustomException) {
              handleApiError(error.errorCode);
            } else {
              handleApiError(ErrorCode.UnknownError);
            }
          });

          return SizedBox();
        },
      ),
    );
  }
}
