import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:ieltszone/models/user_model.dart';

class UserStorage {
  final GetStorage _storage = GetStorage();

  static const String _userKey = 'user';

  Future<void> saveUser(User user) async {
    await _storage.write(_userKey, jsonEncode(user.toJson()));
  }

  User? getUser() {
    final userData = _storage.read<String>(_userKey);

    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<void> removeUser() async {
    await _storage.remove(_userKey);
  }
}
