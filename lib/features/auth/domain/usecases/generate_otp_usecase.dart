import 'package:dartz/dartz.dart';
import 'package:wasity/features/auth/domain/entities/request/generate_otp_request_entity.dart';
import 'package:wasity/features/auth/domain/entities/response/generate_otp_response_entity.dart';
import 'package:wasity/features/auth/domain/repositories/auth_repository.dart';
import '../../../../core/api/api_error/api_failures.dart';



class GenerateOtpUseCase {
  final AuthRepository repository;
  GenerateOtpUseCase({
    required this.repository,
  });
  Future<Either<ApiFailure, GenerateOtpResponseEntity>> call(
      {required GenerateOtpRequestEntity entity}) {
    return repository.generateOtp(entity: entity);
  }
}
