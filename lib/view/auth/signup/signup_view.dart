import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget/email_input.dart';
import 'widget/nickname_input.dart';
import 'widget/signup_button.dart';
import 'widget/weight_input.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("추가정보 입력"),
      ),
      body: Padding(
        padding: EdgeInsets.all(22.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NicknameInput(),
                    SizedBox(height: 9),
                    EmailInput(),
                    SizedBox(height: 9),
                    WeightInput(),
                  ],
                ),
              ),
            ),
            SignupButton(),
          ],
        ),
      ),
    );
  }
}
