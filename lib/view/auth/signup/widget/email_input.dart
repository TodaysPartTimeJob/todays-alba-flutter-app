import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_model/auth/signup_view_model.dart';
import '../../../../widget/input/text_input_field.dart';

class EmailInput extends ConsumerWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupViewModelProvider);

    return TextInputField(
      labelName: "이메일",
      hintText: "flip@flo.com",
      onChanged: ref.read(signupViewModelProvider.notifier).onEmailChange,
      isSuccess: signupState.email.isValid,
      statusMessage: signupState.email.stateMessage,
    );
  }
}
