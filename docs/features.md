# 機能仕様書

## 現在実装済み機能

### 1. ホーム画面（MyHomePage）
**場所**: `/lib/main.dart:47-115`

#### 機能概要
- アプリのメイン画面
- カウンター機能（サンプル実装）
- 画像・アニメーション表示

#### UI要素
- アプリバー
- ハンバーガーメニュー
- 中央コンテンツエリア
  - remainchan画像表示
  - Lottieアニメーション表示
  - カウンターテキスト
- フローティングアクションボタン
- ボトムナビゲーション

#### 操作
- FABタップでサンプルページ遷移（現在は未実装）

### 2. スケジュール画面（SchedulePage）
**場所**: `/lib/src/page/schedule.dart`

#### 機能概要
- カレンダー表示とイベント管理
- 月単位でのスケジュール表示
- イベント詳細表示

#### UI要素
- アプリバー（タイトル: "スケジュール"）
- ハンバーガーメニュー
- カレンダービュー（table_calendar使用）
- 選択日のイベント一覧

#### 操作
- 日付選択でイベント表示切り替え
- カレンダーページ送り
- イベントタップで詳細表示（現在はprint出力のみ）

#### データ構造
```dart
class Event {
  final String title;
}

Map<DateTime, List<Event>> _events = {
  DateTime.utc(2025, 7, 10): [Event('定例ミーティング')],
  DateTime.utc(2025, 7, 15): [Event('プロジェクトA締切'), Event('クライアント訪問')],
  DateTime.utc(2025, 7, 22): [Event('チームランチ')],
};
```

### 3. 設定画面（SettingsPage）
**場所**: `/lib/src/page/settings.dart`

#### 機能概要
- アプリ設定管理（基本実装のみ）

#### UI要素
- アプリバー（タイトル: "設定"）
- ハンバーガーメニュー
- 中央テキスト表示
- ボトムナビゲーション

### 4. 共通UI要素

#### ハンバーガーメニュー（HamburgerMenu）
**場所**: `/lib/src/widgets/hamburger_menu.dart`

- サイドナビゲーション
- 各画面への遷移機能

#### ボトムナビゲーション（AppFooter）
**場所**: `/lib/src/widgets/app_footer.dart`

- 画面下部のナビゲーション
- 主要画面への遷移機能

### 5. インフラ機能

#### 多言語対応
**場所**: `/lib/l10n/`, `/lib/gen_l10n/`

- 日本語・英語対応
- `AppLocalizations` による文字列管理
- システム言語自動検出

#### プッシュ通知
**場所**: `/lib/src/plugins/firebase/cloud_messaging.dart`

- Firebase Cloud Messaging連携
- アプリ初期化時に設定実行

#### ローカル通知
**場所**: `/lib/src/plugins/local_notifications/local_notification_service.dart`

- 端末ローカル通知機能
- 初期化処理実装済み

#### データベース
**場所**: `/lib/src/db/database.dart`

- Drift (SQLite) 使用
- テーブル定義:
  - `todos` テーブル（id, title, content, category）
  - `categories` テーブル（id, description）

## 今後実装予定の機能

### 1. ユーザー認証・管理
- ユーザー登録・ログイン
- プロフィール管理
- グループ参加・管理

### 2. イベント管理機能
- イベント作成・編集・削除
- イベント詳細情報入力
  - タイトル
  - 開催日時
  - 場所
  - 説明
  - 参加者設定

### 3. 出欠管理機能
- イベントごとの出欠確認
- 出欠状況の表示
- 出欠締切設定
- リマインダー機能

### 4. グループ機能
- チーム・グループ作成
- メンバー招待・管理
- 権限設定（管理者・メンバー）

### 5. 通知機能
- イベント通知
- 出欠締切通知
- 重要なお知らせ

### 6. データ同期
- クラウドデータベース連携
- オフライン対応
- データバックアップ・復元

### 7. カレンダー機能拡張
- 月表示・週表示・日表示切り替え
- イベント色分け
- 繰り返しイベント設定

### 8. 設定機能
- アプリテーマ変更
- 通知設定
- 言語設定
- データエクスポート機能

## API設計案

### イベント管理API
```dart
// イベント取得
Future<List<Event>> getEvents(DateTime startDate, DateTime endDate);

// イベント作成
Future<Event> createEvent(CreateEventRequest request);

// イベント更新
Future<Event> updateEvent(String eventId, UpdateEventRequest request);

// イベント削除
Future<void> deleteEvent(String eventId);
```

### 出欠管理API
```dart
// 出欠状況取得
Future<List<Attendance>> getAttendances(String eventId);

// 出欠登録
Future<Attendance> submitAttendance(String eventId, AttendanceStatus status);

// 出欠統計取得
Future<AttendanceSummary> getAttendanceSummary(String eventId);
```

### グループ管理API
```dart
// グループ一覧取得
Future<List<Group>> getGroups();

// グループ作成
Future<Group> createGroup(CreateGroupRequest request);

// メンバー招待
Future<void> inviteMember(String groupId, String email);
```