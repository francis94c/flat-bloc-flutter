import 'package:flat_bloc_flutter/config/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  static final PersistenceService _manager = PersistenceService._internal();

  SharedPreferences? _prefs;

  factory PersistenceService() {
    return _manager;
  }

  Future<void> _ensurePrefsLoaded() async {
    _manager._prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> clearUserTiedPreferences() async {
    await _manager._ensurePrefsLoaded();
  }

  Future<bool> getHasAuthenticatedBefore() async {
    await _manager._ensurePrefsLoaded();
    return Future.value(
        _manager._prefs!.getBool(PrefKeys.hasAuthenticatedBefore) ?? false);
  }

  Future<void> saveHasAuthenticatedBefore(bool hasAuthenticatedBefore) async {
    await _manager._ensurePrefsLoaded();
    _manager._prefs!
        .setBool(PrefKeys.hasAuthenticatedBefore, hasAuthenticatedBefore);
  }

  Future<void> saveDarkMode(bool darkMode) async {
    await _manager._ensurePrefsLoaded();
    _manager._prefs!.setBool(PrefKeys.darkMode, darkMode);
  }

  Future<bool?> getDarkMode() async {
    await _manager._ensurePrefsLoaded();
    return Future.value(_manager._prefs!.getBool(PrefKeys.darkMode));
  }

  Future<bool> getHasBeenGuided() async {
    await _manager._ensurePrefsLoaded();
    return Future.value(
        _manager._prefs!.getBool(PrefKeys.hasBeenGuided) ?? false);
  }

  Future<void> saveHasBeenGuided(bool hasBeenGuided) async {
    await _manager._ensurePrefsLoaded();
    _manager._prefs!.setBool(PrefKeys.hasBeenGuided, hasBeenGuided);
  }

  Future<void> saveShouldUseBiometricAuthentication(
      bool biometricAuthentication) async {
    await _manager._ensurePrefsLoaded();
    _manager._prefs!.setBool(PrefKeys.biometric, biometricAuthentication);
  }

  Future<bool> getShouldUseBiometricAuthentication() async {
    await _manager._ensurePrefsLoaded();
    return Future.value(_manager._prefs!.getBool(PrefKeys.biometric) ?? true);
  }

  PersistenceService._internal();
}
