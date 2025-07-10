import 'package:flutter/material.dart';
import 'package:flutter_template/src/widgets/app_footer.dart';
import 'package:flutter_template/src/widgets/hamburger_menu.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      drawer: const HamburgerMenu(),
      body: const Center(
        child: Text('設定画面'),
      ),
      bottomNavigationBar: const AppFooter(),
    );
  }
}
