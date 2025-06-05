import 'package:flutter/material.dart';
import 'package:flutter_template/src/extension/locale_extension.dart';

const supportLocale = [ja, en];
const _defaultLocale = en;
const en = Locale('en');
const ja = Locale('ja');

@immutable
class Locales {
  const Locales({required Locale? appLocale, required Locale? osLocale})
      : _appLocale = appLocale,
        _osLocale = osLocale;

  const Locales.init()
      : _appLocale = null,
        _osLocale = null;

  final Locale? _appLocale;
  final Locale? _osLocale;

  Locale get currentLocale =>
      _appLocale ??
      (_osLocale.canSupport ? _osLocale ?? _defaultLocale : _defaultLocale);

  Locales updateAppLocale(Locale? newLocale) {
    // FIXME: nullは、端末の設定値を使う場合。いずれ型安全に実装したい
    if (newLocale == null) return Locales(appLocale: null, osLocale: _osLocale);
    return Locales(appLocale: newLocale, osLocale: _osLocale);
  }

  Locales updateOsLocale(Locale newLocale) {
    return Locales(appLocale: _appLocale, osLocale: newLocale);
  }
}
