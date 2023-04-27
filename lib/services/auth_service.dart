import 'package:flat_bloc_flutter/api/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/pref_keys.dart';
import 'persistence_service.dart';

class AuthService {
  static final AuthService _manager = AuthService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  factory AuthService() => _manager;

  Future<bool> isAuthenticated() async {
    return await _manager._storage.read(key: PrefKeys.token) != null;
  }

  Future<String?> getToken() async {
    return await _manager._storage.read(key: PrefKeys.token);
  }

  Future<User> getUser() async {
    User user = User(
        firstName: await _manager._storage.read(key: PrefKeys.firstName) ?? "",
        lastName: await _manager._storage.read(key: PrefKeys.lastName) ?? "",
        email: await _manager._storage.read(key: PrefKeys.email) ?? "",
        phone: await _manager._storage.read(key: PrefKeys.email) ?? "");

    return user;
  }

  Future<void> setAuthenticated(String? token, User user) async {
    if (token == null) {
      if ((await _manager._storage.read(key: PrefKeys.token)) == null) {
        throw Exception(
            "You cannot pass null token when there's no token previously persisted.");
      }
    }

    if (token != null) {
      await _manager._storage.write(key: PrefKeys.token, value: token);
      await PersistenceService().saveHasAuthenticatedBefore(true);
    }

    await saveUserDetails(user);
  }

  Future<void> saveUserDetails(User user) async {
    await _manager._storage.write(key: PrefKeys.email, value: user.email);
    await _manager._storage.write(key: PrefKeys.email, value: user.phone);
    await _manager._storage
        .write(key: PrefKeys.firstName, value: user.firstName);
    await _manager._storage.write(key: PrefKeys.lastName, value: user.lastName);
    await _manager._storage
        .write(key: PrefKeys.profilePicture, value: user.profilePicture);
  }

  void logOut() async {
    _manager._storage.deleteAll();
    PersistenceService().clearUserTiedPreferences();
  }

  AuthService._internal();
}
