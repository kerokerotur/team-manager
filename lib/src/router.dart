import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/src/sample.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      builder: (BuildContext context, GoRouterState state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: '/sample',
      name: '/sample',
      builder: (BuildContext context, GoRouterState state) => const Sample(),
    ),
  ],
);
