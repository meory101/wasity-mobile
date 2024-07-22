import 'package:get_it/get_it.dart';
import 'package:wasity/features/auth/data/remote/auth_remote.dart';
import 'package:wasity/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:wasity/features/auth/domain/repositories/auth_repository.dart';
import 'package:wasity/features/auth/domain/usecases/generate_otp_usecase.dart';
import 'package:wasity/features/auth/presentation/generate_otp_cubit/delivery_location_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => GenerateOtpCubit(usecase: sl()));
  sl.registerLazySingleton(() => GenerateOtpUseCase(repository: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(remote: sl()));
  sl.registerLazySingleton<AuthRemote>(() => AuthRemoteImpl());
}