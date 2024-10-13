import 'dart:convert';

class SignupState {
  final StringInput nickname;
  final StringInput email;
  final StringInput weight;

  SignupState({
    required this.nickname,
    required this.email,
    required this.weight,
  });

  SignupState copyWith({
    String? accessToken,
    StringInput? nickname,
    StringInput? email,
    StringInput? weight,
  }) =>
      SignupState(
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        weight: weight ?? this.weight,
      );

  factory SignupState.fromRawJson(String str) =>
      SignupState.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupState.fromJson(Map<String, dynamic> json) => SignupState(
        nickname: StringInput.fromJson(json["nickname"]),
        email: StringInput.fromJson(json["email"]),
        weight: StringInput.fromJson(json["weight"]),
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname.toJson(),
        "email": email.toJson(),
        "weight": weight.toJson(),
      };

  SignupState.init()
      : nickname = StringInput.init(),
        email = StringInput.init(),
        weight = StringInput.init();
}

class StringInput {
  final String value;
  final bool isValid;
  final String stateMessage;

  StringInput({
    required this.value,
    required this.isValid,
    required this.stateMessage,
  });

  StringInput copyWith({
    String? value,
    bool? isValid,
    String? stateMessage,
  }) =>
      StringInput(
        value: value ?? this.value,
        isValid: isValid ?? this.isValid,
        stateMessage: stateMessage ?? this.stateMessage,
      );

  factory StringInput.fromRawJson(String str) =>
      StringInput.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StringInput.fromJson(Map<String, dynamic> json) => StringInput(
        value: json["value"],
        isValid: json["isValid"],
        stateMessage: json["stateMessage"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "isValid": isValid,
        "stateMessage": stateMessage,
      };

  StringInput.init()
      : value = "",
        isValid = false,
        stateMessage = "";
}

// class DoubleInput {
//   final double value;
//   final bool isValid;
//   final String stateMessage;
//
//   DoubleInput({
//     required this.value,
//     required this.isValid,
//     required this.stateMessage,
//   });
//
//   DoubleInput copyWith({
//     double? value,
//     bool? isValid,
//     String? stateMessage,
//   }) =>
//       DoubleInput(
//         value: value ?? this.value,
//         isValid: isValid ?? this.isValid,
//         stateMessage: stateMessage ?? this.stateMessage,
//       );
//
//   factory DoubleInput.fromRawJson(String str) =>
//       DoubleInput.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory DoubleInput.fromJson(Map<String, dynamic> json) => DoubleInput(
//         value: json["value"]?.toDouble(),
//         isValid: json["isValid"],
//         stateMessage: json["stateMessage"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "value": value,
//         "isValid": isValid,
//         "stateMessage": stateMessage,
//       };
//
//   DoubleInput.init()
//       : value = 0,
//         isValid = false,
//         stateMessage = "";
// }
