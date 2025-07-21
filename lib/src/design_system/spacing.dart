import 'package:flutter/material.dart';

/// アプリケーションのスペーシングシステム
/// 8ピクセルのベースユニットを基準にした一貫性のあるスペーシング
class AppSpacing {
  AppSpacing._();

  // ベースユニット（8px）
  static const double baseUnit = 8.0;

  // スペーシング値（8の倍数）
  static const double none = 0;
  static const double xs = baseUnit * 0.5; // 4px
  static const double sm = baseUnit * 1; // 8px
  static const double md = baseUnit * 2; // 16px
  static const double lg = baseUnit * 3; // 24px
  static const double xl = baseUnit * 4; // 32px
  static const double xxl = baseUnit * 5; // 40px
  static const double xxxl = baseUnit * 6; // 48px
  static const double huge = baseUnit * 8; // 64px

  // 特定用途のスペーシング
  static const double screenPadding = md; // 16px - 画面の基本パディング
  static const double cardPadding = md; // 16px - カードの内部パディング
  static const double listItemPadding = md; // 16px - リストアイテムのパディング
  static const double buttonPadding = sm; // 8px - ボタンの内部パディング
  static const double iconPadding = xs; // 4px - アイコン周りのパディング

  // 垂直方向のスペーシング
  static const double sectionSpacing = lg; // 24px - セクション間
  static const double componentSpacing = md; // 16px - コンポーネント間
  static const double itemSpacing = sm; // 8px - アイテム間
  static const double elementSpacing = xs; // 4px - 要素間

  // 水平方向のスペーシング
  static const double horizontalPadding = md; // 16px
  static const double horizontalMargin = md; // 16px
  static const double iconTextSpacing = sm; // 8px - アイコンとテキスト間

  // AppBarとナビゲーション
  static const double appBarPadding = md; // 16px
  static const double bottomNavPadding = md; // 16px
  static const double drawerPadding = md; // 16px

  // カードとリスト
  static const double cardMargin = sm; // 8px
  static const double cardBorderRadius = sm; // 8px
  static const double listItemHeight = huge; // 64px - 最小タップサイズ
  static const double listItemVerticalPadding = sm; // 8px

  // ボタンとインタラクティブ要素
  static const double buttonHeight = huge * 0.75; // 48px
  static const double buttonBorderRadius = sm; // 8px
  static const double iconButtonSize = huge * 0.75; // 48px
  static const double fabSize = huge * 0.875; // 56px

  // フォームとInput
  static const double inputPadding = md; // 16px
  static const double inputVerticalPadding = md; // 16px
  static const double inputBorderRadius = sm; // 8px
  static const double fieldSpacing = md; // 16px - フィールド間のスペース

  // モーダルとダイアログ
  static const double dialogPadding = lg; // 24px
  static const double modalPadding = lg; // 24px
  static const double bottomSheetPadding = lg; // 24px

  // レスポンシブブレークポイント
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 960;
  static const double desktopBreakpoint = 1280;
}

/// EdgeInsetsのヘルパーメソッドを提供するクラス
class AppPadding {
  AppPadding._();

  // 基本パディング
  static const EdgeInsets none = EdgeInsets.zero;
  static const EdgeInsets xs = EdgeInsets.all(AppSpacing.xs);
  static const EdgeInsets sm = EdgeInsets.all(AppSpacing.sm);
  static const EdgeInsets md = EdgeInsets.all(AppSpacing.md);
  static const EdgeInsets lg = EdgeInsets.all(AppSpacing.lg);
  static const EdgeInsets xl = EdgeInsets.all(AppSpacing.xl);
  static const EdgeInsets xxl = EdgeInsets.all(AppSpacing.xxl);

  // 水平パディング
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: AppSpacing.xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: AppSpacing.sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: AppSpacing.md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: AppSpacing.lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: AppSpacing.xl);

  // 垂直パディング
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: AppSpacing.xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: AppSpacing.sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: AppSpacing.md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: AppSpacing.lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: AppSpacing.xl);

  // 画面レベルのパディング
  static const EdgeInsets screen = EdgeInsets.all(AppSpacing.screenPadding);
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding);
  static const EdgeInsets screenVertical = EdgeInsets.symmetric(vertical: AppSpacing.screenPadding);

  // コンポーネント別パディング
  static const EdgeInsets card = EdgeInsets.all(AppSpacing.cardPadding);
  static const EdgeInsets listItem = EdgeInsets.all(AppSpacing.listItemPadding);
  static const EdgeInsets button = EdgeInsets.all(AppSpacing.buttonPadding);
  static const EdgeInsets dialog = EdgeInsets.all(AppSpacing.dialogPadding);

  // カスタムパディング生成
  static EdgeInsets only({
    double top = 0,
    double right = 0,
    double bottom = 0,
    double left = 0,
  }) {
    return EdgeInsets.only(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    );
  }

  static EdgeInsets symmetric({
    double vertical = 0,
    double horizontal = 0,
  }) {
    return EdgeInsets.symmetric(
      vertical: vertical,
      horizontal: horizontal,
    );
  }
}

/// SizedBoxのヘルパーメソッドを提供するクラス
class AppGap {
  AppGap._();

  // 垂直方向のスペース
  static const SizedBox none = SizedBox.shrink();
  static const SizedBox xs = SizedBox(height: AppSpacing.xs);
  static const SizedBox sm = SizedBox(height: AppSpacing.sm);
  static const SizedBox md = SizedBox(height: AppSpacing.md);
  static const SizedBox lg = SizedBox(height: AppSpacing.lg);
  static const SizedBox xl = SizedBox(height: AppSpacing.xl);
  static const SizedBox xxl = SizedBox(height: AppSpacing.xxl);
  static const SizedBox xxxl = SizedBox(height: AppSpacing.xxxl);

  // 水平方向のスペース
  static const SizedBox horizontalXs = SizedBox(width: AppSpacing.xs);
  static const SizedBox horizontalSm = SizedBox(width: AppSpacing.sm);
  static const SizedBox horizontalMd = SizedBox(width: AppSpacing.md);
  static const SizedBox horizontalLg = SizedBox(width: AppSpacing.lg);
  static const SizedBox horizontalXl = SizedBox(width: AppSpacing.xl);

  // カスタムスペース生成
  static SizedBox vertical(double height) => SizedBox(height: height);
  static SizedBox horizontal(double width) => SizedBox(width: width);
}

/// Border Radiusのヘルパーメソッドを提供するクラス
class AppRadius {
  AppRadius._();

  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double circular = 50; // 完全な円形

  // BorderRadius
  static const BorderRadius noneRadius = BorderRadius.zero;
  static BorderRadius xsRadius = BorderRadius.circular(xs);
  static BorderRadius smRadius = BorderRadius.circular(sm);
  static BorderRadius mdRadius = BorderRadius.circular(md);
  static BorderRadius lgRadius = BorderRadius.circular(lg);
  static BorderRadius xlRadius = BorderRadius.circular(xl);
  static BorderRadius xxlRadius = BorderRadius.circular(xxl);
  static BorderRadius circularRadius = BorderRadius.circular(circular);

  // 特定用途のRadius
  static BorderRadius cardRadius = BorderRadius.circular(AppSpacing.cardBorderRadius);
  static BorderRadius buttonRadius = BorderRadius.circular(AppSpacing.buttonBorderRadius);
  static BorderRadius inputRadius = BorderRadius.circular(AppSpacing.inputBorderRadius);
}