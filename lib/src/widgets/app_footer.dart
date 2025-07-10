import 'package:flutter/material.dart';
import 'package:flutter_template/src/router.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
      color: Colors.grey[200],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _FooterNavItem(
            icon: Icons.home,
            label: 'ホーム',
            routeName: '/',
          ),
          _FooterNavItem(
            icon: Icons.calendar_today,
            label: 'スケジュール',
            routeName: '/schedule',
          ),
          _FooterNavItem(
            icon: Icons.settings,
            label: '設定',
            routeName: '/settings',
          ),
        ],
      ),
    );
  }
}

class _FooterNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;

  const _FooterNavItem(
      {required this.icon, required this.label, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        router.pushNamed(routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Colors.grey),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
