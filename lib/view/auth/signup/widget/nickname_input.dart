import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_model/auth/signup_view_model.dart';
import '../../../../widget/input/text_input_field_with_button.dart';

class NicknameInput extends ConsumerWidget {
  const NicknameInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupViewModelProvider);

    return TextInputFieldWithButton(
      hintText: "닉네임",
      labelName: "닉네임",
      buttonName: "중복 확인",
      isSuccess: signupState.nickname.isValid,
      statusMessage: signupState.nickname.stateMessage,
      onButtonTap: ref
          .read(signupViewModelProvider.notifier)
          .onTapNicknameCheckButton,
      onTextChanged: ref
          .read(signupViewModelProvider.notifier)
          .onNicknameChange,
    );
  }
}
