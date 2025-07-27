import 'package:flutter/material.dart';

class SelectionListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool showArrow;

  const SelectionListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: showArrow ? const Icon(Icons.arrow_forward_ios) : null,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}