import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/user/user_repository.dart';
import '../../repository/user/user_repository_impl.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, int>(
  (ref) {
    final homeRepository = ref.watch(userRepositoryImplProvider);
    return HomeViewModel(0, homeRepository);
  },
);

class HomeViewModel extends StateNotifier<int> {
  final UserRepository homeRepository;

  HomeViewModel(super.state, UserRepository homeRepository): homeRepository = homeRepository;

  Future<void> getUserInfo() async{
      var userInfoResponseModel = await homeRepository.getUserInfo();
      print(jsonEncode(userInfoResponseModel));
  }
}
