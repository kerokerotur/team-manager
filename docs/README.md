# チーム管理アプリ（Team Manager）

## プロジェクト概要
スポーツチームなどの練習や試合等のイベントについて、グループメンバーの出欠確認を取りやすくするためのスケジュール管理アプリです。

## 技術スタック
- **フレームワーク**: Flutter 3.5.1
- **状態管理**: Riverpod + Hooks
- **ルーティング**: GoRouter
- **データベース**: Drift (SQLite)
- **Firebase**: Core, Messaging
- **多言語対応**: Flutter Localizations
- **UI**: Material Design

## 現在の実装状況

### 実装済み機能
1. **基本画面構成**
   - ホーム画面（MyHomePage）
   - スケジュール画面（SchedulePage）
   - 設定画面（SettingsPage）

2. **ナビゲーション**
   - ハンバーガーメニュー（HamburgerMenu）
   - ボトムナビゲーション（AppFooter）
   - フェードアニメーション付きページ遷移

3. **スケジュール機能**
   - カレンダー表示（table_calendar使用）
   - イベント表示とマーカー
   - 日付選択とイベント一覧表示

4. **インフラ機能**
   - 多言語対応（日本語・英語）
   - プッシュ通知（Firebase Messaging）
   - ローカル通知
   - データベース設定（Drift）

### アプリ構成

#### ディレクトリ構造
```
lib/
├── main.dart                 # アプリのエントリーポイント
├── firebase_options.dart     # Firebase設定
├── gen/                      # 自動生成ファイル
├── gen_l10n/                # 多言語対応生成ファイル
├── l10n/                    # 多言語対応リソース
└── src/
    ├── common/              # 共通機能
    │   ├── adapter/         # アダプター層
    │   └── domain/          # ドメイン層
    ├── const/               # 定数定義
    ├── data/                # データモデル
    ├── db/                  # データベース定義
    ├── extension/           # 拡張機能
    ├── page/                # 画面
    ├── plugins/             # プラグイン設定
    ├── router.dart          # ルーティング設定
    └── widgets/             # 共通ウィジェット
```

#### 主要画面とルート
- `/` - ホーム画面
- `/schedule` - スケジュール画面
- `/settings` - 設定画面

### 開発環境設定

#### 環境別実行コマンド
```bash
# 開発環境
derry run-dev

# ステージング環境  
derry run-stg

# 本番環境
derry run-prod
```

#### コード生成
```bash
# 各種コード自動生成
derry gen

# スプラッシュ画面生成
derry gen-splash

# アプリアイコン生成
derry gen-icon
```

### データベース設計

#### テーブル構成
1. **todos** - TODOアイテム
   - id (INTEGER, AUTO INCREMENT)
   - title (TEXT, 6-32文字)
   - content (TEXT)
   - category (INTEGER, NULL可)

2. **categories** - カテゴリ
   - id (INTEGER, AUTO INCREMENT)
   - description (TEXT)

### 今後の開発予定
- ユーザー認証機能
- イベント作成・編集機能
- 出欠管理機能
- グループ管理機能
- データベースとの連携強化

## 開発者向け情報

### 主要依存関係
- hooks_riverpod: 状態管理
- go_router: ルーティング
- drift: データベースORM
- table_calendar: カレンダーUI
- firebase_core, firebase_messaging: Firebase連携
- flutter_local_notifications: ローカル通知

### コード規約
- Dart/Flutter標準規約に準拠
- Freezedを使用したイミュータブルデータクラス
- Riverpodによる状態管理パターン