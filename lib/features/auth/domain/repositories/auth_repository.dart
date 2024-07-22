import 'package:dartz/dartz.dart';
import 'package:wasity/features/auth/domain/entities/request/generate_otp_request_entity.dart';
import 'package:wasity/features/auth/domain/entities/response/generate_otp_response_entity.dart';
import '../../../../core/api/api_error/api_failures.dart';



abstract class AuthRepository {
  Future<Either<ApiFailure, GenerateOtpResponseEntity>> generateOtp(
      {required GenerateOtpRequestEntity entity});


}
