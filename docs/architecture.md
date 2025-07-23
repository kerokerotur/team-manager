# アーキテクチャ設計書

## アプリケーション構成

### レイヤー構成
```
┌─────────────────────────────────────┐
│           Presentation Layer         │
│  (Pages, Widgets, Router)           │
├─────────────────────────────────────┤
│           Application Layer          │
│  (Providers, State Management)      │
├─────────────────────────────────────┤
│             Domain Layer             │
│  (Entities, Repositories)           │
├─────────────────────────────────────┤
│         Infrastructure Layer         │
│  (Database, Firebase, Local Store)  │
└─────────────────────────────────────┘
```

## ディレクトリ構造詳細

### `/lib/src/common/`
共通機能とドメインロジックを配置

#### `/common/adapter/`
- `locales_repository.dart` - 言語設定のリポジトリ実装

#### `/common/domain/`
- `locale/` - 言語設定関連のドメインロジック
  - `abstract_locales_repository.dart` - 言語設定リポジトリの抽象化
  - `locales.dart` - 言語設定エンティティ
  - `locales_provider.dart` - 言語設定プロバイダー

### `/lib/src/const/`
アプリ全体で使用する定数

- `app_theme.dart` - アプリテーマ設定
- `env.dart` - 環境変数定義
- `shared_preferences_keys.dart` - ローカルストレージキー定義

### `/lib/src/data/`
データモデル定義

- `user.dart` - ユーザーデータモデル
- `user.freezed.dart` - Freezed自動生成ファイル
- `user.g.dart` - JSON serialization自動生成ファイル

### `/lib/src/db/`
データベース定義とアクセス層

- `database.dart` - Driftデータベース定義
- `database.g.dart` - Drift自動生成ファイル

### `/lib/src/page/`
画面コンポーネント

- `schedule.dart` - スケジュール画面
- `settings.dart` - 設定画面

### `/lib/src/plugins/`
外部サービス連携

#### `/firebase/`
- `cloud_messaging.dart` - Firebase Cloud Messaging設定

#### `/local_notifications/`
- `local_notification_service.dart` - ローカル通知サービス

### `/lib/src/widgets/`
再利用可能なUIコンポーネント

- `app_footer.dart` - ボトムナビゲーション
- `hamburger_menu.dart` - サイドメニュー

## 状態管理

### Riverpod構成
- **Provider**: 不変データの提供
- **StateProvider**: 単純な状態管理
- **StateNotifierProvider**: 複雑な状態変更ロジック

### 主要プロバイダー
- `localesProvider` - 言語設定管理

## ルーティング

### GoRouter設定
- フェードアニメーション付きページ遷移
- 宣言的ルーティング
- 型安全なナビゲーション

### ルート定義
```dart
/                 # ホーム画面
/schedule         # スケジュール画面  
/settings         # 設定画面
```

## データフロー

### 基本的なデータフロー
```
UI Event → Provider → Repository → Data Source
    ↑                                    ↓
UI Update ← State Change ← Data Processing
```

### 状態の流れ
1. UI イベント発生
2. Provider の notifier が状態を更新
3. Consumer Widget が再描画
4. 必要に応じてローカルストレージやデータベースに永続化

## 外部サービス連携

### Firebase
- **Firebase Core**: 基本設定
- **Firebase Messaging**: プッシュ通知

### ローカルストレージ
- **SharedPreferences**: 設定値保存
- **SQLite (Drift)**: 構造化データ保存

## セキュリティ考慮事項

### データ保護
- ローカルデータの暗号化検討
- APIキーの環境変数管理
- ユーザーデータの適切な権限管理

### 通信セキュリティ
- HTTPS通信の徹底
- 証明書ピニング検討
- トークンベース認証の実装予定