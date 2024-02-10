import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coding_challenge/api/services/user_manager.dart';
import 'package:coding_challenge/auth/cubits/auth_state.dart';
import 'package:coding_challenge/auth/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final UserManager userManager;

  AuthCubit({required this.authRepository, required this.userManager})
      : super(AuthPending(null));

  Future<void> load() async {
    final loggedUser = userManager.getLoggedInUser();
    if (loggedUser != null) {
      emit(AuthSuccess(loggedUser));
      return;
    }

    final previousAuthUser = await userManager.previouslyLoggedUser();
    if (previousAuthUser != null && previousAuthUser.isNotEmpty) {
      emit(AuthPending(previousAuthUser));
    }

    userManager.addListener(() {
      if (userManager.getLoggedInUser() == null) {
        emit(AuthLogOut());
      }
    });
  }

  Future<void> logIn(String login, String password) async {
    emit(AuthLoading());
    try {
      final userInfo = await authRepository.logIn(login, password);
      userManager.setLoggedInUser(userInfo);
      emit(AuthSuccess(userInfo));
    } catch (e) {
      emit(AuthError(e));
    }
  }
}
