import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class LoginRequestModel {
  final String accessToken;
  final String snsType;

  LoginRequestModel({
    required this.accessToken,
    required this.snsType,
  });

  LoginRequestModel copyWith({
    String? accessToken,
    String? snsType,
  }) =>
      LoginRequestModel(
        accessToken: accessToken ?? this.accessToken,
        snsType: snsType ?? this.snsType,
      );

  factory LoginRequestModel.fromRawJson(String str) => LoginRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => LoginRequestModel(
    accessToken: json["accessToken"],
    snsType: json["snsType"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "snsType": snsType,
  };
}
