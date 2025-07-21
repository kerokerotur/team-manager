import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// テーマモードのenum
enum AppThemeMode {
  light,
  dark,
  system,
}

// テーマモードの状態管理
class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  ThemeModeNotifier() : super(AppThemeMode.system) {
    _loadThemeMode();
  }

  static const String _themeModeKey = 'theme_mode';

  // 保存されているテーマモードを読み込み
  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_themeModeKey);
    
    if (savedMode != null) {
      switch (savedMode) {
        case 'light':
          state = AppThemeMode.light;
          break;
        case 'dark':
          state = AppThemeMode.dark;
          break;
        case 'system':
          state = AppThemeMode.system;
          break;
      }
    }
  }

  // テーマモードを変更して保存
  Future<void> setThemeMode(AppThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.name);
  }

  // Flutterの ThemeMode に変換
  ThemeMode get flutterThemeMode {
    switch (state) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

// プロバイダー
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>(
  (ref) => ThemeModeNotifier(),
);

// 便利な getter プロバイダー
final flutterThemeModeProvider = Provider<ThemeMode>((ref) {
  ref.watch(themeModeProvider);
  final notifier = ref.read(themeModeProvider.notifier);
  return notifier.flutterThemeMode;
});