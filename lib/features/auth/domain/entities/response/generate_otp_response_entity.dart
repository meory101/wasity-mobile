import 'dart:convert';
/// client_id : 1
/// otp_code : 223489
/// updated_at : "2024-07-22T12:28:32.000000Z"
/// created_at : "2024-07-22T12:28:32.000000Z"
/// id : 2

GenerateOtpResponseEntity generateOtpResponseEntityFromJson(String str) => GenerateOtpResponseEntity.fromJson(json.decode(str));
String generateOtpResponseEntityToJson(GenerateOtpResponseEntity data) => json.encode(data.toJson());
class GenerateOtpResponseEntity {
  GenerateOtpResponseEntity({
      num? clientId, 
      num? otpCode, 
      String? updatedAt, 
      String? createdAt, 
      num? id,}){
    _clientId = clientId;
    _otpCode = otpCode;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  GenerateOtpResponseEntity.fromJson(dynamic json) {
    _clientId = json['client_id'];
    _otpCode = json['otp_code'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  num? _clientId;
  num? _otpCode;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
GenerateOtpResponseEntity copyWith({  num? clientId,
  num? otpCode,
  String? updatedAt,
  String? createdAt,
  num? id,
}) => GenerateOtpResponseEntity(  clientId: clientId ?? _clientId,
  otpCode: otpCode ?? _otpCode,
  updatedAt: updatedAt ?? _updatedAt,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
);
  num? get clientId => _clientId;
  num? get otpCode => _otpCode;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_id'] = _clientId;
    map['otp_code'] = _otpCode;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}