import 'package:wasity/core/api/api_error/api_exception.dart';
import 'package:wasity/core/api/api_error/api_status_code.dart';
import 'package:wasity/core/api/api_links.dart';
import 'package:wasity/core/api/api_methods.dart';
import 'package:wasity/features/auth/domain/entities/request/generate_otp_request_entity.dart';
import 'package:wasity/features/auth/domain/entities/request/verify_code_request_entity.dart';
import 'package:wasity/features/auth/domain/entities/response/generate_otp_response_entity.dart';
import 'package:wasity/features/auth/domain/entities/response/verify_code_response_entity.dart';

abstract class AuthRemote {
  Future<GenerateOtpResponseEntity> generateOtp(
      {required GenerateOtpRequestEntity entity});

  // Future<VerifyCodeResponseEntity> verifyCode(
  //     {required VerifyCodeRequestEntity entity});

}

class AuthRemoteImpl extends AuthRemote {
  @override
  Future<GenerateOtpResponseEntity> generateOtp(
      {required GenerateOtpRequestEntity entity}) async {
    final response = await ApiMethods()
        .post(url: ApiPostUrl.generateOtp, body: entity.toJson());


    if (ApiStatusCode.success().contains(response.statusCode)) {
      return generateOtpResponseEntityFromJson(response.body);
    } else {
      throw ApiServerException(response: response);
    }
  }

  // @override
  // Future<VerifyCodeResponseEntity> verifyCode({required VerifyCodeRequestEntity entity}) async{
  //   final response = await ApiMethods()
  //       .post(url: ApiPostUrl.generateOtp, body: entity.toJson());
  //
  //
  //   if (ApiStatusCode.success().contains(response.statusCode)) {
  //     return generateOtpResponseEntityFromJson(response.body);
  //   } else {
  //     throw ApiServerException(response: response);
  //   }
  // }


}