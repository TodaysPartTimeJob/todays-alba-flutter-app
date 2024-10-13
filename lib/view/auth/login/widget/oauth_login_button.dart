import 'package:flutter/material.dart';

import '../../../../config/color/app_color.dart';
import '../../../../constant/sns_type.dart';

class OauthLoginButton extends StatelessWidget {
  final SnsType snsType;
  final VoidCallback onTap;

  const OauthLoginButton({
    super.key,
    required this.snsType,
    required this.onTap, // onTap 필수로 받도록 설정
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    String imageSrc = "";
    String buttonDescription = "";
    Color backgroundColor = const Color(0xFFFEE500);
    Color fontColor = AppColor.black;

    switch (snsType) {
      case SnsType.Kakao:
        buttonDescription = "카카오로 시작하기";
        imageSrc = "assets/images/kakao_login_image.png";
        backgroundColor = const Color(0xFFFEE500);
        fontColor = AppColor.black;
        break;

      case SnsType.Naver:
        buttonDescription = "네이버로 시작하기";
        imageSrc = "assets/images/naver_login_image.png";
        backgroundColor = const Color(0xFF03C75A);
        fontColor = AppColor.white;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor, // 배경색 지정
          borderRadius: BorderRadius.circular(6), // radius 지정
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), // 내부 여백 추가
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageSrc, width: 38),
            Expanded(
              // 남은 영역을 Text 위젯에 할당
              child: Text(
                buttonDescription,
                textAlign: TextAlign.center, // 텍스트 중앙 정렬
                style: textTheme.bodyMedium!.copyWith(
                  color: fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
