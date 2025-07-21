import 'package:flutter/material.dart';

// ライトテーマ
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.blueAccent,
    surface: Colors.grey[100]!,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueAccent,
    foregroundColor: Colors.white,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: Colors.grey.withOpacity(0.2),
    elevation: 2,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[100],
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
  ),
  // カスタムカラーの拡張
  extensions: const [
    EventCategoryColors.light(),
  ],
  useMaterial3: true,
);

// ダークテーマ
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.grey[900],
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
    secondary: Colors.cyanAccent,
    surface: Colors.grey[850]!,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    elevation: 0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[900],
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.cyanAccent,
    foregroundColor: Colors.black,
  ),
  cardTheme: CardTheme(
    color: Colors.grey[850],
    shadowColor: Colors.black.withOpacity(0.3),
    elevation: 2,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[850],
    selectedItemColor: Colors.cyanAccent,
    unselectedItemColor: Colors.grey,
  ),
  // カスタムカラーの拡張
  extensions: const [
    EventCategoryColors.dark(),
  ],
  useMaterial3: true,
);

// 後方互換性のため
final ThemeData appTheme = darkTheme;

// イベントカテゴリ用のカスタムカラー
@immutable
class EventCategoryColors extends ThemeExtension<EventCategoryColors> {
  final Color practiceColor;
  final Color meetingColor;
  final Color scrumColor;
  final Color socialColor;
  final Color otherColor;

  const EventCategoryColors({
    required this.practiceColor,
    required this.meetingColor,
    required this.scrumColor,
    required this.socialColor,
    required this.otherColor,
  });

  const EventCategoryColors.light()
      : practiceColor = const Color(0xFF2196F3), // Blue
        meetingColor = const Color(0xFF9C27B0), // Purple
        scrumColor = const Color(0xFF4CAF50), // Green
        socialColor = const Color(0xFFFF9800), // Orange
        otherColor = const Color(0xFF757575); // Grey

  const EventCategoryColors.dark()
      : practiceColor = const Color(0xFF64B5F6), // Light Blue
        meetingColor = const Color(0xFFBA68C8), // Light Purple
        scrumColor = const Color(0xFF81C784), // Light Green
        socialColor = const Color(0xFFFFB74D), // Light Orange
        otherColor = const Color(0xFF9E9E9E); // Light Grey

  @override
  EventCategoryColors copyWith({
    Color? practiceColor,
    Color? meetingColor,
    Color? scrumColor,
    Color? socialColor,
    Color? otherColor,
  }) {
    return EventCategoryColors(
      practiceColor: practiceColor ?? this.practiceColor,
      meetingColor: meetingColor ?? this.meetingColor,
      scrumColor: scrumColor ?? this.scrumColor,
      socialColor: socialColor ?? this.socialColor,
      otherColor: otherColor ?? this.otherColor,
    );
  }

  @override
  EventCategoryColors lerp(ThemeExtension<EventCategoryColors>? other, double t) {
    if (other is! EventCategoryColors) {
      return this;
    }
    return EventCategoryColors(
      practiceColor: Color.lerp(practiceColor, other.practiceColor, t)!,
      meetingColor: Color.lerp(meetingColor, other.meetingColor, t)!,
      scrumColor: Color.lerp(scrumColor, other.scrumColor, t)!,
      socialColor: Color.lerp(socialColor, other.socialColor, t)!,
      otherColor: Color.lerp(otherColor, other.otherColor, t)!,
    );
  }
}
