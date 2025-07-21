import 'package:flutter/material.dart';

/// アプリケーションのタイポグラフィシステム
/// Material Design 3のタイポグラフィスケールに基づいて定義
class AppTypography {
  AppTypography._();

  // フォントファミリー
  static const String primaryFontFamily = 'NotoSansJP';
  static const String secondaryFontFamily = 'Roboto';
  
  // フォントウェイト
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // 行間のベース値（line height）
  static const double baseLineHeight = 1.5;
  static const double tightLineHeight = 1.2;
  static const double looseLineHeight = 1.6;

  // Display スタイル（大きな見出し）
  static const TextStyle displayLarge = TextStyle(
    fontSize: 36,
    fontWeight: bold,
    height: tightLineHeight,
    letterSpacing: -0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: bold,
    height: tightLineHeight,
    letterSpacing: -0.25,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 28,
    fontWeight: bold,
    height: tightLineHeight,
  );

  // Headline スタイル（見出し）
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 24,
    fontWeight: bold,
    height: tightLineHeight,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  // Title スタイル（タイトル）
  static const TextStyle titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 12,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  // Body スタイル（本文）
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: regular,
    height: baseLineHeight,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: regular,
    height: baseLineHeight,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    height: baseLineHeight,
  );

  // Label スタイル（ラベル・ボタンテキスト）
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: medium,
    height: baseLineHeight,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    height: baseLineHeight,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: medium,
    height: baseLineHeight,
  );

  // 特殊用途のスタイル
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    height: baseLineHeight,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: medium,
    height: baseLineHeight,
    letterSpacing: 1.5,
  );

  // アプリ固有のスタイル
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 14,
    fontWeight: medium,
    height: baseLineHeight,
    letterSpacing: 0.1,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: regular,
    height: baseLineHeight,
  );

  static const TextStyle tabLabel = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    height: baseLineHeight,
  );

  static const TextStyle eventTitle = TextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    height: baseLineHeight,
  );

  static const TextStyle eventDetails = TextStyle(
    fontSize: 14,
    fontWeight: regular,
    height: baseLineHeight,
  );

  static const TextStyle eventMetadata = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    height: baseLineHeight,
  );
}

/// TextTheme を生成するヘルパークラス
class AppTextTheme {
  static TextTheme createTextTheme({Color? color}) {
    return TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: color),
      displayMedium: AppTypography.displayMedium.copyWith(color: color),
      displaySmall: AppTypography.displaySmall.copyWith(color: color),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: color),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: color),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: color),
      titleLarge: AppTypography.titleLarge.copyWith(color: color),
      titleMedium: AppTypography.titleMedium.copyWith(color: color),
      titleSmall: AppTypography.titleSmall.copyWith(color: color),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: color),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: color),
      bodySmall: AppTypography.bodySmall.copyWith(color: color),
      labelLarge: AppTypography.labelLarge.copyWith(color: color),
      labelMedium: AppTypography.labelMedium.copyWith(color: color),
      labelSmall: AppTypography.labelSmall.copyWith(color: color),
    );
  }

  static TextTheme get lightTextTheme => createTextTheme();
  static TextTheme get darkTextTheme => createTextTheme();
}

/// カスタムテキストスタイルのThemeExtension
@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle appBarTitle;
  final TextStyle buttonText;
  final TextStyle cardTitle;
  final TextStyle cardSubtitle;
  final TextStyle tabLabel;
  final TextStyle eventTitle;
  final TextStyle eventDetails;
  final TextStyle eventMetadata;

  const AppTextStyles({
    required this.appBarTitle,
    required this.buttonText,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.tabLabel,
    required this.eventTitle,
    required this.eventDetails,
    required this.eventMetadata,
  });

  factory AppTextStyles.light() {
    return const AppTextStyles(
      appBarTitle: AppTypography.appBarTitle,
      buttonText: AppTypography.buttonText,
      cardTitle: AppTypography.cardTitle,
      cardSubtitle: AppTypography.cardSubtitle,
      tabLabel: AppTypography.tabLabel,
      eventTitle: AppTypography.eventTitle,
      eventDetails: AppTypography.eventDetails,
      eventMetadata: AppTypography.eventMetadata,
    );
  }

  factory AppTextStyles.dark() {
    return const AppTextStyles(
      appBarTitle: AppTypography.appBarTitle,
      buttonText: AppTypography.buttonText,
      cardTitle: AppTypography.cardTitle,
      cardSubtitle: AppTypography.cardSubtitle,
      tabLabel: AppTypography.tabLabel,
      eventTitle: AppTypography.eventTitle,
      eventDetails: AppTypography.eventDetails,
      eventMetadata: AppTypography.eventMetadata,
    );
  }

  @override
  AppTextStyles copyWith({
    TextStyle? appBarTitle,
    TextStyle? buttonText,
    TextStyle? cardTitle,
    TextStyle? cardSubtitle,
    TextStyle? tabLabel,
    TextStyle? eventTitle,
    TextStyle? eventDetails,
    TextStyle? eventMetadata,
  }) {
    return AppTextStyles(
      appBarTitle: appBarTitle ?? this.appBarTitle,
      buttonText: buttonText ?? this.buttonText,
      cardTitle: cardTitle ?? this.cardTitle,
      cardSubtitle: cardSubtitle ?? this.cardSubtitle,
      tabLabel: tabLabel ?? this.tabLabel,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDetails: eventDetails ?? this.eventDetails,
      eventMetadata: eventMetadata ?? this.eventMetadata,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      appBarTitle: TextStyle.lerp(appBarTitle, other.appBarTitle, t)!,
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t)!,
      cardTitle: TextStyle.lerp(cardTitle, other.cardTitle, t)!,
      cardSubtitle: TextStyle.lerp(cardSubtitle, other.cardSubtitle, t)!,
      tabLabel: TextStyle.lerp(tabLabel, other.tabLabel, t)!,
      eventTitle: TextStyle.lerp(eventTitle, other.eventTitle, t)!,
      eventDetails: TextStyle.lerp(eventDetails, other.eventDetails, t)!,
      eventMetadata: TextStyle.lerp(eventMetadata, other.eventMetadata, t)!,
    );
  }
}