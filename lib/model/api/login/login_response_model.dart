import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class LoginResponseModel {
  final String message;
  final Token token;

  LoginResponseModel({
    required this.message,
    required this.token,
  });

  LoginResponseModel copyWith({
    String? message,
    Token? token,
  }) =>
      LoginResponseModel(
        message: message ?? this.message,
        token: token ?? this.token,
      );

  factory LoginResponseModel.fromRawJson(String str) => LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    message: json["message"],
    token: Token.fromJson(json["token"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token.toJson(),
  };
}

@immutable
class Token {
  final String accessToken;
  final String refreshToken;

  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  Token copyWith({
    String? accessToken,
    String? refreshToken,
  }) =>
      Token(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory Token.fromRawJson(String str) => Token.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
