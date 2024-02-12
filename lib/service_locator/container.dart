import 'package:coding_challenge/api/client/api_client.dart';
import 'package:coding_challenge/api/services/user_manager.dart';
import 'package:coding_challenge/auth/cubits/auth_cubit.dart';
import 'package:coding_challenge/auth/repository/auth_repository.dart';
import 'package:coding_challenge/tax_info/cubits/tax_info_cubit.dart';
import 'package:coding_challenge/tax_info/repository/tax_info_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///
/// GetIt service locator is great for the dependency injections
/// and registering global scope singletons.
/// The user manager and other services and blocs
/// are global and depend on globals
/// so they can be registered here to reuse
///
final GetIt container = GetIt.instance;

Future<void> setupContainer() async {
  container.registerLazySingleton<ApiClient>(
    () => ApiClient(Dio()),
  );

  container.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  container.registerLazySingleton<UserManager>(() {
    return UserManager(
      container.get<FlutterSecureStorage>(),
    );
  });

  container.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiClient: container.get<ApiClient>(),
    ),
  );

  container.registerFactory<AuthCubit>(
    () => AuthCubit(
      authRepository: container.get<AuthRepository>(),
      userManager: container.get<UserManager>(),
    ),
  );

  container.registerLazySingleton<TaxInfoRepository>(
    () => TaxInfoRepositoryImpl(
      apiClient: container.get<ApiClient>(),
    ),
  );

  container.registerFactory<TaxInfoCubit>(
    () => TaxInfoCubit(
      taxInfoRepository: container.get<TaxInfoRepository>(),
      userManager: container.get<UserManager>(),
    ),
  );
}
