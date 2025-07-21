import 'package:flutter/material.dart';

/// アプリケーションのカラーパレット
/// Material Design 3のカラーシステムに基づいて定義
class AppColors {
  AppColors._();

  // プライマリカラー（ブランドカラー）
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryBlueLight = Color(0xFF64B5F6);
  static const Color primaryBlueDark = Color(0xFF1976D2);

  // セカンダリカラー
  static const Color secondaryBlue = Color(0xFF03DAC6);
  static const Color secondaryBlueLight = Color(0xFF4FD6D8);
  static const Color secondaryBlueDark = Color(0xFF018786);

  // グレースケール
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey850 = Color(0xFF303030);
  static const Color grey900 = Color(0xFF212121);
  static const Color black = Color(0xFF000000);

  // セマンティックカラー（意味を持つ色）
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  // イベントカテゴリ専用カラー
  static const Color categoryPractice = primaryBlue;
  static const Color categoryPracticeLight = primaryBlueLight;
  
  static const Color categoryMeeting = Color(0xFF9C27B0);
  static const Color categoryMeetingLight = Color(0xFFBA68C8);
  
  static const Color categoryScrum = success;
  static const Color categoryScrumLight = successLight;
  
  static const Color categorySocial = warning;
  static const Color categorySocialLight = warningLight;
  
  static const Color categoryOther = grey500;
  static const Color categoryOtherLight = grey400;

  // 透明度付きカラー
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // シャドウカラー
  static final Color shadowLight = black.withOpacity(0.1);
  static final Color shadowMedium = black.withOpacity(0.2);
  static final Color shadowDark = black.withOpacity(0.3);
}

/// ライトテーマ用のカラースキーム
class LightColorScheme {
  static const ColorScheme scheme = ColorScheme.light(
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.white,
    secondary: AppColors.secondaryBlue,
    onSecondary: AppColors.black,
    surface: AppColors.white,
    onSurface: AppColors.grey900,
    background: AppColors.grey50,
    onBackground: AppColors.grey900,
    error: AppColors.error,
    onError: AppColors.white,
    outline: AppColors.grey300,
    surfaceVariant: AppColors.grey100,
    onSurfaceVariant: AppColors.grey700,
  );
}

/// ダークテーマ用のカラースキーム
class DarkColorScheme {
  static const ColorScheme scheme = ColorScheme.dark(
    primary: AppColors.primaryBlueLight,
    onPrimary: AppColors.black,
    secondary: AppColors.secondaryBlue,
    onSecondary: AppColors.black,
    surface: AppColors.grey850,
    onSurface: AppColors.white,
    background: AppColors.grey900,
    onBackground: AppColors.white,
    error: AppColors.errorLight,
    onError: AppColors.black,
    outline: AppColors.grey600,
    surfaceVariant: AppColors.grey800,
    onSurfaceVariant: AppColors.grey300,
  );
}

/// イベントカテゴリ用のカスタムカラーエクステンション
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
      : practiceColor = AppColors.categoryPractice,
        meetingColor = AppColors.categoryMeeting,
        scrumColor = AppColors.categoryScrum,
        socialColor = AppColors.categorySocial,
        otherColor = AppColors.categoryOther;

  const EventCategoryColors.dark()
      : practiceColor = AppColors.categoryPracticeLight,
        meetingColor = AppColors.categoryMeetingLight,
        scrumColor = AppColors.categoryScrumLight,
        socialColor = AppColors.categorySocialLight,
        otherColor = AppColors.categoryOtherLight;

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