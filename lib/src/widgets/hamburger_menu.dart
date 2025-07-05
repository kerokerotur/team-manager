
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              color: Colors.grey[850],
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text('Sample'),
            onTap: () {
              context.go('/sample');
            },
          ),
        ],
      ),
    );
  }
}
