import 'package:flutter/material.dart';

/// アプリケーションのコンポーネントサイズとレイアウト定義
class AppDimensions {
  AppDimensions._();

  // アイコンサイズ
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 40;
  static const double iconXxl = 48;

  // ボタンサイズ
  static const double buttonHeightSm = 32;
  static const double buttonHeightMd = 40;
  static const double buttonHeightLg = 48;
  static const double buttonHeightXl = 56;

  static const double buttonMinWidth = 64;
  static const double buttonMaxWidth = 280;

  // インプットフィールドサイズ
  static const double inputHeight = 48;
  static const double inputHeightSm = 40;
  static const double inputHeightLg = 56;

  // カードとコンテナ
  static const double cardMinHeight = 80;
  static const double cardMaxWidth = 400;
  static const double cardElevation = 2;

  // リストアイテム
  static const double listItemHeight = 56;
  static const double listItemHeightSm = 48;
  static const double listItemHeightLg = 72;
  static const double listItemHeightXl = 88;

  // アバターサイズ
  static const double avatarXs = 24;
  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 48;
  static const double avatarXl = 64;
  static const double avatarXxl = 80;

  // AppBar
  static const double appBarHeight = 56;
  static const double appBarHeightLg = 64;

  // BottomNavigationBar
  static const double bottomNavHeight = 60;
  static const double bottomNavIconSize = 24;

  // Drawer
  static const double drawerWidth = 280;

  // Floating Action Button
  static const double fabSize = 56;
  static const double fabSizeMini = 40;

  // Tab
  static const double tabHeight = 48;
  static const double tabMinWidth = 72;

  // Dialog
  static const double dialogMaxWidth = 400;
  static const double dialogMinWidth = 280;
  static const double dialogBorderRadius = 12;

  // Bottom Sheet
  static const double bottomSheetMaxHeight = 0.9; // 画面の90%
  static const double bottomSheetMinHeight = 0.3; // 画面の30%

  // イベント関連のコンポーネント
  static const double eventCardHeight = 120;
  static const double eventCardMinHeight = 100;
  static const double eventCategoryIconSize = 48;
  static const double eventDetailImageHeight = 200;

  // スケジュール関連
  static const double calendarCellHeight = 40;
  static const double calendarHeaderHeight = 60;

  // レスポンシブブレークポイント
  static const double mobileMaxWidth = 599;
  static const double tabletMinWidth = 600;
  static const double tabletMaxWidth = 1023;
  static const double desktopMinWidth = 1024;

  // コンテンツ幅制限
  static const double maxContentWidth = 1200;
  static const double maxFormWidth = 600;
  static const double maxCardWidth = 400;
}

/// レスポンシブレイアウトのヘルパークラス
class AppLayout {
  AppLayout._();

  /// 現在の画面サイズに基づいてデバイスタイプを判定
  static DeviceType getDeviceType(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < AppDimensions.tabletMinWidth) {
      return DeviceType.mobile;
    } else if (screenWidth < AppDimensions.desktopMinWidth) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// レスポンシブパディングを取得
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.all(16);
      case DeviceType.tablet:
        return const EdgeInsets.all(24);
      case DeviceType.desktop:
        return const EdgeInsets.all(32);
    }
  }

  /// レスポンシブカラム数を取得
  static int getResponsiveColumns(BuildContext context) {
    final deviceType = getDeviceType(context);

    switch (deviceType) {
      case DeviceType.mobile:
        return 1;
      case DeviceType.tablet:
        return 2;
      case DeviceType.desktop:
        return 3;
    }
  }

  /// 最大コンテンツ幅を考慮したコンテナを作成
  static Widget constrainedContainer({
    required Widget child,
    double? maxWidth,
    EdgeInsets? padding,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? AppDimensions.maxContentWidth,
      ),
      padding: padding,
      child: child,
    );
  }

  /// センタリングされたコンテンツコンテナ
  static Widget centeredContent({
    required Widget child,
    double? maxWidth,
    EdgeInsets? padding,
  }) {
    return Center(
      child: constrainedContainer(
        maxWidth: maxWidth,
        padding: padding,
        child: child,
      ),
    );
  }
}

/// デバイスタイプの列挙型
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

/// アニメーション持続時間の定義
class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration slower = Duration(milliseconds: 800);

  // 特定用途のアニメーション
  static const Duration pageTransition = normal;
  static const Duration dialogTransition = fast;
  static const Duration bottomSheetTransition = normal;
  static const Duration snackBarTransition = fast;
  static const Duration fabTransition = fast;
  static const Duration rippleAnimation = fast;
}

/// Z-index（elevation）の定義
class AppElevation {
  AppElevation._();

  static const double none = 0;
  static const double low = 1;
  static const double medium = 4;
  static const double high = 8;
  static const double highest = 16;

  // コンポーネント別elevation
  static const double card = low;
  static const double button = medium;
  static const double fab = high;
  static const double appBar = medium;
  static const double drawer = highest;
  static const double dialog = highest;
  static const double bottomSheet = high;
  static const double snackBar = high;
}

/// シャドウの定義
class AppShadows {
  AppShadows._();

  static const List<BoxShadow> none = [];

  static const List<BoxShadow> light = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> heavy = [
    BoxShadow(
      color: Color(0x1F000000),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // コンポーネント別シャドウ
  static const List<BoxShadow> card = light;
  static const List<BoxShadow> button = medium;
  static const List<BoxShadow> fab = heavy;
  static const List<BoxShadow> dialog = heavy;
}
