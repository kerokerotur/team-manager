import 'package:flutter/material.dart';
import 'package:flutter_template/src/design_system/colors.dart';
import 'package:flutter_template/src/design_system/typography.dart';
import 'package:flutter_template/src/design_system/spacing.dart';
import 'package:flutter_template/src/design_system/dimensions.dart';

/// アプリケーションのテーマ定義
/// デザインシステムに基づいたライト・ダークテーマの構築

// ライトテーマ
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: LightColorScheme.scheme,
  textTheme: AppTextTheme.lightTextTheme,

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: LightColorScheme.scheme.primary,
    foregroundColor: LightColorScheme.scheme.onPrimary,
    elevation: AppElevation.appBar,
    titleTextStyle: AppTypography.appBarTitle.copyWith(
      color: LightColorScheme.scheme.onPrimary,
    ),
    iconTheme: IconThemeData(
      color: LightColorScheme.scheme.onPrimary,
      size: AppDimensions.iconMd,
    ),
  ),

  // Card
  cardTheme: CardTheme(
    color: LightColorScheme.scheme.surface,
    shadowColor: AppColors.shadowLight,
    elevation: AppElevation.card,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.cardRadius,
    ),
    margin: AppPadding.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
  ),

  // FloatingActionButton
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: LightColorScheme.scheme.primary,
    foregroundColor: LightColorScheme.scheme.onPrimary,
    elevation: AppElevation.fab,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.fabSize / 2),
    ),
  ),

  // BottomNavigationBar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.grey100,
    selectedItemColor: LightColorScheme.scheme.primary,
    unselectedItemColor: AppColors.grey500,
    type: BottomNavigationBarType.fixed,
    elevation: AppElevation.medium,
  ),

  // Drawer
  drawerTheme: DrawerThemeData(
    backgroundColor: LightColorScheme.scheme.surface,
    elevation: AppElevation.drawer,
  ),

  // Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColorScheme.scheme.primary,
      foregroundColor: LightColorScheme.scheme.onPrimary,
      elevation: AppElevation.button,
      padding: AppPadding.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonRadius,
      ),
      textStyle: AppTypography.buttonText,
      minimumSize: const Size(
        AppDimensions.buttonMinWidth,
        AppDimensions.buttonHeightMd,
      ),
    ),
  ),

  // Input
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: LightColorScheme.scheme.surface,
    border: OutlineInputBorder(
      borderRadius: AppRadius.inputRadius,
      borderSide: const BorderSide(color: AppColors.grey300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputRadius,
      borderSide: const BorderSide(color: AppColors.grey300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputRadius,
      borderSide: BorderSide(color: LightColorScheme.scheme.primary),
    ),
    contentPadding: AppPadding.md,
  ),

  // カスタム拡張
  extensions: [
    const EventCategoryColors.light(),
    AppTextStyles.light(),
  ],

  useMaterial3: true,
);

// ダークテーマ
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: DarkColorScheme.scheme,
  textTheme: AppTextTheme.darkTextTheme,

  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: DarkColorScheme.scheme.surface,
    foregroundColor: DarkColorScheme.scheme.onSurface,
    elevation: AppElevation.appBar,
    titleTextStyle: AppTypography.appBarTitle.copyWith(
      color: DarkColorScheme.scheme.onSurface,
    ),
    iconTheme: IconThemeData(
      color: DarkColorScheme.scheme.onSurface,
      size: AppDimensions.iconMd,
    ),
  ),

  // Card
  cardTheme: CardTheme(
    color: DarkColorScheme.scheme.surface,
    shadowColor: AppColors.shadowDark,
    elevation: AppElevation.card,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.cardRadius,
    ),
    margin: AppPadding.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
  ),

  // FloatingActionButton
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: DarkColorScheme.scheme.primary,
    foregroundColor: DarkColorScheme.scheme.onPrimary,
    elevation: AppElevation.fab,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.fabSize / 2),
    ),
  ),

  // BottomNavigationBar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.grey850,
    selectedItemColor: DarkColorScheme.scheme.primary,
    unselectedItemColor: AppColors.grey500,
    type: BottomNavigationBarType.fixed,
    elevation: AppElevation.medium,
  ),

  // Drawer
  drawerTheme: DrawerThemeData(
    backgroundColor: DarkColorScheme.scheme.surface,
    elevation: AppElevation.drawer,
  ),

  // Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkColorScheme.scheme.primary,
      foregroundColor: DarkColorScheme.scheme.onPrimary,
      elevation: AppElevation.button,
      padding: AppPadding.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.buttonRadius,
      ),
      textStyle: AppTypography.buttonText,
      minimumSize: const Size(
        AppDimensions.buttonMinWidth,
        AppDimensions.buttonHeightMd,
      ),
    ),
  ),

  // Input
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DarkColorScheme.scheme.surface,
    border: OutlineInputBorder(
      borderRadius: AppRadius.inputRadius,
      borderSide: const BorderSide(color: AppColors.grey600),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputRadius,
      borderSide: const BorderSide(color: AppColors.grey600),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.inputRadius,
      borderSide: BorderSide(color: DarkColorScheme.scheme.primary),
    ),
    contentPadding: AppPadding.md,
  ),

  // カスタム拡張
  extensions: [
    const EventCategoryColors.dark(),
    AppTextStyles.dark(),
  ],

  useMaterial3: true,
);

// 後方互換性のため
final ThemeData appTheme = darkTheme;
