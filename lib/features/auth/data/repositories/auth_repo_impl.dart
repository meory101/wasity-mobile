import 'package:dartz/dartz.dart';
import 'package:wasity/core/api/api_error/api_failures.dart';
import 'package:wasity/core/api/connector.dart';
import 'package:wasity/features/auth/data/remote/auth_remote.dart';
import 'package:wasity/features/auth/domain/entities/request/generate_otp_request_entity.dart';
import 'package:wasity/features/auth/domain/entities/response/generate_otp_response_entity.dart';
import 'package:wasity/features/auth/domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemote remote;

  AuthRepoImpl({
    required this.remote,
  });

  @override
  Future<Either<ApiFailure, GenerateOtpResponseEntity>> generateOtp(
      {required GenerateOtpRequestEntity entity}) {
    return Connector<GenerateOtpResponseEntity>().connect(
      remote: () async {
        final result = await remote.generateOtp(entity: entity);
        return Right(result);
      },
    );
  }

}