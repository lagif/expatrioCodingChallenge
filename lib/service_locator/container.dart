import 'package:coding_challenge/api/client/api_client.dart';
import 'package:coding_challenge/api/services/user_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
