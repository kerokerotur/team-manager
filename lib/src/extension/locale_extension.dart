import 'package:flutter/material.dart';
import 'package:flutter_template/src/common/domain/locale/locales.dart';

extension LocaleExtension on Locale? {
  bool get canSupport {
    if (this == null) return false;

    return supportLocale
        .map((locale) => locale.languageCode)
        .contains(this!.languageCode);
  }
}
