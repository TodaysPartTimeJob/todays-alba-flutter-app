import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_model/auth/signup_view_model.dart';
import '../../../../widget/input/number_input_field.dart';

class WeightInput extends ConsumerWidget {
  const WeightInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupViewModelProvider);

    return NumberInputField(
      labelName: "몸무게(kg)",
      hintText: "60",
      onChanged: ref.read(signupViewModelProvider.notifier).onWeightChange,
      isSuccess: signupState.weight.isValid,
      statusMessage: signupState.weight.stateMessage,
    );
  }
}
