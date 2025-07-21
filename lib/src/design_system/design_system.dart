/// Team Manager アプリケーションのデザインシステム
/// 
/// このファイルは、アプリ全体で使用するデザイントークンとコンポーネントの
/// 一元的なエクスポートポイントです。
/// 
/// デザインシステムは以下の要素で構成されています：
/// - Colors: カラーパレットとテーマカラー
/// - Typography: フォント、文字サイズ、行間
/// - Spacing: 余白、間隔、パディング
/// - Dimensions: コンポーネントサイズ、レイアウト
/// 
/// 使用例:
/// ```dart
/// import 'package:flutter_template/src/design_system/design_system.dart';
/// 
/// Container(
///   padding: AppPadding.md,
///   decoration: BoxDecoration(
///     color: AppColors.primaryBlue,
///     borderRadius: AppRadius.cardRadius,
///   ),
///   child: Text(
///     'サンプルテキスト',
///     style: AppTypography.titleMedium,
///   ),
/// )
/// ```
library design_system;

export 'colors.dart';
export 'typography.dart';
export 'spacing.dart';
export 'dimensions.dart';

import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'spacing.dart';
import 'dimensions.dart';

/// デザインシステムの概要とガイドライン
class DesignSystemGuide {
  DesignSystemGuide._();

  /// デザインシステムの使用ガイドライン
  static const String guidelines = '''
# Team Manager デザインシステム

## 基本原則

### 1. 一貫性 (Consistency)
- 同じ機能には同じデザインパターンを使用
- カラー、タイポグラフィ、スペーシングの統一

### 2. アクセシビリティ (Accessibility)
- 十分なコントラスト比の確保
- タップターゲットサイズの最低基準（48dp）
- 読みやすいフォントサイズ

### 3. スケーラビリティ (Scalability)
- レスポンシブデザイン対応
- 様々な画面サイズへの適応
- ダークモード対応

### 4. パフォーマンス (Performance)
- 軽量なコンポーネント設計
- 効率的なレンダリング
- 適切なアニメーション

## カラーパレット使用ガイド

### プライマリカラー
- ブランドを表現する主要色
- CTA、重要なUI要素に使用

### セカンダリカラー
- プライマリカラーを補完
- アクセント、ハイライトに使用

### セマンティックカラー
- 成功: AppColors.success
- 警告: AppColors.warning  
- エラー: AppColors.error
- 情報: AppColors.info

### グレースケール
- テキスト、背景、境界線に使用
- 階層構造の表現

## タイポグラフィ使用ガイド

### ヒエラルキー
1. Display: 大きな見出し、ヒーロータイトル
2. Headline: セクション見出し
3. Title: カード/コンポーネントタイトル
4. Body: 本文テキスト
5. Label: ボタン、キャプション

### 行間とスペーシング
- タイトル: 1.2 (tight)
- 本文: 1.5 (base)
- キャプション: 1.6 (loose)

## スペーシング使用ガイド

### 8ピクセルグリッド
- すべてのスペーシングは8の倍数
- xs(4) → sm(8) → md(16) → lg(24) → xl(32)

### 用途別ガイドライン
- 画面パディング: md (16px)
- カード内パディング: md (16px)
- 要素間スペース: sm (8px)
- セクション間スペース: lg (24px)

## コンポーネントサイズガイド

### ボタン
- 最小高さ: 48px (タップしやすさ)
- 最小幅: 64px
- 最大幅: 280px

### アイコン
- 標準: 24px
- 小: 20px
- 大: 32px

### リストアイテム
- 標準: 56px
- 小: 48px
- 大: 72px
''';

  /// デザインシステムのバージョン情報
  static const String version = '1.0.0';
  
  /// 最終更新日
  static const String lastUpdated = '2025-01-21';

  /// 利用可能なBreakpointの取得
  static Map<String, double> get breakpoints => {
    'mobile': AppDimensions.mobileMaxWidth,
    'tablet': AppDimensions.tabletMinWidth,
    'desktop': AppDimensions.desktopMinWidth,
  };

  /// デザインシステムの健全性チェック
  static bool validate() {
    // 基本的な検証ロジック
    try {
      // スペーシングの検証
      assert(AppSpacing.baseUnit == 8.0);
      assert(AppSpacing.sm == AppSpacing.baseUnit);
      assert(AppSpacing.md == AppSpacing.baseUnit * 2);

      // タイポグラフィの検証
      assert(AppTypography.bodyMedium.fontSize == 14);
      assert(AppTypography.headlineMedium.fontSize == 20);

      return true;
    } catch (e) {
      debugPrint('Design System Validation Error: $e');
      return false;
    }
  }
}

/// デザインシステムのユーティリティメソッド
class DesignUtils {
  DesignUtils._();

  /// 現在のテーマからカテゴリカラーを取得
  static Color getCategoryColor(
    BuildContext context,
    String categoryType,
  ) {
    final categoryColors = Theme.of(context).extension<EventCategoryColors>();
    
    switch (categoryType.toLowerCase()) {
      case 'practice':
        return categoryColors?.practiceColor ?? AppColors.categoryPractice;
      case 'meeting':
        return categoryColors?.meetingColor ?? AppColors.categoryMeeting;
      case 'scrum':
        return categoryColors?.scrumColor ?? AppColors.categoryScrum;
      case 'social':
        return categoryColors?.socialColor ?? AppColors.categorySocial;
      default:
        return categoryColors?.otherColor ?? AppColors.categoryOther;
    }
  }

  /// デバイスタイプに応じたレスポンシブ値を取得
  static T getResponsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final deviceType = AppLayout.getDeviceType(context);
    
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }

  /// 色のコントラスト比を計算
  static double getContrastRatio(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();
    final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// アクセシブルなテキストカラーを取得
  static Color getAccessibleTextColor(Color backgroundColor) {
    final whiteContrast = getContrastRatio(backgroundColor, AppColors.white);
    final blackContrast = getContrastRatio(backgroundColor, AppColors.black);
    
    // WCAG AA基準（4.5:1）を満たす色を選択
    return whiteContrast >= blackContrast ? AppColors.white : AppColors.black;
  }
}