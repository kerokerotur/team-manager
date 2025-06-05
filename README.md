
# 環境構築/アプリ起動手順

## （推奨）fvmでflutterのversion管理をする
- flutterプロジェクト間で、flutterのバージョンが異なる場合、アプリを起動する度flutterのversionを変更する必要がある。
  - fvmを使うと、コマンド一つで使用するflutterのバージョンを変更することができる。
- fvmのインストール（dart環境がある前提）
  
  ```dart pub global activate fvm```

- この辺参考にして設定・使うと良さそう
  - https://zenn.dev/altiveinc/articles/flutter-version-management

- derryコマンド
  - scriptの実行に使う
  - 以下を参考に設定すべし
    - https://zenn.dev/k9i/articles/c54446a72f1f46

# ディレクトリ構成・アプリケーションアーキテクチャ

## ディレクトリ構成
```javascript
.
└── lib/
    └── src/
        ├── adapter/
        │   ├── firestore/
        │   │   ├── dto/
        │   │   │   └── ${XXX}_dto.dart // 多分これは必要になる。domainをそのままCRUDに使える場合は実装しなくてもいいと思う
        │   │   └── ${XXX}repository.dart // 単純なCRUD処理しか実装しないイメージ
        ├── application/
        │   └── ${context}/
        │       └── ${XXX}usecase.dart // なんらかのアクションごとに実装するイメージ。ex) ゲーム開始 -> start_game_usecaseなど
        │       └── repository/
        │           └── ${XXX}repository.dart // domainをinterfaceにする。この中でfirestore配下を使いながら、やりたいことを実現するイメージ
        ├── component // 共通で使用したいウィジェットはここ
        ├── const // 定数の定義はここ
        ├── domain/
        │   └── ${context}/
        │       └── ${XXX}.dart // domainになるべくロジックは閉じ込めたい
        ├── extension // dartはクラスの拡張ができるので、拡張の実装をする場合はここ
        └── page/
            └── ${pageName}/
                ├── ${XXX}_view.dart
                ├── ${XXX}_view_model.dart
                └── ${XXX}_presenter.dart // ユーザアクションによる関数はここに実装される。ここからusecaseを呼ぶイメージ
```

※ ディレクトリ構成は以下を使って記載しているので、メンテしたらここも更新してね♡

```
https://tree.nathanfriend.com/?s=(%27opti8s!(%27fancy6~fullPath!false~trailingSlash6~rootDot6)~7(%277%27libAsrc-adapterCfirestoreC*dtoC0_dto2032applicatio4usecase2**3C032comp8ent-c8st-domai42extensi8-page-5pageName)-929_model20_presenterB%27)~versi8!%271%27)*%20%20-A*0*5XXX)2B-3repository4n-5c8text)-05*%24(6!true7source!8on90_viewA%5Cn*B.dartC-*%01CBA987654320-*
```

## アプリケーションアーキテクチャ
- 以下ファイル参照
  - https://github.com/U-Nova/poker/blob/main/client/doc/%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%A2%E3%83%BC%E3%82%AD%E3%83%86%E3%82%AF%E3%83%81%E3%83%A3.drawio.png

# 開発Tips

## 環境変数の設定
- envファイルを修正するだけでOK
- 根本的な設定は以下を参考に実装している
  - https://zenn.dev/altiveinc/articles/separating-environments-in-flutter

## スプラッシュ画面の設定
- pubspec.yamlに設定を記載している
- `derry gen-splash`を実行する
- この辺を参考にして設定
  - https://zenn.dev/susatthi/articles/20220406-061305-flutter-native-splash

## アプリアイコンの設定
- flutter_launcher_icons-{FLAVOR}.yamlファイルを作成し、設定したいアイコン画像へのパスを作成する
- `derry gen-icon`を実行する

## アプリ名の設定
- .envファイルを修正する
- envファイルの内容をどうやって各プラットフォームに反映しているかは下記記事を参考
  - https://zenn.dev/altiveinc/articles/separating-environments-in-flutter

## 画像追加手順
- この辺を参考にして設定
  - https://flutter.salon/plugin/fluttergen/
- pubspec.yamlにフォルダを追記しないと自動生成対象にならないことに注意
- `derry gen`を実行する
- asset.gen.dartに自動生成されるので、画像ファイル名を型安全に使用できる

## domainの実装
- 基本的に`@freezed`を使用して実装する
- メリットは、copywithメソッドの自動生成と、jsonコンバータの自動生成をしてくれるところ
- この辺を参考にキャッチアップよろしく
  - https://zenn.dev/sae_eng/articles/ed68107fdae18d
- 自動生成は`derry gen`を実行する

## adapterの実装（firestore）
- `firestore/repository`配下はCRUD処理のみ提供する。必ず`FirestoreRepository`を継承すること
- firestoreはnoスキーマDBであり、データ整合成の担保をアプリでする必要がある。そこで、CRUDに使用するクラスは`FirebaseDto`クラスを継承しているクラスに限定する
- firestore用のdtoは、一意なIDを持つ（主キー）。IDはfirestore側で自動生成する方針にするため、fromJsonのコンバートには含めるが、toJsonのコンバートには含めないように実装している
- まー、基本は他の同ディレクトリのクラスを真似して実装してほしい。`FirestoreRepository`の実装を見ると何しているかわかるはず。
