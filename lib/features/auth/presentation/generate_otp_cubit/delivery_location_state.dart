
import 'package:equatable/equatable.dart';
import 'package:wasity/features/auth/domain/entities/response/generate_otp_response_entity.dart';

import '../../../../core/resource/cubit_status_manager.dart';

class GenerateOtpState extends Equatable {
  final String error;
  final GenerateOtpResponseEntity entity;
  final CubitStatus status;

  const GenerateOtpState({
    required this.error,
    required this.entity,
    required this.status,
  });

  factory GenerateOtpState.initial() {
    return  GenerateOtpState(
        entity:GenerateOtpResponseEntity(),
        error: '',
        status: CubitStatus.initial);
  }

  @override
  bool get stringify => true;

  GenerateOtpState copyWith({
    String? error,
    GenerateOtpResponseEntity? entity,
    CubitStatus? status,
  }) {
    return GenerateOtpState(
      error: error ?? this.error,
      entity: entity ?? this.entity,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props {
    return [error, status, entity];
  }
}
