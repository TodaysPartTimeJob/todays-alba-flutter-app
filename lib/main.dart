import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'config/color/app_color.dart';
import 'config/text_theme/custom_text_theme.dart';
import 'routes/routes.dart';

void main() async {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '${dotenv.get("KAKAO_NATIVE_APP_KEY")}',
    javaScriptAppKey: '${dotenv.get("KAKAO_JAVASCRIPT_APP_KEY")}',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlipFlo App',
      theme: ThemeData(
        textTheme: customTextTheme,
        fontFamily: "pretendard",
        appBarTheme: AppBarTheme(
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: textTheme.headlineSmall!
              .copyWith(color: AppColor.black, fontWeight: FontWeight.w600),
        ),
        primaryColor: const Color(0xFFD11D5C),
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: routes,
    );
  }
}
