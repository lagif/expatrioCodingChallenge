import 'dart:convert';

import 'package:coding_challenge/api/model/tax_info.dart';
import 'package:coding_challenge/api/model/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserManager with ChangeNotifier {
  static const _keyLoggedUser = 'user_email';

  final FlutterSecureStorage _secureStorage;

  UserInfo? _loggedInUser;
  TaxInfo? _storedTaxInfo;

  UserManager(
    this._secureStorage,
  );

  UserInfo? getLoggedInUser() {
    return _loggedInUser;
  }

  Future<String?> previouslyLoggedUser() async {
    return await _secureStorage.read(key: _keyLoggedUser);
  }

  Future<TaxInfo?> storedTaxInfo() async {
    if (_loggedInUser == null) {
      return null;
    }
    if (_storedTaxInfo != null) {
      return _storedTaxInfo;
    }
    final info = await _secureStorage.read(key: "${_loggedInUser!.id}");
    if ((info ?? '').isEmpty) {
      return null;
    }
    try {
      return TaxInfo.fromJson(jsonDecode(info!));
    } catch (e) {
      return null;
    }
  }

  Future<void> logOut() async {
    final user = _loggedInUser;
    if (user == null) return;

    await _secureStorage.delete(key: _keyLoggedUser);
    await _secureStorage.delete(key: "${_loggedInUser!.id}");
    _loggedInUser = null;
    _storedTaxInfo = null;
  }

  Future<void> setLoggedInUser(UserInfo user) async {
    await _secureStorage.write(
      key: _keyLoggedUser,
      value: user.subject.email,
    );

    final oldLoggedInUser = _loggedInUser;
    _loggedInUser = user;

    if (oldLoggedInUser == null || oldLoggedInUser.id != user.id) {
      notifyListeners();
    }
  }

  Future<void> setUserTaxInfo(TaxInfo taxInfo) async {
    if (_loggedInUser == null) {
      return;
    }
    try {
      await _secureStorage.write(
        key: "${_loggedInUser!.id}",
        value: json.encode(taxInfo.toJson()),
      );
    } catch (e) {
      return;
    }
  }
}
