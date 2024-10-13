import 'dart:convert';

class UserInfoResponseModel {
  final String snsId;
  final String snsType;
  final String nickname;
  final String email;
  final double weight;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserInfoResponseModel({
    required this.snsId,
    required this.snsType,
    required this.nickname,
    required this.email,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
  });

  UserInfoResponseModel copyWith({
    String? snsId,
    String? snsType,
    String? nickname,
    String? email,
    double? weight,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserInfoResponseModel(
        snsId: snsId ?? this.snsId,
        snsType: snsType ?? this.snsType,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        weight: weight ?? this.weight,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserInfoResponseModel.fromRawJson(String str) => UserInfoResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) => UserInfoResponseModel(
    snsId: json["snsId"],
    snsType: json["snsType"],
    nickname: json["nickname"],
    email: json["email"],
    weight: json["weight"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "snsId": snsId,
    "snsType": snsType,
    "nickname": nickname,
    "email": email,
    "weight": weight,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
