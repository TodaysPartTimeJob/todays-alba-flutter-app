import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/api/user/user_info_response_model.dart';
import '../../repository/user/user_repository.dart';
import '../../repository/user/user_repository_impl.dart';


final splashViewModelProvider =
    AsyncNotifierProvider<SplashViewModel, UserInfoResponseModel>(
  SplashViewModel.new,
);

class SplashViewModel extends AsyncNotifier<UserInfoResponseModel> {
  late UserRepository userRepository;

  @override
  Future<UserInfoResponseModel> build() async {
    userRepository = ref.watch(userRepositoryImplProvider);
    return await userRepository.getUserInfo();
  }
}
