import 'package:flutter/material.dart';
import 'package:flutter_template/src/common/domain/theme/theme_provider.dart';
import 'package:flutter_template/src/widgets/app_footer.dart';
import 'package:flutter_template/src/widgets/hamburger_menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      drawer: const HamburgerMenu(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // テーマ設定セクション
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'テーマ設定',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // ライトモード
                  ListTile(
                    leading: const Icon(Icons.light_mode),
                    title: const Text('ライトモード'),
                    trailing: Radio<AppThemeMode>(
                      value: AppThemeMode.light,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(themeModeProvider.notifier).setThemeMode(value);
                        }
                      },
                    ),
                    onTap: () {
                      ref.read(themeModeProvider.notifier).setThemeMode(AppThemeMode.light);
                    },
                  ),
                  // ダークモード
                  ListTile(
                    leading: const Icon(Icons.dark_mode),
                    title: const Text('ダークモード'),
                    trailing: Radio<AppThemeMode>(
                      value: AppThemeMode.dark,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(themeModeProvider.notifier).setThemeMode(value);
                        }
                      },
                    ),
                    onTap: () {
                      ref.read(themeModeProvider.notifier).setThemeMode(AppThemeMode.dark);
                    },
                  ),
                  // システム設定に従う
                  ListTile(
                    leading: const Icon(Icons.settings_system_daydream),
                    title: const Text('システム設定に従う'),
                    subtitle: const Text('デバイスの設定に基づいて自動切り替え'),
                    trailing: Radio<AppThemeMode>(
                      value: AppThemeMode.system,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(themeModeProvider.notifier).setThemeMode(value);
                        }
                      },
                    ),
                    onTap: () {
                      ref.read(themeModeProvider.notifier).setThemeMode(AppThemeMode.system);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // その他の設定（将来の拡張用）
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'その他の設定',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('通知設定'),
                    subtitle: const Text('イベントの通知を管理'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: 通知設定画面への遷移
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('言語設定'),
                    subtitle: const Text('アプリの表示言語を変更'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: 言語設定画面への遷移
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }
}
