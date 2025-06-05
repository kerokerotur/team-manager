import 'dart:ui';

import 'package:flutter_template/src/common/domain/locale/abstract_locales_repository.dart';
import 'package:flutter_template/src/const/shared_preferences_keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localesRepositoryProvider =
    Provider<LocalesRepository>((_) => LocalesRepository());

class LocalesRepository extends AbstractLocalesRepository {
  Future<SharedPreferences> get _storage => SharedPreferences.getInstance();
  String get _key => SharedPreferencesKeys.languageCode.value;

  @override
  Future<Locale?> fetchAppLocale() async {
    final lang = await _storage.then((pref) => pref.getString(_key));
    return lang == null ? null : Locale(lang);
  }

  @override
  Future<Locale> fetchOsLocale() async {
    return PlatformDispatcher.instance.locale;
  }

  @override
  Future<void> saveAppLocale(Locale locale) async {
    final lang = locale.languageCode;
    return await _storage.then((pref) => pref.setString(_key, lang));
  }

  @override
  Future<void> removeAppLocale() async {
    return await _storage.then((pref) => pref.remove(_key));
  }
}
