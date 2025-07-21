# Claude開発支援用ドキュメント

このドキュメントは、Claudeがこのプロジェクトの開発を支援する際に参照する情報をまとめています。

## プロジェクト概要
**チーム管理アプリ（Team Manager）**
スポーツチームなどの練習や試合等のイベントについて、グループメンバーの出欠確認を取りやすくするためのスケジュール管理Flutter アプリです。

## 開発環境・技術スタック
- **Flutter**: 3.5.1
- **状態管理**: Riverpod + Hooks
- **ルーティング**: GoRouter
- **データベース**: Drift (SQLite)
- **Firebase**: Core, Messaging
- **多言語対応**: Flutter Localizations

## 重要なコマンド

### 開発用コマンド（derry使用）
```bash
# 環境別実行
derry run-dev     # 開発環境で実行
derry run-stg     # ステージング環境で実行
derry run-prod    # 本番環境で実行

# コード生成
derry gen         # 全ての自動生成（Freezed, Drift, l10n等）

# アセット生成
derry gen-splash  # スプラッシュ画面生成
derry gen-icon    # アプリアイコン生成
```

### テスト・ビルドコマンド
```bash
flutter test              # テスト実行
flutter analyze           # 静的解析
flutter clean             # キャッシュクリア
```

## 現在のディレクトリ構造
```
lib/
├── main.dart                 # エントリーポイント
├── firebase_options.dart     # Firebase設定
└── src/
    ├── common/              # 共通機能・ドメインロジック
    ├── const/               # 定数（テーマ、環境変数等）
    ├── data/                # データモデル
    ├── db/                  # Driftデータベース定義
    ├── extension/           # 拡張機能
    ├── page/                # 画面コンポーネント
    ├── plugins/             # 外部サービス連携
    ├── router.dart          # GoRouterルーティング
    └── widgets/             # 共通UIコンポーネント
```

## 現在実装済み機能
1. **基本画面**: ホーム、スケジュール、設定
2. **ナビゲーション**: ハンバーガーメニュー、ボトムナビ
3. **スケジュール**: カレンダー表示、イベント表示
4. **インフラ**: 多言語対応、プッシュ通知、ローカル通知

## 実装パターン

### 新しいページの追加手順
1. `/lib/src/page/` にページファイル作成
2. `/lib/src/router.dart` にルート定義追加
3. 必要に応じてナビゲーションメニューに追加

### ページ作成テンプレート
```dart
import 'package:flutter/material.dart';
import 'package:flutter_template/src/widgets/app_footer.dart';
import 'package:flutter_template/src/widgets/hamburger_menu.dart';

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ページタイトル')),
      drawer: const HamburgerMenu(),
      body: const Center(child: Text('ページ内容')),
      bottomNavigationBar: const AppFooter(),
    );
  }
}
```

### Riverpod プロバイダーパターン
```dart
// シンプルな状態
final counterProvider = StateProvider<int>((ref) => 0);

// 複雑な状態管理
class DataNotifier extends StateNotifier<List<Data>> {
  DataNotifier() : super([]);
  // ビジネスロジック実装
}

final dataProvider = StateNotifierProvider<DataNotifier, List<Data>>(
  (ref) => DataNotifier(),
);
```

### テーマ機能の使用方法
```dart
// テーマ切り替え
ref.read(themeModeProvider.notifier).setThemeMode(AppThemeMode.light);

// カスタムカラーの使用
final categoryColors = Theme.of(context).extension<EventCategoryColors>();
Color practiceColor = categoryColors?.practiceColor ?? Colors.blue;
```

### デザインシステムの使用方法
```dart
import 'package:flutter_template/src/design_system/design_system.dart';

// カラー使用例
Container(
  color: AppColors.primaryBlue,
  child: Text(
    'テキスト',
    style: AppTypography.bodyMedium.copyWith(color: AppColors.white),
  ),
)

// スペーシング使用例
Padding(
  padding: AppPadding.md, // 16px
  child: Column(
    children: [
      Text('タイトル'),
      AppGap.sm, // 8px の縦スペース
      Text('内容'),
    ],
  ),
)

// レスポンシブレイアウト例
AppLayout.centeredContent(
  maxWidth: AppDimensions.maxContentWidth,
  child: YourWidget(),
)

// カテゴリカラー取得
Color categoryColor = DesignUtils.getCategoryColor(context, 'practice');
```

### データベース（Drift）使用パターン
```dart
// テーブル定義
class TableName extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
}

// データベースクラスに追加
@DriftDatabase(tables: [TableName])
class MyDatabase extends _$MyDatabase {
  // スキーマバージョンを忘れずにインクリメント
  @override
  int get schemaVersion => 2; // 変更時は +1
}
```

## データベース設計（現在）
- **todos**: id, title, content, category
- **categories**: id, description

## 開発時の注意点

### コード生成が必要な場合
- Freezed使用時
- Drift テーブル変更時
- 多言語対応ファイル変更時
→ `derry gen` を実行

### 新機能開発時のチェックポイント
1. 既存のコード規約・パターンに従う
2. 必要に応じてドキュメント更新
3. テスト作成を検討
4. パフォーマンスへの影響を考慮

### トラブルシューティング
- ビルドエラー → `flutter clean && flutter pub get && derry gen`
- iOS関連エラー → `cd ios && pod install`
- Android関連エラー → Gradle設定確認

## 画面デザイン仕様（docs/screen_image/参照）

### イベント一覧画面（イベント一覧.png）
- **ヘッダー**: 「イベント」+ 右上「+」ボタン
- **イベントカード構成**:
  - 左：カテゴリアイコン（色付き円形）
  - 中央：タイトル、日時、場所、参加者数
  - 右：詳細遷移矢印
- **ボトムナビ**: ホーム、イベント、カレンダー、プロフィール

### イベント詳細画面（イベント詳細.png）
- **ヘッダー**: 戻るボタン + 「イベント詳細」
- **コンテンツ**: タイトル、詳細日時、場所、説明、画像
- **参加機能**: 参加者数表示 + 参加/不参加ボタン

## 今後の開発予定
- ユーザー認証機能
- イベント作成・編集機能
- 出欠管理機能
- グループ管理機能
- 画面デザインに基づくUI実装

## 関連ドキュメント
詳細な情報は `docs/` ディレクトリの各ドキュメントを参照：
- `README.md` - プロジェクト概要
- `architecture.md` - アーキテクチャ設計
- `development-guide.md` - 開発ガイド
- `features.md` - 機能仕様