import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/sns_type.dart';
import '../../model/state/sns_login_info_state.dart';

final snsLoginInfoProvider = StateNotifierProvider<SnsLoginInfo, SnsLoginInfoState>((ref) {
  return SnsLoginInfo(SnsLoginInfoState());
});

class SnsLoginInfo extends StateNotifier<SnsLoginInfoState> {
  SnsLoginInfo(super.state);

  void updateSnsLoginInfo(String accessToken, SnsType snsType) {
    state = state.copyWith(accessToken: accessToken, snsType: snsType);
  }

  bool validateAccessToken() {
    if(state.accessToken != null && state.snsType != null) return true;
    return false;
  }
}

