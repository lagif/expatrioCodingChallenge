import 'package:coding_challenge/api/model/user_info.dart';

sealed class AuthState {}

class AuthLoading implements AuthState {}

class AuthLogOut implements AuthState {}

class AuthError<T> implements AuthState {
  final T error;

  AuthError(this.error);
}

class AuthPending implements AuthState {
  String? previousLogin;

  AuthPending(this.previousLogin);
}

class AuthSuccess implements AuthState {
  final UserInfo userInfo;

  AuthSuccess(this.userInfo);
}
