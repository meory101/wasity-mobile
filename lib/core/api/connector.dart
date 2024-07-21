import 'package:dartz/dartz.dart';
import '../helper/network_helper.dart';
import 'api_error/api_exception.dart';
import 'api_error/api_failures.dart';

//This Connector Class Made To Handel All The States That Can Be Happend When Api Called
//If Server Exception Happened
//If Internet Connection Exception
//If Cahced Data Called And Somthing Wrong Happened
class Connector<T> {
  Future<Either<ApiFailure, T>> connect(
      {required Future<Right<ApiFailure, T>> Function() remote,
      Future<Right<ApiFailure, T>> Function()? cache}) async {
    //Check Internet Connection Function
    final CheckConnectionModel checkConnectionModel =
        await NetworkHelper.checkInternetConnection();
    if (checkConnectionModel.isConnected) {
      try {
        return await remote();
      }

      on ApiServerException catch (error) {
        return Left(ApiServerFailure(response: error.response));
      }
    } else {
      if (cache == null) {
        return Left(OfflineApiFailure(message: checkConnectionModel.message));
      } else {
        try {
            return await cache();
        } on EmptyApiCacheException {
          return Left(EmptyApiCacheFailure());
        }
      }
    }
  }
}
