import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:wasity/features/auth/domain/entities/request/generate_otp_request_entity.dart';
import 'package:wasity/features/auth/domain/usecases/generate_otp_usecase.dart';
import 'package:wasity/features/auth/presentation/generate_otp_cubit/delivery_location_state.dart';
import '../../../../../core/api/api_error/api_error.dart';
import '../../../../core/resource/cubit_status_manager.dart';

class GenerateOtpCubit extends Cubit<GenerateOtpState> {
  final GenerateOtpUseCase usecase;

  GenerateOtpCubit({
    required this.usecase,
  }) : super(GenerateOtpState.initial());

  getDeliveryInformation(
      {required BuildContext buildContext,
      required GenerateOtpRequestEntity entity}) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await usecase(entity: entity);
    //!Check if Bloc Closed
    if (isClosed) return;
    result.fold(
      (failure) async {
        final ErrorEntity errorEntity = await ApiErrorHandler.mapFailure(
            buildContext: buildContext, failure: failure);
        emit(state.copyWith(
            error: errorEntity.errorMessage, status: CubitStatus.error));
      },
      (data) {
        emit(
          state.copyWith(
            status: CubitStatus.success,
            entity: data
          ),
        );
      },
    );
  }
}
