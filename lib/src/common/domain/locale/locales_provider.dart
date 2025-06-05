import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/src/common/adapter/locales_repository.dart';
import 'package:flutter_template/src/common/domain/locale/locales.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final localesProvider =
    NotifierProvider<LocalesProvider, Locales>(LocalesProvider.new);

class LocalesProvider extends Notifier<Locales> {
  @override
  Locales build() {
    return const Locales.init();
  }

  Future<void> setup() async {
    final provider = ref.read(localesRepositoryProvider);
    state = Locales(
        appLocale: await provider.fetchAppLocale(),
        osLocale: await provider.fetchOsLocale());
  }

  Future<void> changeAppLocale(Locale? newLocale) async {
    final provider = ref.read(localesRepositoryProvider);
    newLocale == null
        ? provider.removeAppLocale()
        : provider.saveAppLocale(newLocale);
    state = state.updateAppLocale(newLocale);
  }

  Future<void> changeOsLocale() async {
    PlatformDispatcher.instance.onLocaleChanged =
        () => state = state.updateOsLocale(PlatformDispatcher.instance.locale);
  }
}
