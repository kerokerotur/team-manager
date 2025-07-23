# 開発ガイド

## 開発環境セットアップ

### 必要な環境
- Flutter SDK 3.5.1+
- Dart SDK
- Android Studio / Xcode (各プラットフォーム開発用)
- Firebase プロジェクト

### セットアップ手順
1. リポジトリクローン
2. Flutter依存関係インストール: `flutter pub get`
3. コード自動生成: `derry gen`
4. Firebase設定ファイル配置
5. 環境変数ファイル作成（`env/`ディレクトリ）

## 開発フロー

### ブランチ戦略
- `main`: 本番リリース用
- `develop`: 開発統合用
- `feature/*`: 機能開発用

### コミット規約
- feat: 新機能追加
- fix: バグ修正
- docs: ドキュメント更新
- style: コードフォーマット
- refactor: リファクタリング
- test: テスト追加・修正

## コーディング規約

### Dart/Flutter規約
- `flutter analyze` でリント違反をチェック
- `dart format` でコードフォーマット
- メソッド・変数名はキャメルケース
- クラス名はパスカルケース
- private メンバーはアンダースコア接頭辞

### ファイル・ディレクトリ命名
- ファイル名: スネークケース（例: `schedule_page.dart`）
- ディレクトリ名: スネークケース
- アセットファイル: スネークケース

### コメント規約
```dart
/// ドキュメントコメント（外部向け）
// 実装コメント（内部向け）
```

## コード自動生成

### 使用している自動生成ツール
- **Freezed**: データクラス生成
- **json_annotation**: JSON serialization
- **Drift**: データベースコード生成
- **flutter_gen**: アセット管理
- **go_router_builder**: ルーティング生成

### 生成コマンド
```bash
# 全ての自動生成実行
derry gen

# 個別実行
flutter pub run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

## データベース開発

### Driftの使用方法
1. テーブル定義を `database.dart` に追加
2. `schemaVersion` をインクリメント
3. `derry gen` でコード生成
4. マイグレーション処理を実装（必要に応じて）

### テーブル追加例
```dart
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get eventDate => dateTime()();
  TextColumn get description => text().nullable()();
}
```

## 状態管理

### Riverpod使用パターン

#### シンプルな状態
```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

#### 複雑な状態管理
```dart
class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);
  
  void addTodo(Todo todo) {
    state = [...state, todo];
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(),
);
```

#### データ取得
```dart
final userProvider = FutureProvider<User>((ref) async {
  final repository = ref.read(userRepositoryProvider);
  return repository.getCurrentUser();
});
```

## ページ追加手順

### 新しい画面の作成
1. `/lib/src/page/` に画面ファイル作成
2. `/lib/src/router.dart` にルート追加
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
      appBar: AppBar(
        title: const Text('新しいページ'),
      ),
      drawer: const HamburgerMenu(),
      body: const Center(
        child: Text('新しいページの内容'),
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }
}
```

## テスト

### テスト構成
- **Unit Test**: ビジネスロジックのテスト
- **Widget Test**: UIコンポーネントのテスト
- **Integration Test**: E2Eテスト

### テスト実行
```bash
flutter test                    # 全テスト実行
flutter test test/unit/         # ユニットテストのみ
flutter test test/widget/       # ウィジェットテストのみ
```

## ビルドとデプロイ

### 環境別ビルド
```bash
# 開発環境
flutter build apk --dart-define-from-file=env/dev.env

# ステージング環境
flutter build apk --dart-define-from-file=env/stg.env

# 本番環境
flutter build apk --dart-define-from-file=env/prod.env
```

### アプリアイコン・スプラッシュ更新
```bash
# アプリアイコン更新
derry gen-icon

# スプラッシュ画面更新
derry gen-splash
```

## デバッグ

### ログ出力
```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('デバッグ情報');
logger.i('情報');
logger.w('警告');
logger.e('エラー');
```

### デバッグツール
- Flutter Inspector: ウィジェットツリー確認
- Dart DevTools: パフォーマンス分析
- `drift_db_viewer`: データベース確認

## トラブルシューティング

### よくある問題
1. **ビルドエラー**: `flutter clean && flutter pub get`
2. **コード生成エラー**: `derry gen` 再実行
3. **iOS ビルドエラー**: `cd ios && pod install`
4. **Android ビルドエラー**: Gradle設定確認

### パフォーマンス最適化
- 不要な rebuild を避ける
- const constructor の使用
- ListView.builder の使用
- 画像の最適化