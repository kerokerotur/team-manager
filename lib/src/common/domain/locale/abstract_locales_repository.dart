import 'package:flutter/material.dart';

abstract class AbstractLocalesRepository {
  Future<Locale?> fetchAppLocale();
  Future<Locale> fetchOsLocale();
  Future<void> saveAppLocale(Locale locale);
  Future<void> removeAppLocale();
}
