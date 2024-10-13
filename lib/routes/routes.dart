import 'package:flutter/material.dart';

import '../view/auth/home/home_view.dart';
import '../view/auth/login/login_view.dart';
import '../view/auth/signup/signup_view.dart';
import '../view/auth/signup_success/signup_success_view.dart';
import '../view/splash/splash_view.dart';

final routes = {
  '/': (BuildContext content) => SplashView(),
  'login_view': (BuildContext content) => LoginView(),
  'signup_view': (BuildContext content) => SignupView(),
  'signup_success_view': (BuildContext content) => SignupSuccessView(),
  'home_view': (BuildContext content) => HomeView(),
};

class RoutesName {
  static const String splash = '/';

  static const String login = 'login_view';

  static const String signup = 'signup_view';

  static const String signupSuccess = 'signup_success_view';

  static const String home = 'home_view';
}