import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../config/color/app_color.dart';

class FlipfloDescription extends StatelessWidget {
  const FlipfloDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // 세로 방향 가운데 정렬
      children: [
        Text(
          "플립플로",
          style: textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold, color: AppColor.primaryColor, fontFamily: "HancomMalangMalang"),
        ),
        const SizedBox(height: 8), // 텍스트 간 간격 추가
        Text(
          "거리를 뒤집는 작은 한 걸음",
          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, fontFamily: "HancomMalangMalang"),
        ),
      ],
    );
  }
}
