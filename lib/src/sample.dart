import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_template/src/common/domain/locale/locales.dart';
import 'package:flutter_template/src/common/domain/locale/locales_provider.dart';
import 'package:flutter_template/src/const/env.dart';
import 'package:flutter_template/src/plugins/local_notifications/local_notification_service.dart';
import 'package:flutter_template/src/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sample extends ConsumerWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = SharedPreferences.getInstance();
    return Scaffold(
      appBar: AppBar(
        title: const Text('サンプルページ'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.all(100)),
          Text(Env.env),
          Text(AppLocalizations.of(context)!.sample),
          const Row(
            children: [
              Text('選択中の言語'),
            ],
          ),
          GestureDetector(
            onTap: () async {
              await ref.read(localesProvider.notifier).changeAppLocale(en);
            },
            child: const Text('英語'),
          ),
          GestureDetector(
            onTap: () async {
              await ref.read(localesProvider.notifier).changeAppLocale(ja);
            },
            child: const Text('日本語'),
          ),
          GestureDetector(
            onTap: () async {
              await ref.read(localesProvider.notifier).changeAppLocale(null);
            },
            child: const Text('端末の設定'),
          ),
          GestureDetector(
            onTap: () async {
              LocalNotificationService.showLocalNotification(
                'PUSH通知テスト',
                'PUSH通知のテスト送信です',
              );
            },
            child: const Text('PUSH通知送信'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        router.pushNamed('/');
      }),
    );
  }
}
