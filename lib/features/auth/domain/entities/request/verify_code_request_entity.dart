import 'dart:convert';
/// number : "0991223333"
/// type : 0
/// otp_code : "ff"

VerifyCodeRequestEntity verifyCodeRequestEntityFromJson(String str) => VerifyCodeRequestEntity.fromJson(json.decode(str));
String verifyCodeRequestEntityToJson(VerifyCodeRequestEntity data) => json.encode(data.toJson());
class VerifyCodeRequestEntity {
  VerifyCodeRequestEntity({
      String? number, 
      num? type, 
      String? otpCode,}){
    _number = number;
    _type = type;
    _otpCode = otpCode;
}

  VerifyCodeRequestEntity.fromJson(dynamic json) {
    _number = json['number'];
    _type = json['type'];
    _otpCode = json['otp_code'];
  }
  String? _number;
  num? _type;
  String? _otpCode;
VerifyCodeRequestEntity copyWith({  String? number,
  num? type,
  String? otpCode,
}) => VerifyCodeRequestEntity(  number: number ?? _number,
  type: type ?? _type,
  otpCode: otpCode ?? _otpCode,
);
  String? get number => _number;
  num? get type => _type;
  String? get otpCode => _otpCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = _number;
    map['type'] = _type;
    map['otp_code'] = _otpCode;
    return map;
  }

}