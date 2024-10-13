import 'dart:convert';

import '../../constant/sns_type.dart';


class SnsLoginInfoState {
  final String? accessToken;
  final SnsType? snsType;

  SnsLoginInfoState({
    this.accessToken,
    this.snsType,
  });

  SnsLoginInfoState copyWith({
    String? accessToken,
    SnsType? snsType,
  }) =>
      SnsLoginInfoState(
        accessToken: accessToken ?? this.accessToken,
        snsType: snsType ?? this.snsType,
      );

  factory SnsLoginInfoState.fromRawJson(String str) => SnsLoginInfoState.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SnsLoginInfoState.fromJson(Map<String, dynamic> json) => SnsLoginInfoState(
    accessToken: json["accessToken"],
    snsType: json["snsType"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "snsType": snsType,
  };
}
