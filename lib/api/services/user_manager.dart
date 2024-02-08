import 'package:coding_challenge/api/model/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserManager with ChangeNotifier {
  static const _keyLoggedUser = 'user_email';

  final FlutterSecureStorage _secureStorage;

  UserInfo? _loggedInUser;

  UserManager(
    this._secureStorage,
  );

  UserInfo? getLoggedInUser() {
    return _loggedInUser;
  }

  Future<String?> previouslyLoggedUser() async {
    return await _secureStorage.read(key: _keyLoggedUser);
  }

  Future<void> logOut() async {
    final user = _loggedInUser;
    if (user == null) return;

    //ToDo: correct logout (remove all the keys we stored there)
    await _secureStorage.delete(key: _keyLoggedUser);
  }

  Future<void> setLoggedInUser(UserInfo user) async {
    await _secureStorage.write(
      key: _keyLoggedUser,
      value: user.email,
    );

    final oldLoggedInUser = _loggedInUser;
    _loggedInUser = user;

    if (oldLoggedInUser == null || oldLoggedInUser.id != user.id) {
      notifyListeners();
    }
  }
}
