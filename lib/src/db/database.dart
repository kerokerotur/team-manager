import 'package:drift/drift.dart';
// 初期設定を定義するために以下のインポートを追加
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
// このファイルの名前が"database.dart"の場合は以下の名前で定義しておく。
// このタイミングだとファイルが存在しないためエラーが出るが、後の工程で自動作成される。
part 'database.g.dart';

// 以下の定義の場合だと"todos"というテーブルが作成される。
// 行単位のデータは"Todoクラス"になる。
// 　※Todoクラスはこの後の工程で自動で作成される。
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category => integer().nullable()();
}

// Driftでは行単位のデータを扱うクラスを作成するときはテーブルクラスから"s"を除いたものを作成するため、
// 単数形と複数形で形が異なる場合は"DataClassName"で単数形の名称を定義する必要がある。
// DataNameClassを定義しない場合は"Categorie"になってしまう。
@DataClassName('Category')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}

@DriftDatabase(tables: [Todos, Categories])
class MyDatabase extends _$MyDatabase {
  // コンストラクタでDBの保存先を定義する
  MyDatabase() : super(_openConnection());

  // マイグレーションを行う場合に使用ため、テーブルを追加／変更／削除する場合はこの値をインクリメントする
  @override
  int get schemaVersion => 1;

  Stream<List<Todo>> watchEntries() {
    return (select(todos)).watch();
  }

  //8
  //以下追記
  Future<List<Todo>> get allTodoEntries => select(todos).get();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // PCの場合はドキュメントフォルダに"db.sqlite"が作成される
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
