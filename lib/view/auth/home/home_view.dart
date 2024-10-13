import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../exception/custom_exception.dart';
import '../../../exception/error_code.dart';
import '../../../view_model/home/home_view_model.dart';
import '../../error/api_error_view_resolver.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleApiError(ErrorCode errorCode) {
      var apiErrorViewResolver = ApiErrorViewResolver(context);
      apiErrorViewResolver.resolve(errorCode);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("홈"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await ref.read(homeViewModelProvider.notifier).getUserInfo();
            } on CustomException catch (e) {
              handleApiError(e.errorCode);
            } catch (e) {
              handleApiError(ErrorCode.UnknownError);
            }
          },
          child: Text("회원정보 불러오기"),
        ),
      ),
    );
  }
}
