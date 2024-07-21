// To parse this JSON data, do
//
//     final errorResponseEntite = errorResponseEntiteFromJson(jsonString);

import 'dart:convert';

ErrorResponseEntity errorResponseEntityFromJson(String str) =>
    ErrorResponseEntity.fromJson(json.decode(str));

class ErrorResponseEntity {
  final int errorCode;
  final String message;

  ErrorResponseEntity({
    required this.errorCode,
    required this.message,
  });

  factory ErrorResponseEntity.fromRawJson(String str) =>
      ErrorResponseEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponseEntity.fromJson(Map<String, dynamic> json) =>
      ErrorResponseEntity(
        errorCode: json["code"] ?? 0,
        message: json["error"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "code": errorCode,
        "error": message,
      };
}
