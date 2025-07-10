import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/src/page/schedule.dart';
import 'package:flutter_template/src/page/settings.dart';
import 'package:go_router/go_router.dart';

// フェードアニメーション付きページ生成の共通関数
CustomTransitionPage<T> fadeTransitionPage<T>(
    {required LocalKey key, required Widget child}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      pageBuilder: (context, state) => fadeTransitionPage(
        key: state.pageKey,
        child: const MyHomePage(title: ''),
      ),
    ),
    GoRoute(
      path: '/schedule',
      name: '/schedule',
      pageBuilder: (context, state) => fadeTransitionPage(
        key: state.pageKey,
        child: const SchedulePage(),
      ),
    ),
    GoRoute(
      path: '/settings',
      name: '/settings',
      pageBuilder: (context, state) => fadeTransitionPage(
        key: state.pageKey,
        child: const SettingsPage(),
      ),
    ),
  ],
);
