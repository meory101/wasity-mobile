import 'dart:convert';
/// number : "0991223333"
/// type : 0

GenerateOtpRequestEntity generateOtpRequestEntityFromJson(String str) => GenerateOtpRequestEntity.fromJson(json.decode(str));
String generateOtpRequestEntityToJson(GenerateOtpRequestEntity data) => json.encode(data.toJson());
class GenerateOtpRequestEntity {
  GenerateOtpRequestEntity({
      String? number, 
      num? type,}){
    _number = number;
    _type = type;
}

  GenerateOtpRequestEntity.fromJson(dynamic json) {
    _number = json['number'];
    _type = json['type'];
  }
  String? _number;
  num? _type;
GenerateOtpRequestEntity copyWith({  String? number,
  num? type,
}) => GenerateOtpRequestEntity(  number: number ?? _number,
  type: type ?? _type,
);
  String? get number => _number;
  num? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = _number;
    map['type'] = _type;
    return map;
  }

}